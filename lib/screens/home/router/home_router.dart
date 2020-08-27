import 'package:auto_route/auto_route_annotations.dart';
import 'package:ceu_do_mapia/screens/backup/done_backup.dart';
import 'package:ceu_do_mapia/screens/backup/show_mnemonic.dart';
import 'package:ceu_do_mapia/screens/backup/verify_mnemonic.dart';
import 'package:ceu_do_mapia/screens/home/screens/home.dart';
import 'package:ceu_do_mapia/screens/home/screens/transaction_details.dart';
import 'package:ceu_do_mapia/screens/home/screens/token_screen.dart';
import 'package:ceu_do_mapia/screens/misc/about.dart';
import 'package:ceu_do_mapia/screens/misc/protect_your_wallet.dart';
import 'package:ceu_do_mapia/screens/misc/settings.dart';
import 'package:ceu_do_mapia/screens/misc/switch_commmunity.dart';
import 'package:ceu_do_mapia/screens/trade/review_trade.dart';
import 'package:ceu_do_mapia/screens/trade/trade.dart';

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
