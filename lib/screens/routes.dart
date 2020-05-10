import 'package:auto_route/auto_route_annotations.dart';
import 'package:paywise/screens/buy/business.dart';
import 'package:paywise/screens/buy/map.dart';
import 'package:paywise/screens/cash_home/cash_mode.dart';
import 'package:paywise/screens/cash_home/prize.dart';
import 'package:paywise/screens/cash_home/transaction_details.dart';
import 'package:paywise/screens/signup/recovery.dart';
import 'package:paywise/screens/signup/username.dart';
import 'package:paywise/screens/signup/signup.dart';
import 'package:paywise/screens/signup/verify.dart';
import 'package:paywise/screens/splash/splash.dart';
import 'package:paywise/screens/misc/pincode.dart';

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
