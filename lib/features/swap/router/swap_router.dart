import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/swap/screens/swap.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routesClassName: "SwapRoutes",
  routes: <AutoRoute>[
    MaterialRoute(
      initial: true,
      page: SwapScreen,
    ),
  ],
)
class $SwapRouter {}
