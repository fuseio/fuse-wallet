import 'package:flutter/foundation.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:fusecash/redux/state/secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

final Persistor<AppState> persistor = Persistor<AppState>(
  storage: getIt<SecureStorage>(),
  serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
  debug: kDebugMode,
);

List<Middleware<AppState>> createMiddleware() => <Middleware<AppState>>[
      thunkMiddleware,
      persistor.createMiddleware(),
      kDebugMode ? LoggingMiddleware.printer() : null,
    ]..where((element) => element != null);

Future<Store<AppState>> createStore() async {
  final _initialState = await _loadState();
  Store<AppState> store = Store(
    appReducer,
    initialState: _initialState,
    middleware: createMiddleware(),
  );
  return store;
}

Future<AppState> _loadState() async {
  try {
    final initialState = await persistor.load();
    return initialState;
  } on Exception {
    // Re-hydration error
    return AppState.initial();
  }
}
