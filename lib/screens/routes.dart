import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/buy/map.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/cash_home/cash_mode.dart';
import 'package:fusecash/screens/cash_home/dai_explained.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';
import 'package:fusecash/screens/pro_mode/token_transfers.dart';
import 'package:fusecash/screens/route_guards.dart';
import 'package:fusecash/screens/send/contacts_list.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/misc/pincode.dart';
import 'package:fusecash/screens/trade/trade.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(path: '/recovery', page: RecoveryPage),
  MaterialRoute(path: '/splash', page: SplashScreen),
  MaterialRoute(path: '/signup', page: SignupScreen),
  MaterialRoute(path: '/verify', page: VerifyScreen),
  MaterialRoute(path: '/username', page: UserNameScreen),
  MaterialRoute(
    initial: true,
    guards: [AuthGuard],
    page: MainNavigator,
    children: <AutoRoute>[
      MaterialRoute(
        initial: true,
        page: CashModeScaffold,
      ),
      MaterialRoute(
          path: '/transaction_details', page: TransactionDetailsScreen),
      MaterialRoute(path: '/asset_screen', page: TokenTransfersScreen),
      // MaterialRoute(
      //   path: '/buy',
      //   page: BuyNavigator,
      //   children: <AutoRoute>[
      //     MaterialRoute(initial: true, page: BuyScreen),
      //     MaterialRoute(path: '/business', page: BusinessPage),
      //   ],
      // ),
      // MaterialRoute(path: '/contacts', page: ContactsList),
      // MaterialRoute(path: '/empty_contacts', page: SendToContactScreen),
      // MaterialRoute(path: '/webview', page: WebViewPage),
      // MaterialRoute(path: '/daip_explained', page: DaiExplainedScreen),
      MaterialRoute(path: '/trade', page: TradeScreen),
      // MaterialRoute(path: '/receive', page: ReceiveScreen),
    ],
  ),
])
class $Router {}
