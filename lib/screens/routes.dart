import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalrand/screens/home/home_page.dart';
import 'package:digitalrand/screens/misc/webview_page.dart';
import 'package:digitalrand/screens/route_guards.dart';
import 'package:digitalrand/screens/misc/lock_screen.dart';
import 'package:digitalrand/screens/misc/pincode_colored.dart';
import 'package:digitalrand/screens/misc/security.dart';
import 'package:digitalrand/screens/signup/recovery.dart';
import 'package:digitalrand/screens/signup/username.dart';
import 'package:digitalrand/screens/signup/signup.dart';
import 'package:digitalrand/screens/signup/verify.dart';
import 'package:digitalrand/screens/splash/splash.dart';
import 'package:digitalrand/screens/send_flow/send_amount.dart';
import 'package:digitalrand/screens/send_flow/send_review.dart';
import 'package:digitalrand/screens/send_flow/send_success.dart';
import 'package:digitalrand/screens/unknown_route.dart';

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
