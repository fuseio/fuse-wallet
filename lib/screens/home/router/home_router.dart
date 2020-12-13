import 'package:auto_route/auto_route_annotations.dart';
import 'package:esol/screens/backup/done_backup.dart';
import 'package:esol/screens/backup/show_mnemonic.dart';
import 'package:esol/screens/backup/verify_mnemonic.dart';
import 'package:esol/screens/home/screens/home.dart';
import 'package:esol/screens/home/screens/transaction_details.dart';
import 'package:esol/screens/home/screens/token_screen.dart';
import 'package:esol/screens/misc/about.dart';
import 'package:esol/screens/misc/protect_your_wallet.dart';
import 'package:esol/screens/misc/settings.dart';
import 'package:esol/screens/misc/switch_commmunity.dart';
import 'package:esol/screens/profile/screen/profile.dart';
import 'package:esol/screens/trade/review_trade.dart';
import 'package:esol/screens/trade/trade.dart';

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
