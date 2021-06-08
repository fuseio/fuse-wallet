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

// MaterialRoute(page: SplashScreen, initial: true),
// MaterialRoute(page: ChooseSecurityOption),
// MaterialRoute(page: PinCodeScreen),
// MaterialRoute(page: RestoreFromBackupScreen),
// MaterialRoute(page: OnBoardScreen),
// MaterialRoute(page: SignUpScreen),
// MaterialRoute(page: VerifyPhoneNumber),
// MaterialRoute(page: UserNameScreen),
// MaterialRoute(page: WebViewScreen, name: 'webview', fullscreenDialog: true),
// MaterialRoute(
//     guards: [AuthGuard], page: MainHomeScreen, name: 'homeScreen'),
// MaterialRoute(guards: [AuthGuard], page: ActionDetailsScreen),
// MaterialRoute(guards: [AuthGuard], page: SendAmountScreen),
// MaterialRoute(guards: [AuthGuard], page: SendReviewScreen),
// MaterialRoute(guards: [AuthGuard], page: SendSuccessScreen),
// MaterialRoute(guards: [AuthGuard], page: SwapScreen),
// MaterialRoute(guards: [AuthGuard], page: ReviewSwapScreen),
// MaterialRoute(
//   page: ContactsList,
//   guards: [AuthGuard],
// ),
// AdaptiveRoute(path: '*', page: UnknownRouteScreen)

export 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreen,
      initial: true,
    ),
    AutoRoute(
      page: ChooseSecurityOption,
    ),
    AutoRoute(
      page: PinCodeScreen,
    ),
    AutoRoute(
      page: RestoreFromBackupScreen,
    ),
    AutoRoute(
      page: OnBoardScreen,
    ),
    AutoRoute(
      page: SignUpScreen,
    ),
    AutoRoute(
      page: VerifyPhoneNumber,
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
