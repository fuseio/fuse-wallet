import 'package:auto_route/auto_route_annotations.dart';
import 'package:esol/screens/backup/show_mnemonic.dart';
import 'package:esol/screens/buy/business.dart';
import 'package:esol/screens/buy/buy.dart';
import 'package:esol/screens/buy/map.dart';
import 'package:esol/screens/profile/screen/profile.dart';

@MaterialAutoRouter(routesClassName: "BusinessesRoutes", routes: <AutoRoute>[
  MaterialRoute(initial: true, page: BuyScreen),
  MaterialRoute(page: BusinessPage),
  MaterialRoute(page: MapScreen),
  MaterialRoute(page: ProfileScreen),
  MaterialRoute(page: ShowMnemonic),
])
class $BuyRouter {}
