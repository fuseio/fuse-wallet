import 'package:auto_route/auto_route_annotations.dart';
import 'package:seedbed/screens/home/home_page.dart';
import 'package:seedbed/screens/misc/webview_page.dart';
import 'package:seedbed/screens/route_guards.dart';
import 'package:seedbed/screens/misc/lock_screen.dart';
import 'package:seedbed/screens/misc/pincode_colored.dart';
import 'package:seedbed/screens/misc/security.dart';
import 'package:seedbed/screens/signup/recovery.dart';
import 'package:seedbed/screens/signup/username.dart';
import 'package:seedbed/screens/signup/signup.dart';
import 'package:seedbed/screens/signup/verify.dart';
import 'package:seedbed/screens/splash/splash.dart';
import 'package:seedbed/screens/send_flow/send_amount.dart';
import 'package:seedbed/screens/send_flow/send_review.dart';
import 'package:seedbed/screens/send_flow/send_success.dart';
import 'package:seedbed/screens/unknown_route.dart';

@MaterialAutoRouter(generateNavigationHelperExtension: true, routes: [
  MaterialRoute(page: LockScreen, name: 'lockScreen', initial: true),
  MaterialRoute(page: SecurityScreen, name: 'securityScreen'),
  MaterialRoute(page: ColorsPincodeScreen, name: 'pincode'),
  MaterialRoute(page: RecoveryPage),
  MaterialRoute(page: SplashScreen),
  MaterialRoute(page: SignupScreen),
  MaterialRoute(page: VerifyScreen),
  MaterialRoute(page: UserNameScreen),
  MaterialRoute(page: WebViewPage, name: 'webview', fullscreenDialog: true),
  MaterialRoute(guards: [AuthGuard], page: HomePage),
  MaterialRoute(guards: [AuthGuard], page: SendAmountScreen),
  MaterialRoute(guards: [AuthGuard], page: SendReviewScreen),
  MaterialRoute(guards: [AuthGuard], page: SendSuccessScreen),
  AdaptiveRoute(path: '*', page: UnknownRouteScreen)
])
class $Router {}
