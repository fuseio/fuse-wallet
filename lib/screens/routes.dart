import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/send/send_review.dart';
import 'package:fusecash/screens/send/send_success.dart';
import 'package:fusecash/screens/signup/level_selector.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/misc/switch_commmunity.dart';
import 'package:fusecash/screens/misc/pincode.dart';
import 'cash_home/cash_home.dart';
import 'cash_home/transaction_details.dart';

getRoutes() {
  //  final Map<String, WidgetBuilder> routes;
  return {
    '/': (context) => SplashScreen(),
    '/Signup': (context) => SignupScreen(),
    '/LevelSelector': (context) => LevelSelectorScreen(),
    '/Cash': (context) => CashHomeScreen(),
    '/TransactionDetails': (context) => TransactionDetailsScreen(),
    '/SendContact': (context) => ContactsScreen(),
    '/SendAmount': (context) => SendAmountScreen(),
    '/SendReview': (context) => SendReviewScreen(),
    '/SendSuccess': (context) => SendSuccessScreen(),
    '/Verify': (context) => VerifyScreen(),
    '/Receive': (context) => ReceiveScreen(),
    '/Switch': (context) => SwitchCommunityScreen(),
    '/Pincode': (context) => PincodeScreen(),
    '/Buy': (context) => BuyScreen(),
    '/Business': (context) => BusinessPage(),
  };
}
