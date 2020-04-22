import 'package:auto_route/auto_route_annotations.dart';
import 'package:supervecina/screens/buy/business.dart';
import 'package:supervecina/screens/buy/map.dart';
import 'package:supervecina/screens/cash_home/cash_mode.dart';
import 'package:supervecina/screens/cash_home/prize.dart';
import 'package:supervecina/screens/cash_home/transaction_details.dart';
import 'package:supervecina/screens/signup/recovery.dart';
import 'package:supervecina/screens/signup/username.dart';
import 'package:supervecina/screens/signup/signup.dart';
import 'package:supervecina/screens/signup/verify.dart';
import 'package:supervecina/screens/splash/splash.dart';
import 'package:supervecina/screens/misc/pincode.dart';

@MaterialAutoRouter()
class $Router {
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  PincodeScreen pincodeScreen;
  @initial
  CashModeScaffold cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
  MapScreen mapScreen;
  PrizeScreen prizeScreen;
}
