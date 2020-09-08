import 'package:auto_route/auto_route_annotations.dart';
import 'package:peepl/screens/backup/done_backup.dart';
import 'package:peepl/screens/backup/show_mnemonic.dart';
import 'package:peepl/screens/backup/verify_mnemonic.dart';
import 'package:peepl/screens/home/screens/home.dart';
import 'package:peepl/screens/home/screens/transaction_details.dart';
import 'package:peepl/screens/home/screens/token_screen.dart';
import 'package:peepl/screens/misc/about.dart';
import 'package:peepl/screens/misc/protect_your_wallet.dart';
import 'package:peepl/screens/misc/settings.dart';
import 'package:peepl/screens/misc/switch_commmunity.dart';
import 'package:peepl/screens/trade/review_trade.dart';
import 'package:peepl/screens/trade/trade.dart';

@MaterialAutoRouter(routesClassName: "HomeRoutes", routes: <AutoRoute>[
  MaterialRoute(
    initial: true,
    page: MainHomeScreen,
  ),
  MaterialRoute(page: TransactionDetailsScreen),
  MaterialRoute(page: TokenScreen),
  MaterialRoute(page: TradeScreen),
  MaterialRoute(page: ReviewTradeScreen),
  MaterialRoute(page: AboutScreen),
  MaterialRoute(page: ShowMnemonic),
  MaterialRoute(page: VerifyMnemonic),
  MaterialRoute(page: DoneBackup),
  MaterialRoute(page: SettingsScreen),
  MaterialRoute(page: SwitchCommunityScreen),
  MaterialRoute(page: ProtectYourWallet),
])
class $HomeRouter {}
