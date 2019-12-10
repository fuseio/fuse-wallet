

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:fusecash/redux/state/state_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:logging/logging.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:fusecash/services.dart';

Future<Store<AppState>> createReduxStore() async {
    WidgetsFlutterBinding.ensureInitialized();
  var storage = new FlutterSecureStorage();
  final persistor = Persistor<AppState>(
    //storage: FlutterStorage(key: "app6"),
    storage: SecureStorage(storage= storage),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  AppState initialState;
  try {
    initialState = await persistor.load();
    api.setJwtToken(initialState.userState.jwtToken);
  }
  catch (e) {
    print(e);
    initialState = null;
  }
  final logger = new Logger("Redux Logger");

  logger.onRecord
    // Filter down to [LogRecord]s sent to your logger instance  
    .where((record) => record.loggerName == logger.name)
    // Print them out (or do something more interesting!)
    . listen((loggingMiddlewareRecord) => print(loggingMiddlewareRecord));

  return Store<AppState>(
      appReducer,
      initialState: initialState ?? new AppState.initial(),
      middleware: [thunkMiddleware, new LoggingMiddleware(logger: logger), persistor.createMiddleware()]
  );
}
