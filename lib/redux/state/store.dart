import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/redux/reducers/app_reducer.dart';
import 'package:paywise/redux/state/state_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:paywise/services.dart';
import 'package:logging/logging.dart';
import 'package:logger/logger.dart' as logger_package;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_segment/flutter_segment.dart';

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

  AppFactory._();

  factory AppFactory() {
    if (_singleton == null) {
      _singleton = AppFactory._();
    }
    return _singleton;
  }

  Future<Store<AppState>> getStore() async {
    if (_store == null) {
      final Logger logger = await getLogger('action');
      bool isDevelopment = DotEnv().env['MODE'] == 'development';
      await FlutterSegment.track(eventName: "PAYWISE: Application Opened");
      FlutterSecureStorage storage = new FlutterSecureStorage();

      final persistor = Persistor<AppState>(
        storage: SecureStorage(storage = storage),
        serializer: JsonSerializer<AppState>(AppState.fromJson),
        debug: isDevelopment
      );

      AppState initialState;
      try {
        initialState = await persistor.load();
        if (initialState?.userState?.jwtToken != '') {
          logger.info('jwt: ${initialState.userState.jwtToken}');
          logger.info('accountAddress: ${initialState.userState.accountAddress}');
          api.setJwtToken(initialState.userState.jwtToken);
        } else {
          logger.info('no JWT');
        }
      } catch (e) {
        logger.severe('ERROR - getStore $e');
        initialState = new AppState.initial();
      }

      final List<Middleware<AppState>> wms = [];
      if (isDevelopment) {
        wms.add(LoggingMiddleware<AppState>(logger:logger, level: Level.ALL, formatter: LoggingMiddleware.multiLineFormatter));
      }
      wms.addAll([
        thunkMiddleware,
        persistor.createMiddleware(),
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
      var output = new ConsoleOutput(file);

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
}
