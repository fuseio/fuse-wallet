import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:fusecash/utils/storage.dart';

class ReduxService {
  final Store<AppState> _store;

  ReduxService(Store<AppState> store) : _store = store;

  static ReduxService? _instance;

  Store<AppState> get store => _store;

  static Future<ReduxService> initStore() async {
    final Persistor<AppState> persistor = Persistor<AppState>(
      storage: SecureStorage(const FlutterSecureStorage()),
      serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
      debug: !kReleaseMode,
    );

    AppState initialState = await _loadState(persistor);

    final List<Middleware<AppState>> wms = [
      thunkMiddleware,
      persistor.createMiddleware(),
    ];

    if (!kReleaseMode) {
      wms.add(LoggingMiddleware.printer());
    }

    _instance = ReduxService(
      Store<AppState>(
        appReducer,
        initialState: initialState,
        middleware: wms,
      ),
    );

    return _instance!;
  }

  static Future<AppState> _loadState(Persistor<AppState> persistor) async {
    try {
      final AppState? initialState = await persistor.load();
      return initialState ?? AppState.initial();
    } catch (e, s) {
      if (kDebugMode) {
        print('Load AppState failed ${e.toString()} ${s.toString()}');
      }
      return AppState.initial();
    }
  }
}
