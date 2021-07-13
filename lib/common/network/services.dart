import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:wallet_core/wallet_core.dart' show API, Graph;

@module
abstract class ServicesModule {
  @lazySingleton
  Graph get graph => Graph(
        dotenv.env['GRAPH_BASE_URL']!,
      );

  @lazySingleton
  API get api => API(
        dotenv.env['API_BASE_URL']!,
      );

  @singleton
  RootRouter get rootRouter => RootRouter(authGuard: AuthGuard());

  @singleton
  AppsflyerSdk get appsFlyer => AppsflyerSdk(
        AppsFlyerOptions(
          afDevKey: dotenv.env['APPS_FLYER_DEV_KEY']!,
          appId: '1559937899',
          showDebug: kDebugMode,
          timeToWaitForATTUserAuthorization: 30,
        ),
      );
}
