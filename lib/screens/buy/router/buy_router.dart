import 'package:auto_route/auto_route_annotations.dart';
import 'package:supervecina/screens/buy/business.dart';
import 'package:supervecina/screens/buy/businesses_list_page.dart';
import 'package:supervecina/screens/buy/buy.dart';
import 'package:supervecina/screens/buy/map.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routesClassName: "BusinessesRoutes",
    routes: <AutoRoute>[
      MaterialRoute(initial: true, page: BuyScreen),
      MaterialRoute(page: BusinessesListScreen),
      MaterialRoute(page: BusinessPage),
      MaterialRoute(page: MapScreen),
    ])
class $BuyRouter {}
