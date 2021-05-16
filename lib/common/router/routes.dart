import 'package:auto_route/auto_route.dart';
import 'package:fusecash/features/account/router/router.dart';
import 'package:fusecash/features/contacts/router/router.dart';
import 'package:fusecash/features/earn/router/router.dart';
import 'package:fusecash/features/home/router/router.dart';
import 'package:fusecash/features/home/screens/action_details.dart';
import 'package:fusecash/features/screens/home_screen.dart';
import 'package:fusecash/features/onboard/screens/security_screen.dart';
import 'package:fusecash/features/onboard/screens/restore_wallet_screen.dart';
import 'package:fusecash/features/onboard/screens/username_screen.dart';
import 'package:fusecash/features/onboard/screens/signup_screen.dart';
import 'package:fusecash/features/onboard/screens/verify_screen.dart';
import 'package:fusecash/features/screens/on_board_screen.dart';
import 'package:fusecash/features/screens/pincode_screen.dart';
import 'package:fusecash/features/screens/splash_screen.dart';
import 'package:fusecash/features/screens/send_amount.dart';
import 'package:fusecash/features/screens/send_review.dart';
import 'package:fusecash/features/screens/send_success.dart';
import 'package:fusecash/features/screens/webview_screen.dart';
import 'package:fusecash/features/swap/router/swap_router.dart';
import 'package:fusecash/features/swap/screens/review_swap.dart';
import 'package:fusecash/features/swap/screens/swap.dart';

export 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreen,
      initial: true,
    ),
    AutoRoute(
      page: SecurityScreen,
    ),
    AutoRoute(
      page: PinCodeScreen,
    ),
    AutoRoute(
      page: RecoveryPage,
    ),
    AutoRoute(
      page: OnBoardScreen,
    ),
    AutoRoute(
      page: SignUpScreen,
    ),
    AutoRoute(
      page: VerifyScreen,
    ),
    AutoRoute(
      page: UserNameScreen,
    ),
    AutoRoute(
      page: WebViewScreen,
      name: 'webview',
      fullscreenDialog: true,
    ),
    AutoRoute(
      page: ActionDetailsScreen,
    ),
    AutoRoute(
      page: SendAmountScreen,
    ),
    AutoRoute(
      page: SendReviewScreen,
    ),
    AutoRoute(
      page: SendSuccessScreen,
    ),
    // AutoRoute(
    //   page: SwapScreen,
    // ),
    AutoRoute(
      page: ReviewSwapScreen,
    ),
    AutoRoute(
      path: '/',
      page: MainHomeScreen,
      children: [
        homeTab,
        contactsTab,
        swapTab,
        earnTab,
        accountTab,
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $RootRouter {}
