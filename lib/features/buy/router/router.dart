import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/buy/screens/business.dart';
import 'package:fusecash/features/buy/screens/buy.dart';
import 'package:fusecash/features/buy/screens/map.dart';

@MaterialAutoRouter(
  routesClassName: "BusinessesRoutes",
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(
      initial: true,
      page: BuyScreen,
      name: 'buyScreen',
    ),
    MaterialRoute(page: BusinessPage),
    MaterialRoute(page: MapScreen),
  ],
)
class $BuyRouter {}
