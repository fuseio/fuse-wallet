import 'package:roost/screens/backup/done_backup.dart';
import 'package:roost/screens/backup/show_mnemonic.dart';
import 'package:roost/screens/backup/verify_mnemonic.dart';
import 'package:roost/screens/buy/buy.dart';
import 'package:roost/screens/buy/business.dart';
import 'package:roost/screens/buy/map.dart';
import 'package:roost/screens/cash_home/cash_home.dart';
import 'package:roost/screens/cash_home/dai_explained.dart';
import 'package:roost/screens/cash_home/prize.dart';
import 'package:roost/screens/cash_home/transaction_details.dart';
import 'package:roost/screens/cash_home/webview_page.dart';
import 'package:roost/screens/misc/about.dart';
import 'package:roost/screens/misc/settings.dart';
import 'package:roost/screens/send/send_contact.dart';
import 'package:roost/screens/send/send_amount.dart';
import 'package:roost/screens/send/receive.dart';
import 'package:roost/screens/send/send_review.dart';
import 'package:roost/screens/send/send_success.dart';
import 'package:roost/screens/signup/level_selector.dart';
import 'package:roost/screens/signup/recovery.dart';
import 'package:roost/screens/signup/username.dart';
import 'package:roost/screens/signup/verify.dart';
import 'package:roost/screens/signup/signup.dart';
import 'package:roost/screens/splash/splash.dart';
import 'package:roost/screens/misc/switch_commmunity.dart';
import 'package:roost/screens/misc/pincode.dart';


getRoutes() {
  //  final Map<String, WidgetBuilder> routes;
  return {
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
    '/PayRent': (context) => WebViewPage(),
    '/Home': (context) => WebViewPage(),
  };
}
