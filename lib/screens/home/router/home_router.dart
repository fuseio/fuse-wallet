import 'package:auto_route/auto_route_annotations.dart';
import 'package:seedbed/screens/backup/done_backup.dart';
import 'package:seedbed/screens/backup/show_mnemonic.dart';
import 'package:seedbed/screens/backup/verify_mnemonic.dart';
import 'package:seedbed/screens/home/screens/home.dart';
import 'package:seedbed/screens/home/screens/transaction_details.dart';
import 'package:seedbed/screens/home/screens/token_screen.dart';
import 'package:seedbed/screens/misc/about.dart';
import 'package:seedbed/screens/misc/protect_your_wallet.dart';
import 'package:seedbed/screens/misc/settings.dart';
import 'package:seedbed/screens/misc/switch_commmunity.dart';
import 'package:seedbed/screens/profile/screen/profile.dart';
import 'package:seedbed/screens/reward/change_reward.dart';
import 'package:seedbed/screens/trade/review_trade.dart';
import 'package:seedbed/screens/trade/trade.dart';

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
  MaterialRoute(page: ChangeRewardScreen),
  MaterialRoute(page: ProfileScreen),
])
class $HomeRouter {}
