import 'package:auto_route/auto_route_annotations.dart';
import 'package:localdolarmx/screens/buy/business.dart';
import 'package:localdolarmx/screens/buy/map.dart';
import 'package:localdolarmx/screens/cash_home/cash_mode.dart';
import 'package:localdolarmx/screens/cash_home/prize.dart';
import 'package:localdolarmx/screens/cash_home/transaction_details.dart';
import 'package:localdolarmx/screens/signup/recovery.dart';
import 'package:localdolarmx/screens/signup/username.dart';
import 'package:localdolarmx/screens/signup/signup.dart';
import 'package:localdolarmx/screens/signup/verify.dart';
import 'package:localdolarmx/screens/splash/splash.dart';
import 'package:localdolarmx/screens/misc/pincode.dart';

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
