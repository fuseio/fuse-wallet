import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:fusecash/app.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:redux/redux.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await DotEnv.load(fileName: 'environment/.env');
  configureDependencies();
  final Store<AppState> store = await AppFactory().getStore();
  await SentryFlutter.init(
    (options) {
      options.debug = !kReleaseMode;
      options.dsn = DotEnv.env['SENTRY_DSN'];
      options.serverName = DotEnv.env['API_BASE_URL'];
      options.environment = env;
    },
    appRunner: () => runApp(
      MyApp(
        store: store,
      ),
    ),
  );
}
