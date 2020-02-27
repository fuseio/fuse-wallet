import 'package:flutter/material.dart';
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

Map<String, WidgetBuilder> getRoutes() => {
      '/': (context) => SplashScreen(),
      '/Signup': (context) => SignupScreen(),
      '/UserName': (context) => UserNameScreen(),
      '/LevelSelector': (context) => LevelSelectorScreen(),
      '/Cash': (context) => CashHomeScreen(),
      '/TransactionDetails': (context) => TransactionDetailsScreen(),
      '/SendContact': (context) => SendToContactScreen(),
      '/SendAmount': (context) => SendAmountScreen(),
      '/SendReview': (context) => SendReviewScreen(),
      '/SendSuccess': (context) => SendSuccessScreen(),
      '/Verify': (context) => VerifyScreen(),
      '/Receive': (context) => ReceiveScreen(),
      '/Switch': (context) => SwitchCommunityScreen(),
      '/Pincode': (context) => PincodeScreen(),
      '/Buy': (context) => BuyScreen(),
      '/Business': (context) => BusinessPage(),
      '/Recovery': (context) => RecoveryPage(),
      '/Backup1': (context) => ShowMnemonic(),
      '/Backup2': (context) => VerifyMnemonic(),
      '/Backup3': (context) => DoneBackup(),
      '/About': (context) => AboutScreen(),
      '/Settings': (context) => SettingsScreen(),
      '/Map': (context) => MapScreen(),
      '/Prize': (context) => PrizeScreen(),
      '/DaiPoints': (context) => DaiExplainedScreen(),
      '/WebPage': (context) => WebViewPage(),
    };
