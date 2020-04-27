import 'package:auto_route/auto_route_annotations.dart';
import 'package:bit2c/screens/buy/business.dart';
import 'package:bit2c/screens/buy/map.dart';
import 'package:bit2c/screens/cash_home/cash_mode.dart';
import 'package:bit2c/screens/cash_home/prize.dart';
import 'package:bit2c/screens/cash_home/transaction_details.dart';
import 'package:bit2c/screens/signup/recovery.dart';
import 'package:bit2c/screens/signup/username.dart';
import 'package:bit2c/screens/signup/signup.dart';
import 'package:bit2c/screens/signup/verify.dart';
import 'package:bit2c/screens/splash/splash.dart';
import 'package:bit2c/screens/misc/pincode.dart';

@MaterialAutoRouter()
class $Router {
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  PincodeScreen pincodeScreen;
  CashModeScaffold cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
  MapScreen mapScreen;
  PrizeScreen prizeScreen;
}
