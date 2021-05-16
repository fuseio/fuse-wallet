import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/earn/screens/earn.dart';
import 'package:fusecash/features/earn/screens/earn_coming_soon.dart';

const earnTab = AutoRoute(
  path: 'earn',
  name: 'earnTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      // initial: true,
      page: EarnScreen,
      name: 'earnScreen',
    ),
    AutoRoute(
      initial: true,
      page: EarnComingSoonScreen,
      name: 'earnComingSoonScreen',
    ),
  ],
);
