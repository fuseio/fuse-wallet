import 'dart:async';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/app.dart';
import 'package:fusecash/constants/env.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.init();
  await DotEnv().load('environment/.env_qa');
  configureDependencies();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Store<AppState> store = await AppFactory().getStore();
  await SentryFlutter.init(
    (options) {
      options.dsn = UrlConstants.SENTRY_DSN;
      options.serverName = UrlConstants.API_BASE_URL;
      options.environment = Env.IS_DEBUG ? 'production' : 'development';
    },
  );
  runZonedGuarded<Future<void>>(() async => runApp(MyApp(store: store)), (
    Object error,
    StackTrace stackTrace,
  ) async {
    try {
      await Sentry.captureException(error, stackTrace: stackTrace);
    } catch (e) {
      log.error('Sending report to sentry.io failed: $e');
      log.error('Original error: $error');
    }
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    if (Env.IS_DEBUG) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}
