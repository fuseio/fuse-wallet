import 'package:auto_route/auto_route_annotations.dart';
import 'package:supervenica/screens/buy/business.dart';
import 'package:supervenica/screens/buy/map.dart';
import 'package:supervenica/screens/cash_home/cash_mode.dart';
import 'package:supervenica/screens/cash_home/prize.dart';
import 'package:supervenica/screens/cash_home/transaction_details.dart';
import 'package:supervenica/screens/cash_home/webview_page.dart';
import 'package:supervenica/screens/send/send_amount.dart';
import 'package:supervenica/screens/send/send_review.dart';
import 'package:supervenica/screens/send/send_success.dart';
import 'package:supervenica/screens/signup/recovery.dart';
import 'package:supervenica/screens/signup/username.dart';
import 'package:supervenica/screens/signup/signup.dart';
import 'package:supervenica/screens/signup/verify.dart';
import 'package:supervenica/screens/splash/splash.dart';
import 'package:supervenica/screens/misc/pincode.dart';

@MaterialAutoRouter()
class $Router {
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  PincodeScreen pincodeScreen;
  CashModeScaffold cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  SendAmountScreen sendAmountScreen;
  SendReviewScreen sendReviewScreen;
  SendSuccessScreen sendSuccessScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
  MapScreen mapScreen;
  PrizeScreen prizeScreen;
  WebViewPage webViewPage;
}
