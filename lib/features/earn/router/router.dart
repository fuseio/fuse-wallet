import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/earn/screens/earn.dart';
import 'package:fusecash/features/earn/screens/earn_coming_soon.dart';

@MaterialAutoRouter(
  routesClassName: "EarnRoutes",
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(
      // initial: true,
      page: EarnScreen,
      name: 'earnScreen',
    ),
    MaterialRoute(
      initial: true,
      page: EarnComingSoonScreen,
      name: 'earnComingSoonScreen',
    ),
  ],
)
class $EarnRouter {}
