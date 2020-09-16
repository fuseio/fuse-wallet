import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:esol/redux/middlewares/auth_middleware.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/redux/reducers/app_reducer.dart';
import 'package:esol/redux/state/state_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
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
    bool inDebugMode = false;
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
          debug: isInDebugMode);

      AppState initialState;
      try {
        initialState = await persistor.load();
      } catch (e) {
        logger.severe('ERROR - getStore $e');
        initialState = new AppState.initial();
      }

      final List<Middleware<AppState>> wms = [];

      if (isInDebugMode) {
        wms.add(LoggingMiddleware<AppState>(
            logger: logger,
            level: Level.ALL,
            formatter: LoggingMiddleware.multiLineFormatter));
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
          printer: logger_package.PrettyPrinter(), output: output);

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
    String fullPhoneNumber = store.state.userState.normalizedPhoneNumber ?? '';
    String username = store.state.userState.displayName ?? '';
    User user = new User(id: fullPhoneNumber, username: username);

    final SentryClient sentry = new SentryClient(
        dsn: DotEnv().env['SENTRY_DSN'],
        environmentAttributes: Event(
            serverName: DotEnv().env['API_BASE_URL'],
            release: versionName + ":" + versionCode,
            environment: DotEnv().env['MODE'],
            contexts: new Contexts(
                device: device,
                app: App(name: 'ESOL'),
                operatingSystem: operatingSystem),
            userContext: user));

    return sentry;
  }

  Future<void> reportError(dynamic error, {dynamic stackTrace}) async {
    _sentry = await getSentry();
    _sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
