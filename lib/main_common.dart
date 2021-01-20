import 'dart:async';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/app.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final envFile = env == 'prod' ? '.env' : '.env_qa';
  await DotEnv().load('environment/$envFile');
  configureDependencies(environment: env);
  Store<AppState> store = await AppFactory().getStore();
  await SentryFlutter.init(
    (options) {
      options.dsn = DotEnv().env['SENTRY_DSN'];
      options.serverName = DotEnv().env['API_BASE_URL'];
      options.environment = env;
    },
  );
  runZonedGuarded<Future<void>>(
      () async => runApp(
            MyApp(
              store: store,
            ),
          ), (
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
    if (!kReleaseMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}
