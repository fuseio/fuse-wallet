import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalrand/screens/backup/done_backup.dart';
import 'package:digitalrand/screens/backup/show_mnemonic.dart';
import 'package:digitalrand/screens/backup/verify_mnemonic.dart';
import 'package:digitalrand/screens/home/screens/home.dart';
import 'package:digitalrand/screens/home/screens/transaction_details.dart';
import 'package:digitalrand/screens/home/screens/token_screen.dart';
import 'package:digitalrand/screens/misc/about.dart';
import 'package:digitalrand/screens/misc/protect_your_wallet.dart';
import 'package:digitalrand/screens/misc/settings.dart';
import 'package:digitalrand/screens/misc/switch_commmunity.dart';
import 'package:digitalrand/screens/profile/screen/profile.dart';
import 'package:digitalrand/screens/trade/review_trade.dart';
import 'package:digitalrand/screens/trade/trade.dart';

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
