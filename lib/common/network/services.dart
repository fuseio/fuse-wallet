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
  RootRouter get roovtRouter => RootRouter(authGuard: AuthGuard());
}
