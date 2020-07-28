import 'package:auto_route/auto_route_annotations.dart';
import 'package:seedbed/screens/buy/business.dart';
import 'package:seedbed/screens/buy/buy.dart';
import 'package:seedbed/screens/buy/map.dart';

@MaterialAutoRouter(
  routesClassName: "BusinessesRoutes",
  routes: <AutoRoute>[
  MaterialRoute(initial: true, page: BuyScreen),
  MaterialRoute(page: BusinessPage),
  MaterialRoute(page: MapScreen),
])
class $BuyRouter {}
