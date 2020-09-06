import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalrand/screens/buy/business.dart';
import 'package:digitalrand/screens/buy/buy.dart';
import 'package:digitalrand/screens/buy/map.dart';

@MaterialAutoRouter(
  routesClassName: "BusinessesRoutes",
  routes: <AutoRoute>[
  MaterialRoute(initial: true, page: BuyScreen),
  MaterialRoute(page: BusinessPage),
  MaterialRoute(page: MapScreen),
])
class $BuyRouter {}
