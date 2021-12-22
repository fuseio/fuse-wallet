import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/app.dart';
import 'package:fusecash/firebase_options.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/utils/storage.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

Future<AppState> loadState(Persistor<AppState> persistor) async {
  try {
    final AppState? initialState = await persistor.load();
    return initialState ?? AppState.initial();
  } catch (e, s) {
    if (!kReleaseMode) {
      print('Load AppState failed ${e.toString()} ${s.toString()}');
    }
    return AppState.initial();
  }
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await dotenv.load(fileName: 'environment/.env');
    await configureDependencies();
    final Persistor<AppState> persistor = Persistor<AppState>(
      storage: SecureStorage(FlutterSecureStorage()),
      serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
      debug: !kReleaseMode,
    );
    AppState initialState = await loadState(persistor);
    final List<Middleware<AppState>> wms = [
      thunkMiddleware,
      persistor.createMiddleware(),
    ];
    if (!kReleaseMode) {
      wms.add(LoggingMiddleware.printer());
    }

    final Store<AppState> store = Store<AppState>(
      appReducer,
      initialState: initialState,
      middleware: wms,
    );
    await SentryFlutter.init(
      (options) {
        options.debug = !kReleaseMode;
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.environment = kReleaseMode ? 'prod' : 'dev';
      },
    );
    runApp(MyApp(store));
  }, (exception, stackTrace) async {
    if (kReleaseMode) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    } else {
      print('FlutterError exception: ${exception.toString()}');
      print('FlutterError stackTrace: ${stackTrace.toString()}');
    }
  });
}
