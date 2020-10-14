import 'package:auto_route/auto_route_annotations.dart';
import 'package:bit2c/screens/backup/done_backup.dart';
import 'package:bit2c/screens/backup/show_mnemonic.dart';
import 'package:bit2c/screens/backup/verify_mnemonic.dart';
import 'package:bit2c/screens/home/screens/home.dart';
import 'package:bit2c/screens/home/screens/transaction_details.dart';
import 'package:bit2c/screens/home/screens/token_screen.dart';
import 'package:bit2c/screens/misc/about.dart';
import 'package:bit2c/screens/misc/protect_your_wallet.dart';
import 'package:bit2c/screens/misc/settings.dart';
import 'package:bit2c/screens/misc/switch_commmunity.dart';
import 'package:bit2c/screens/profile/screen/profile.dart';
import 'package:bit2c/screens/trade/review_trade.dart';
import 'package:bit2c/screens/trade/trade.dart';

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
