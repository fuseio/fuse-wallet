import 'package:auto_route/auto_route_annotations.dart';
import 'package:paywise/screens/backup/done_backup.dart';
import 'package:paywise/screens/backup/show_mnemonic.dart';
import 'package:paywise/screens/backup/verify_mnemonic.dart';
import 'package:paywise/screens/buy/buy.dart';
import 'package:paywise/screens/buy/business.dart';
import 'package:paywise/screens/buy/map.dart';
import 'package:paywise/screens/cash_home/cash_home.dart';
import 'package:paywise/screens/cash_home/dai_explained.dart';
import 'package:paywise/screens/cash_home/prize.dart';
import 'package:paywise/screens/cash_home/transaction_details.dart';
import 'package:paywise/screens/cash_home/webview_page.dart';
import 'package:paywise/screens/misc/about.dart';
import 'package:paywise/screens/misc/settings.dart';
import 'package:paywise/screens/send/send_contact.dart';
import 'package:paywise/screens/send/send_amount.dart';
import 'package:paywise/screens/send/receive.dart';
import 'package:paywise/screens/send/send_review.dart';
import 'package:paywise/screens/send/send_success.dart';
import 'package:paywise/screens/signup/level_selector.dart';
import 'package:paywise/screens/signup/recovery.dart';
import 'package:paywise/screens/signup/username.dart';
import 'package:paywise/screens/signup/verify.dart';
import 'package:paywise/screens/signup/signup.dart';
import 'package:paywise/screens/splash/splash.dart';
import 'package:paywise/screens/misc/switch_commmunity.dart';
import 'package:paywise/screens/misc/pincode.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashScreen splashScreen;
  SignupScreen signupScreen;
  VerifyScreen verifyScreen;
  UserNameScreen userNameScreen;
  ReceiveScreen receiveScreen;
  PincodeScreen pincodeScreen;
  LevelSelectorScreen levelSelectorScreen;
  CashHomeScreen cashHomeScreen;
  TransactionDetailsScreen transactionDetailsScreen;
  SendToContactScreen sendToContactScreen;
  SendAmountScreen sendAmountScreen;
  SendReviewScreen sendReviewScreen;
  SendSuccessScreen sendSuccessScreen;
  SwitchCommunityScreen switchCommunityScreen;
  BuyScreen buyScreen;
  BusinessPage businessPage;
  RecoveryPage recoveryPage;
  ShowMnemonic showMnemonic;
  VerifyMnemonic verifyMnemonic;
  DoneBackup doneBackup;
  AboutScreen aboutScreen;
  SettingsScreen settingsScreen;
  MapScreen mapScreen;
  PrizeScreen prizeScreen;
  DaiExplainedScreen daiExplainedScreen;
  WebViewPage webViewPage;
}
