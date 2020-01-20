import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:fusecash/redux/state/state_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:fusecash/services.dart';
import 'package:logging/logging.dart';
import 'package:logger/logger.dart' as logger_package;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

Future<Store<AppState>> createReduxStore() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storage = new FlutterSecureStorage();

  File file = await getFile();
  var output = new ConsoleOutput(file);

  var logger = logger_package.Logger(
      printer: logger_package.PrettyPrinter(),
      output: output
  );

  final persistor = Persistor<AppState>(
    storage: SecureStorage(storage = storage),
    serializer: JsonSerializer<AppState>(AppState.fromJson)
  );

  AppState initialState;
  try {
    initialState = await persistor.load();
    if (initialState?.userState?.jwtToken != '') {
      logger.d('jwt: ${initialState.userState.jwtToken}');
      logger.d('accountAddress: ${initialState.userState.accountAddress}');
      api.setJwtToken(initialState.userState.jwtToken);
    } else {
      logger.d('no JWT');
    }
  } catch (e) {
    logger.e(e);
    initialState = new AppState.initial();
  }

  // logger.onRecord
  final mylogger = new Logger("Redux Logger");

  mylogger.onRecord
      // Filter down to [LogRecord]s sent to your logger instance
      .where((record) => record.loggerName == mylogger.name)
      // Print them out (or do something more interesting!)
      .listen((loggingMiddlewareRecord) => logger.d(loggingMiddlewareRecord));

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  void iosPermission() {
    var firebaseMessaging2 = firebaseMessaging;
    firebaseMessaging2.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  if (Platform.isIOS) iosPermission();
  var token = await firebaseMessaging.getToken();
  logger.wtf("token $token");
  await FlutterSegment.putDeviceToken(token);
  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      logger.wtf('onMessage called: $message');
    },
    onResume: (Map<String, dynamic> message) async {
      logger.wtf('onResume called: $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      logger.wtf('onLaunch called: $message');
    },
  );

  return Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: [
      thunkMiddleware,
      new LoggingMiddleware(logger: mylogger),
      persistor.createMiddleware()
    ]
  );
}
