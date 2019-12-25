

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart' as prefix0;
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

Future<File> getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File(directory.path+"/logs.txt");
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
    //storage: FlutterStorage(key: "app6"),
    storage: SecureStorage(storage= storage),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  AppState initialState;
  try {
    initialState = await persistor.load();
    if (initialState.userState?.jwtToken != '') {
      logger.d('jwt: ${initialState.userState.jwtToken}');
      logger.d('accountAddress: ${initialState.userState.accountAddress}');
      api.setJwtToken(initialState.userState.jwtToken);
    } else {
      logger.d('no JWT');
    }

  }
  catch (e) {
    logger.e(e);
    initialState = null;
  }
  

  // logger.onRecord
  final mylogger = new Logger("Redux Logger");

  mylogger.onRecord
    // Filter down to [LogRecord]s sent to your logger instance  
    .where((record) => record.loggerName == mylogger.name)
    // Print them out (or do something more interesting!)
    . listen((loggingMiddlewareRecord) => logger.d(loggingMiddlewareRecord));

  return Store<AppState>(
      appReducer,
      initialState: initialState ?? new AppState.initial(),
        // middleware: [thunkMiddleware, persistor.createMiddleware()]
      middleware: [thunkMiddleware, new LoggingMiddleware(logger: mylogger), persistor.createMiddleware()]
  );
}
