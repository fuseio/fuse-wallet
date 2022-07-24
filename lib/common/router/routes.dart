import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/features/account/router/router.dart';
import 'package:fusecash/features/home/router/router.dart';
import 'package:fusecash/features/onboard/screens/restore_wallet_screen.dart';
import 'package:fusecash/features/onboard/screens/security_screen.dart';
import 'package:fusecash/features/onboard/screens/signup_screen.dart';
import 'package:fusecash/features/onboard/screens/username_screen.dart';
import 'package:fusecash/features/onboard/screens/verify_screen.dart';
import 'package:fusecash/features/screens/main_screen.dart';
import 'package:fusecash/features/screens/on_board_screen.dart';
import 'package:fusecash/features/screens/pincode_screen.dart';
import 'package:fusecash/features/screens/splash_screen.dart';
import 'package:fusecash/features/screens/webview_screen.dart';
import 'package:fusecash/features/swap/router/swap_router.dart';
import 'package:fusecash/features/wallet/router/router.dart';

export 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: ChooseSecurityPage),
    AutoRoute(page: PinCodePage),
    AutoRoute(page: RestoreWalletPage),
    AutoRoute(page: OnBoardingPage),
    AutoRoute(page: SignUpPage),
    AutoRoute(page: VerifyPhoneNumberPage),
    AutoRoute(page: UserNamePage),
    AutoRoute(
      page: WebViewPage,
      name: 'webview',
      fullscreenDialog: true,
    ),
    AutoRoute(
      page: MainPage,
      guards: [AuthGuard],
      children: [
        homeTab,
        walletTab,
        swapTab,
        accountTab,
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $RootRouter {}
