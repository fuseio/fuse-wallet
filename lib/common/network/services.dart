import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:injectable/injectable.dart';

import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/common/router/routes.dart';

@module
abstract class ServicesModule {
  @lazySingleton
  Graph get graph => Graph();

  @lazySingleton
  ChargeApi get chargeApi => ChargeApi(
        dotenv.env['PROJECT_API_KEY']!,
      );

  @lazySingleton
  RootRouter get rootRouter => RootRouter(
        authGuard: AuthGuard(),
      );

  @lazySingleton
  FuseExplorer get fuseExplorerAPI => FuseExplorer(
        getIt<Dio>(),
      );
}
