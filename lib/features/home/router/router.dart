import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/home/screens/action_details.dart';
import 'package:fusecash/features/home/screens/home.dart';

const homeTab = AutoRoute(
  path: 'home',
  name: 'homeTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: HomePage,
    ),
    AutoRoute(
      page: ActionDetailsPage,
      path: 'action-details',
    ),
  ],
);
