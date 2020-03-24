import 'package:auto_route/auto_route_annotations.dart';
import 'package:localdolarmx/screens/backup/done_backup.dart';
import 'package:localdolarmx/screens/backup/show_mnemonic.dart';
import 'package:localdolarmx/screens/backup/verify_mnemonic.dart';
import 'package:localdolarmx/screens/buy/buy.dart';
import 'package:localdolarmx/screens/buy/business.dart';
import 'package:localdolarmx/screens/buy/map.dart';
import 'package:localdolarmx/screens/cash_home/cash_home.dart';
import 'package:localdolarmx/screens/cash_home/dai_explained.dart';
import 'package:localdolarmx/screens/cash_home/prize.dart';
import 'package:localdolarmx/screens/cash_home/transaction_details.dart';
import 'package:localdolarmx/screens/cash_home/webview_page.dart';
import 'package:localdolarmx/screens/misc/about.dart';
import 'package:localdolarmx/screens/misc/settings.dart';
import 'package:localdolarmx/screens/send/send_contact.dart';
import 'package:localdolarmx/screens/send/send_amount.dart';
import 'package:localdolarmx/screens/send/receive.dart';
import 'package:localdolarmx/screens/send/send_review.dart';
import 'package:localdolarmx/screens/send/send_success.dart';
import 'package:localdolarmx/screens/signup/level_selector.dart';
import 'package:localdolarmx/screens/signup/recovery.dart';
import 'package:localdolarmx/screens/signup/username.dart';
import 'package:localdolarmx/screens/signup/verify.dart';
import 'package:localdolarmx/screens/signup/signup.dart';
import 'package:localdolarmx/screens/splash/splash.dart';
import 'package:localdolarmx/screens/misc/switch_commmunity.dart';
import 'package:localdolarmx/screens/misc/pincode.dart';

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
