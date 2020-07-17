import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/home/screens/home.dart';
import 'package:fusecash/screens/home/screens/transaction_details.dart';
import 'package:fusecash/screens/home/widgets/token_transfers.dart';
import 'package:fusecash/screens/trade/trade.dart';

@MaterialAutoRouter(routesClassName: "HomeRoutes", routes: <AutoRoute>[
  MaterialRoute(
    initial: true,
    page: MainHomeScreen,
  ),
  MaterialRoute(page: TransactionDetailsScreen),
  MaterialRoute(page: TokenTransfersScreen),
  MaterialRoute(page: TradeScreen),
])
class $HomeRouter {}