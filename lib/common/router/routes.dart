import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/features/screens/home_screen.dart';
import 'package:fusecash/features/onboard/screens/security_screen.dart';
import 'package:fusecash/features/onboard/screens/restore_wallet_screen.dart';
import 'package:fusecash/features/onboard/screens/username_screen.dart';
import 'package:fusecash/features/onboard/screens/signup_screen.dart';
import 'package:fusecash/features/onboard/screens/verify_screen.dart';
import 'package:fusecash/features/screens/splash_screen.dart';
import 'package:fusecash/features/screens/colored_pincode_screen.dart';
import 'package:fusecash/features/screens/lock_screen.dart';
import 'package:fusecash/features/screens/send_amount.dart';
import 'package:fusecash/features/screens/send_review.dart';
import 'package:fusecash/features/screens/send_success.dart';
import 'package:fusecash/features/screens/unknown_route.dart';
import 'package:fusecash/features/screens/webview_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: [
    MaterialRoute(page: LockScreen, name: 'lockScreen', initial: true),
    MaterialRoute(page: SecurityScreen, name: 'securityScreen'),
    MaterialRoute(page: ColoredPincodeScreen, name: 'pincode'),
    MaterialRoute(page: RecoveryPage),
    MaterialRoute(page: SplashScreen),
    MaterialRoute(page: SignupScreen),
    MaterialRoute(page: VerifyScreen),
    MaterialRoute(page: UserNameScreen),
    MaterialRoute(page: WebViewScreen, name: 'webview', fullscreenDialog: true),
    MaterialRoute(
        guards: [AuthGuard], page: MainHomeScreen, name: 'homeScreen'),
    MaterialRoute(guards: [AuthGuard], page: SendAmountScreen),
    MaterialRoute(guards: [AuthGuard], page: SendReviewScreen),
    MaterialRoute(guards: [AuthGuard], page: SendSuccessScreen),
    AdaptiveRoute(path: '*', page: UnknownRouteScreen)
  ],
)
class $Router {}
