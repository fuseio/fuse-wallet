import 'package:auto_route/auto_route_annotations.dart';
import 'package:peepl/screens/topup/screens/topup.dart';
import 'package:peepl/screens/topup/screens/topup_explained.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routesClassName: "TopupRoutes",
  routes: <AutoRoute>[
    MaterialRoute(
      // initial: true,
      page: TopupExplained,
    ),
    MaterialRoute(
      page: TopupScreen,
      initial: true,
    ),
  ],
)
class $TopupRouter {}
