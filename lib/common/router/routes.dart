import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/features/account/router/router.dart';
import 'package:fusecash/features/buy/router/router.dart';
import 'package:fusecash/features/contacts/router/router.dart';
// import 'package:fusecash/features/earn/router/router.dart';
import 'package:fusecash/features/home/router/router.dart';
import 'package:fusecash/features/screens/main_screen.dart';
import 'package:fusecash/features/onboard/screens/security_screen.dart';
import 'package:fusecash/features/onboard/screens/restore_wallet_screen.dart';
import 'package:fusecash/features/onboard/screens/username_screen.dart';
import 'package:fusecash/features/onboard/screens/signup_screen.dart';
import 'package:fusecash/features/onboard/screens/verify_screen.dart';
import 'package:fusecash/features/screens/on_board_screen.dart';
import 'package:fusecash/features/screens/pincode_screen.dart';
import 'package:fusecash/features/screens/splash_screen.dart';
import 'package:fusecash/features/screens/webview_screen.dart';
import 'package:fusecash/features/swap/router/swap_router.dart';

export 'routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: ChooseSecurityOption),
    AutoRoute(page: PinCodeScreen),
    AutoRoute(page: RestoreFromBackupScreen),
    AutoRoute(page: OnBoardScreen),
    AutoRoute(page: SignUpScreen),
    AutoRoute(page: VerifyPhoneNumber),
    AutoRoute(page: UserNameScreen),
    AutoRoute(page: WebViewScreen, name: 'webview', fullscreenDialog: true),
    AutoRoute(
      page: MainScreen,
      guards: [AuthGuard],
      children: [
        homeTab,
        contactsTab,
        buyTab,
        swapTab,
        // earnTab,
        accountTab,
      ],
    ),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $RootRouter {}
