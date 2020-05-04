import 'package:auto_route/auto_route_annotations.dart';
import 'package:localpay/screens/buy/business.dart';
import 'package:localpay/screens/buy/map.dart';
import 'package:localpay/screens/cash_home/cash_mode.dart';
import 'package:localpay/screens/cash_home/prize.dart';
import 'package:localpay/screens/cash_home/transaction_details.dart';
import 'package:localpay/screens/signup/recovery.dart';
import 'package:localpay/screens/signup/username.dart';
import 'package:localpay/screens/signup/signup.dart';
import 'package:localpay/screens/signup/verify.dart';
import 'package:localpay/screens/splash/splash.dart';
import 'package:localpay/screens/misc/pincode.dart';

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
