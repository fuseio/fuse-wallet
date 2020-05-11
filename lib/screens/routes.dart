import 'package:auto_route/auto_route_annotations.dart';
import 'package:digitalrand/screens/buy/business.dart';
import 'package:digitalrand/screens/buy/map.dart';
import 'package:digitalrand/screens/cash_home/cash_mode.dart';
import 'package:digitalrand/screens/cash_home/prize.dart';
import 'package:digitalrand/screens/cash_home/transaction_details.dart';
import 'package:digitalrand/screens/signup/recovery.dart';
import 'package:digitalrand/screens/signup/username.dart';
import 'package:digitalrand/screens/signup/signup.dart';
import 'package:digitalrand/screens/signup/verify.dart';
import 'package:digitalrand/screens/splash/splash.dart';
import 'package:digitalrand/screens/misc/pincode.dart';

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
