import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/home/screens/home.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routesClassName: "HomeRoutes",
  routes: <AutoRoute>[
    MaterialRoute(
      initial: true,
      page: HomeScreen,
      name: 'homeScreen',
    ),
  ],
)
class $HomeRouter {}
