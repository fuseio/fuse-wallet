import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_champions/redux/middlewares/auth_middleware.dart';
import 'package:local_champions/models/app_state.dart';
import 'package:local_champions/redux/reducers/app_reducer.dart';
import 'package:local_champions/redux/state/state_secure_storage.dart';
import 'package:local_champions/utils/phone.dart';
import 'package:local_champions/utils/jwt.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:local_champions/services.dart';
import 'package:logging/logging.dart';
import 'package:logger/logger.dart' as logger_package;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sentry/sentry.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';

Future<File> getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File(directory.path + "/logs.txt");
}

class ConsoleOutput extends logger_package.LogOutput {
  File file;
  ConsoleOutput(File _file) {
    file = _file;
  }

  @override
  void output(logger_package.OutputEvent event) async {
    for (var line in event.lines) {
      print(line);
      await file.writeAsString(line + '\n', mode: FileMode.append);
    }
  }
}

class AppFactory {
  static AppFactory _singleton;
  Map<String, Logger> _loggers = {};
  Store<AppState> _store;
  SentryClient _sentry;


  AppFactory._();

  factory AppFactory() {
    if (_singleton == null) {
      _singleton = AppFactory._();
    }
    return _singleton;
  }

  bool get isInDebugMode {
    // Assume you're in production mode.
    bool inDebugMode = false;

    // Assert expressions are only evaluated during development. They are ignored
    // in production. Therefore, this code only sets `inDebugMode` to true
    // in a development environment.
    assert(inDebugMode = true);

    return inDebugMode;
  }

  Future<Store<AppState>> getStore() async {
    if (_store == null) {
      final Logger logger = await getLogger('action');
      FlutterSecureStorage storage = new FlutterSecureStorage();

      final persistor = Persistor<AppState>(
        storage: SecureStorage(storage = storage),
        serializer: JsonSerializer<AppState>(AppState.fromJson),
        debug: isInDebugMode
      );

      AppState initialState;
      try {
        initialState = await persistor.load();
        if (initialState?.userState?.jwtToken != '') {
          String jwtToken = initialState.userState.jwtToken;
          Map<String, dynamic> tokenData = parseJwt(jwtToken);
          DateTime exp = new DateTime.fromMillisecondsSinceEpoch(tokenData['exp'] * 1000);
          DateTime now = DateTime.now();
          Duration diff = exp.difference(now);
          logger.info('diff', diff);

          if (diff.inDays <= 1) {
            logger.info('relogin');
            final FirebaseUser currentUser = await firebaseAuth.currentUser();
            IdTokenResult token = await currentUser.getIdToken();
            jwtToken = await api.login(token.token, initialState.userState.accountAddress, initialState.userState.identifier);
          }

          logger.info('jwt: $jwtToken');
          logger.info(
              'accountAddress: ${initialState.userState.accountAddress}');
          api.setJwtToken(jwtToken);

        } else {
          logger.info('no JWT');
        }
      } catch (e) {
        logger.severe('ERROR - getStore $e');
        initialState = new AppState.initial();
      }

      final List<Middleware<AppState>> wms = [];

      if (isInDebugMode) {
        wms.add(LoggingMiddleware<AppState>(logger:logger, level: Level.ALL, formatter: LoggingMiddleware.multiLineFormatter));
      }
      wms.addAll([
        thunkMiddleware,
        persistor.createMiddleware(),
        ...createAuthMiddleware()
      ]);

      _store = Store<AppState>(
        appReducer,
        initialState: initialState,
        middleware: wms,
      );
    }

    return _store;
  }

  Future<Logger> getLogger(String name) async {
    if (_loggers[name] == null) {
      Logger.root.level = Level.ALL;
      File file = await getFile();
      ConsoleOutput output = new ConsoleOutput(file);

      logger_package.Logger logger = logger_package.Logger(
          printer: logger_package.PrettyPrinter(),
          output: output
      );

      final mylogger = Logger(name);
      mylogger.onRecord
          .where((LogRecord record) => record.loggerName == mylogger.name)
          .listen((LogRecord record) {
            if (record.level.name == 'INFO') {
              logger.wtf(record);
            } else if (record.level.name == 'DEBUG') {
              logger.d(record);
            } else if (record.level.name == 'ERROR') {
              logger.e(record);
            } else if (record.level.name == 'WARNING') {
              logger.w(record);
            } else if (record.level.name == 'FINE') {
              logger.i(record);
            } else if (record.level.name == 'SEVERE') {
              logger.e(record);
            }
      });
      _loggers[name] = mylogger;
    }
    return _loggers[name];
  }

  Future<SentryClient> getSentry() async {
    if (_sentry == null) {
      _sentry = await _setupSentry();
    }
    return _sentry;
  }

  Future<SentryClient> _setupSentry() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    String versionCode = packageInfo.buildNumber;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    Device device;
    OperatingSystem operatingSystem;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = new Device(
        name: androidInfo.device,
        family: androidInfo.brand,
        model: androidInfo.model,
        modelId: androidInfo.id,
        arch: androidInfo.hardware,
        manufacturer: androidInfo.manufacturer,
        brand: androidInfo.brand,
        simulator: !androidInfo.isPhysicalDevice,
      );
      operatingSystem = OperatingSystem(
        name: Platform.operatingSystem,
        version: androidInfo.version.release,
        build: androidInfo.version.incremental,
      );

    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      device = new Device(
        name: iosInfo.name,
        family: iosInfo.localizedModel,
        model: iosInfo.model,
        modelId: iosInfo.systemVersion,
        arch: iosInfo.utsname.machine,
        manufacturer: "Apple",
        brand: iosInfo.localizedModel,
        simulator: !iosInfo.isPhysicalDevice,
      );

      operatingSystem = OperatingSystem(
        name: iosInfo.utsname.sysname,
        version: iosInfo.utsname.version,
        build: iosInfo.utsname.release,
        kernelVersion: iosInfo.utsname.machine,
      );
    }

    dynamic store = await getStore();
    String fullPhoneNumber = formatPhoneNumber(store.state.userState.phoneNumber, store.state.userState.countryCode) ?? '';
    String username = store.state.userState.displayName ?? '';
    User user = new User(id: fullPhoneNumber, username: username);

    final SentryClient sentry = new SentryClient(
        dsn: DotEnv().env['SENTRY_DSN'],
        environmentAttributes: new Event(
            serverName: DotEnv().env['API_BASE_URL'],
            release: versionName + ":" + versionCode,
            environment: DotEnv().env['MODE'],
            contexts: new Contexts(
                device: device,
                app: App(name: 'Local champions'),
                operatingSystem: operatingSystem
            ),
            userContext: user
        )
    );

    return sentry;
  }

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    _sentry = await getSentry();
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}