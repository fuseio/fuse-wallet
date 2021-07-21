import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/buy/screens/business.dart';
import 'package:fusecash/features/buy/screens/buy.dart';
import 'package:fusecash/features/screens/fuse_studio_explained.dart';

const buyTab = AutoRoute(
  path: 'buy',
  name: 'buyTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute(
      initial: true,
      page: BuyScreen,
    ),
    AutoRoute(
      page: BusinessScreen,
    ),
    AutoRoute(
      page: FusePointsExplainedScreen,
    ),
  ],
);
