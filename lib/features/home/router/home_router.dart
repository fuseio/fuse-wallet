import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/features/home/screens/done_backup_screen.dart';
import 'package:fusecash/features/home/screens/show_mnemonic.dart';
import 'package:fusecash/features/home/screens/verify_mnemonic.dart';
import 'package:fusecash/features/home/screens/home.dart';
import 'package:fusecash/features/home/screens/transaction_details.dart';
import 'package:fusecash/features/home/screens/token_screen.dart';
import 'package:fusecash/features/home/screens/about_screen.dart';
import 'package:fusecash/features/home/screens/protect_your_wallet.dart';
import 'package:fusecash/features/home/screens/settings.dart';
import 'package:fusecash/features/home/screens/switch_commmunity.dart';
import 'package:fusecash/features/home/screens/profile.dart';
import 'package:fusecash/features/home/screens/review_trade.dart';
import 'package:fusecash/features/home/screens/trade.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routesClassName: "HomeRoutes",
  routes: <AutoRoute>[
    MaterialRoute(
      initial: true,
      page: HomeScreen,
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
  ],
)
class $HomeRouter {}
