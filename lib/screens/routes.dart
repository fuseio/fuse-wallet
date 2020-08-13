import 'package:auto_route/auto_route_annotations.dart';
import 'package:curadai/screens/home/home_page.dart';
import 'package:curadai/screens/misc/webview_page.dart';
import 'package:curadai/screens/route_guards.dart';
import 'package:curadai/screens/misc/lock_screen.dart';
import 'package:curadai/screens/misc/pincode_colored.dart';
import 'package:curadai/screens/misc/security.dart';
import 'package:curadai/screens/signup/recovery.dart';
import 'package:curadai/screens/signup/username.dart';
import 'package:curadai/screens/signup/signup.dart';
import 'package:curadai/screens/signup/verify.dart';
import 'package:curadai/screens/splash/splash.dart';
import 'package:curadai/screens/send_flow/send_amount.dart';
import 'package:curadai/screens/send_flow/send_review.dart';
import 'package:curadai/screens/send_flow/send_success.dart';
import 'package:curadai/screens/unknown_route.dart';

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
