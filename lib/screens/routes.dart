import 'package:auto_route/auto_route_annotations.dart';
import 'package:farmlyledger/screens/buy/business.dart';
import 'package:farmlyledger/screens/buy/map.dart';
import 'package:farmlyledger/screens/cash_home/cash_mode.dart';
import 'package:farmlyledger/screens/cash_home/prize.dart';
import 'package:farmlyledger/screens/cash_home/transaction_details.dart';
import 'package:farmlyledger/screens/signup/recovery.dart';
import 'package:farmlyledger/screens/signup/username.dart';
import 'package:farmlyledger/screens/signup/signup.dart';
import 'package:farmlyledger/screens/signup/verify.dart';
import 'package:farmlyledger/screens/splash/splash.dart';
import 'package:farmlyledger/screens/misc/pincode.dart';

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
