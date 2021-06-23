import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/app.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/storage.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fusecash/redux/reducers/app_reducer.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

Future<AppState> loadState(persistor) async {
  try {
    final initialState = await persistor.load();
    return initialState;
  } catch (e, s) {
    print('Load AppState failed ${e.toString()} ${s.toString()}');
    return AppState.initial();
  }
}

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Intercom.initialize(
    'sg9ivn0q',
    iosApiKey: 'ios_sdk-89c0f641881c39661aca9fd566898c054d061090',
    androidApiKey: 'android_sdk-a9f226699aab6c0f83e0e8a147234744929d2d0b',
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final envFile = env == 'prod' ? '.env' : '.env_qa';
  await dotenv.load(fileName: 'environment/$envFile');
  configureDependencies();
  FlutterSecureStorage storage = new FlutterSecureStorage();
  final Persistor<AppState> persistor = Persistor<AppState>(
    storage: SecureStorage(storage = storage),
    serializer: JsonSerializer<AppState>((json) => AppState.fromJson(json)),
    debug: kDebugMode,
  );
  AppState initialState = await loadState(persistor);
  final List<Middleware<AppState>> wms = [
    thunkMiddleware,
    persistor.createMiddleware(),
  ];

  if (kDebugMode) {
    wms.add(LoggingMiddleware.printer());
  }

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: wms,
  );

  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.debug = !kReleaseMode;
        options.dsn = dotenv.env['SENTRY_DSN'];
        options.environment = env;
      },
    );
    runApp(MyApp(store));
  }, (exception, stackTrace) async {
    if (kReleaseMode) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    } else {
      log.error('FlutterError exception: ${exception.toString()}');
      log.error('FlutterError stackTrace: ${stackTrace.toString()}');
    }
  });
}
