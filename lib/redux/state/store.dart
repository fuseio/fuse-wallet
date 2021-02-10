import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:fusecash/redux/state/secure_storage.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

final Persistor<AppState> persistor = Persistor<AppState>(
  storage: SecureStorage(new FlutterSecureStorage()),
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

class AppFactory {
  static AppFactory _singleton;
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
      FlutterSecureStorage storage = new FlutterSecureStorage();
      final Persistor<AppState> persistor = Persistor<AppState>(
        storage: SecureStorage(storage = storage),
        serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
        debug: kDebugMode,
      );
      AppState initialState;
      try {
        initialState = await persistor.load();
      } catch (e) {
        log.error('ERROR - getStore $e');
        initialState = AppState();
      }

      final List<Middleware<AppState>> wms = [
        thunkMiddleware,
        persistor.createMiddleware(),
      ];

      if (kDebugMode) {
        wms.add(LoggingMiddleware.printer());
      }

      _store = Store<AppState>(
        appReducer,
        initialState: initialState,
        middleware: wms,
      );
    }

    return _store;
  }
}
