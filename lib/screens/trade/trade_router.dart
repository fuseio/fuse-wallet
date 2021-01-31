import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/backup/done_backup.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/backup/verify_mnemonic.dart';
import 'package:fusecash/screens/home/screens/home.dart';
import 'package:fusecash/screens/home/screens/transaction_details.dart';
import 'package:fusecash/screens/home/screens/token_screen.dart';
import 'package:fusecash/screens/misc/about.dart';
import 'package:fusecash/screens/misc/protect_your_wallet.dart';
import 'package:fusecash/screens/misc/settings.dart';
import 'package:fusecash/screens/misc/switch_commmunity.dart';
import 'package:fusecash/screens/profile/screen/profile.dart';
import 'package:fusecash/screens/trade/review_trade.dart';
import 'package:fusecash/screens/trade/trade.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routesClassName: "TradeRoutes",
    routes: <AutoRoute>[
      MaterialRoute(
        initial: true,
        page: TradeScreen,
      ),
      MaterialRoute(page: ReviewTradeScreen),
    ])
class $TradeRouter {}
