import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/home/home_page.dart';
import 'package:fusecash/screens/misc/webview_page.dart';
import 'package:fusecash/screens/route_guards.dart';
import 'package:fusecash/screens/misc/lock_screen.dart';
import 'package:fusecash/screens/misc/pincode_colored.dart';
import 'package:fusecash/screens/misc/security.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/splash/splash.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: LockScreen, name: 'lockScreen', initial: true),
  MaterialRoute(page: ShowMnemonic, name: 'backupScreen'),
  MaterialRoute(page: SecurityScreen, name: 'securityScreen'),
  MaterialRoute(page: ColorsPincodeScreen, name: 'pincode'),
  MaterialRoute(page: RecoveryPage),
  MaterialRoute(page: SplashScreen),
  MaterialRoute(page: SignupScreen),
  MaterialRoute(page: VerifyScreen),
  MaterialRoute(page: UserNameScreen),
  MaterialRoute(page: WebViewPage, name: 'webview'),
  MaterialRoute(guards: [AuthGuard], page: HomePage),
])
class $Router {}
