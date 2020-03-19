import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/buy/map.dart';
import 'package:fusecash/screens/cash_home/cash_mode.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/send_review.dart';
import 'package:fusecash/screens/send/send_success.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/misc/pincode.dart';

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
