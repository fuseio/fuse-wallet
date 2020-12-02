import 'package:auto_route/auto_route_annotations.dart';
import 'package:gooddollar/screens/backup/done_backup.dart';
import 'package:gooddollar/screens/backup/show_mnemonic.dart';
import 'package:gooddollar/screens/backup/verify_mnemonic.dart';
import 'package:gooddollar/screens/home/screens/home.dart';
import 'package:gooddollar/screens/home/screens/transaction_details.dart';
import 'package:gooddollar/screens/home/screens/token_screen.dart';
import 'package:gooddollar/screens/misc/about.dart';
import 'package:gooddollar/screens/misc/protect_your_wallet.dart';
import 'package:gooddollar/screens/misc/settings.dart';
import 'package:gooddollar/screens/misc/switch_commmunity.dart';
import 'package:gooddollar/screens/profile/screen/profile.dart';
import 'package:gooddollar/screens/trade/review_trade.dart';
import 'package:gooddollar/screens/trade/trade.dart';

@MaterialAutoRouter(
    generateNavigationHelperExtension: true,
    routesClassName: "HomeRoutes",
    routes: <AutoRoute>[
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
      MaterialRoute(page: ProfileScreen),
    ])
class $HomeRouter {}
