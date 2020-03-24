import 'package:auto_route/auto_route_annotations.dart';
import 'package:localpay/screens/backup/done_backup.dart';
import 'package:localpay/screens/backup/show_mnemonic.dart';
import 'package:localpay/screens/backup/verify_mnemonic.dart';
import 'package:localpay/screens/buy/buy.dart';
import 'package:localpay/screens/buy/business.dart';
import 'package:localpay/screens/buy/map.dart';
import 'package:localpay/screens/cash_home/cash_home.dart';
import 'package:localpay/screens/cash_home/dai_explained.dart';
import 'package:localpay/screens/cash_home/prize.dart';
import 'package:localpay/screens/cash_home/transaction_details.dart';
import 'package:localpay/screens/cash_home/webview_page.dart';
import 'package:localpay/screens/misc/about.dart';
import 'package:localpay/screens/misc/settings.dart';
import 'package:localpay/screens/send/send_contact.dart';
import 'package:localpay/screens/send/send_amount.dart';
import 'package:localpay/screens/send/receive.dart';
import 'package:localpay/screens/send/send_review.dart';
import 'package:localpay/screens/send/send_success.dart';
import 'package:localpay/screens/signup/level_selector.dart';
import 'package:localpay/screens/signup/recovery.dart';
import 'package:localpay/screens/signup/username.dart';
import 'package:localpay/screens/signup/verify.dart';
import 'package:localpay/screens/signup/signup.dart';
import 'package:localpay/screens/splash/splash.dart';
import 'package:localpay/screens/misc/switch_commmunity.dart';
import 'package:localpay/screens/misc/pincode.dart';

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
