

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:fusecash/redux/state/state_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

Future<Store<AppState>> createReduxStore() async {
    WidgetsFlutterBinding.ensureInitialized();
  var storage = new FlutterSecureStorage();
  final persistor = Persistor<AppState>(
    //storage: FlutterStorage(key: "app6"),
    storage: SecureStorage(storage= storage),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  var initialState;
  try {
    initialState = await persistor.load();
  }
  catch (e) {
    print(e);
    initialState = null;
  }
  
  return Store<AppState>(
      appReducer,
      initialState: initialState ?? new AppState.initial(),
      middleware: [thunkMiddleware, persistor.createMiddleware()]
  );
}
