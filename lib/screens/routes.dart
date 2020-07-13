import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/cash_home/cash_mode.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/screens/misc/lock_screen.dart';
import 'package:fusecash/screens/misc/pincode_colored.dart';
import 'package:fusecash/screens/misc/security.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/splash/splash.dart';

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
