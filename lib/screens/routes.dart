import 'package:auto_route/auto_route_annotations.dart';
import 'package:farmly_ledger/screens/buy/business.dart';
import 'package:farmly_ledger/screens/buy/map.dart';
import 'package:farmly_ledger/screens/cash_home/cash_mode.dart';
import 'package:farmly_ledger/screens/cash_home/prize.dart';
import 'package:farmly_ledger/screens/cash_home/transaction_details.dart';
import 'package:farmly_ledger/screens/cash_home/webview_page.dart';
import 'package:farmly_ledger/screens/send/send_amount.dart';
import 'package:farmly_ledger/screens/send/send_review.dart';
import 'package:farmly_ledger/screens/send/send_success.dart';
import 'package:farmly_ledger/screens/signup/recovery.dart';
import 'package:farmly_ledger/screens/signup/username.dart';
import 'package:farmly_ledger/screens/signup/signup.dart';
import 'package:farmly_ledger/screens/signup/verify.dart';
import 'package:farmly_ledger/screens/splash/splash.dart';
import 'package:farmly_ledger/screens/misc/pincode.dart';

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
