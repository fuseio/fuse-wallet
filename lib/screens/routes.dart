import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalrand/screens/backup/show_mnemonic.dart';
import 'package:digitalrand/screens/buy/business.dart';
import 'package:digitalrand/screens/cash_home/cash_mode.dart';
import 'package:digitalrand/screens/cash_home/transaction_details.dart';
import 'package:digitalrand/screens/misc/lock_screen.dart';
import 'package:digitalrand/screens/misc/pincode_colored.dart';
import 'package:digitalrand/screens/misc/security.dart';
import 'package:digitalrand/screens/signup/recovery.dart';
import 'package:digitalrand/screens/signup/username.dart';
import 'package:digitalrand/screens/signup/signup.dart';
import 'package:digitalrand/screens/signup/verify.dart';
import 'package:digitalrand/screens/splash/splash.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  LockScreen lockScreen;
  ShowMnemonic backupScreen;
  SecurityScreen securityScreen;
  ColorsPincodeScreen pincode;
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  CashModeScaffold cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
}
