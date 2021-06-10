// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fusecash/models/app_state.dart';
// import 'package:fusecash/redux/reducers/app_reducer.dart';
// import 'package:fusecash/redux/state/secure_storage.dart';
// import 'package:redux_persist/redux_persist.dart';
// import 'package:redux_thunk/redux_thunk.dart';
// import 'package:redux/redux.dart';
// import 'package:redux_logging/redux_logging.dart';

// class AppFactory {
//   static late AppFactory _singleton;
//   late Store<AppState> _store;

//   AppFactory._();

//   factory AppFactory() {
//     // ignore: unnecessary_null_comparison
//     if (_singleton == null) {
//       _singleton = AppFactory._();
//     }
//     return _singleton;
//   }

//   Future<AppState> _loadState(persistor) async {
//     try {
//       final initialState = await persistor.load();
//       return initialState;
//     } on Exception {
//       return AppState.initial();
//     }
//   }

//   Future<Store<AppState>> getStore() async {
//     // ignore: unnecessary_null_comparison
//     if (_store == null) {
//       FlutterSecureStorage storage = new FlutterSecureStorage();
//       final Persistor<AppState> persistor = Persistor<AppState>(
//         storage: SecureStorage(storage = storage),
//         serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
//         debug: kDebugMode,
//       );
//       AppState initialState = await _loadState(persistor);
//       final List<Middleware<AppState>> wms = [
//         thunkMiddleware,
//         persistor.createMiddleware(),
//       ];

//       if (kDebugMode) {
//         wms.add(LoggingMiddleware.printer());
//       }

//       _store = Store<AppState>(
//         appReducer,
//         initialState: initialState,
//         middleware: wms,
//       );
//     }

//     return _store;
//   }
// }
