import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/features/earn/screens/earn.dart';

const earnTab = AutoRoute(
  path: 'earn',
  name: 'earnTab',
  page: EmptyRouterPage,
  guards: [AuthGuard],
  children: [
    AutoRoute(
      initial: true,
      page: EarnScreen,
      name: 'earn',
      guards: [AuthGuard],
    ),
  ],
);
