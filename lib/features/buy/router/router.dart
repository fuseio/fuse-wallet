import 'package:auto_route/auto_route.dart';
import 'package:supervecina/features/buy/screens/business.dart';
import 'package:supervecina/features/buy/screens/businesses_list_page.dart';
import 'package:supervecina/features/buy/screens/buy.dart';

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
      page: BusinessesListScreen,
    ),
    AutoRoute(
      page: BusinessScreen,
    ),
  ],
);
