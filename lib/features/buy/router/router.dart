import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/buy/screens/business.dart';
import 'package:fusecash/features/buy/screens/buy.dart';

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
  ],
);
