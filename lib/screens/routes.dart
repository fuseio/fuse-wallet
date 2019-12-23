import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/screens/send/send_amount.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/signup/level_selector.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/misc/switch_commmunity.dart';
import 'package:fusecash/screens/misc/pincode.dart';
import 'cash_home/cash_home.dart';

getRoutes() {
  //  final Map<String, WidgetBuilder> routes;
  return {
    '/': (context) => SplashScreen(),
    '/Signup': (context) => SignupScreen(),
    '/LevelSelector': (context) => LevelSelectorScreen(),
    '/Cash': (context) => CashHomeScreen(),
    '/SendContact': (context) => SendToContactScreen(),
    '/SendAmount': (context) => SendAmountScreen(),
    '/Verify': (context) => VerifyScreen(),
    '/Receive': (context) => ReceiveScreen(),
    '/Switch': (context) => SwitchCommunityScreen(),
    '/Pincode': (context) => PincodeScreen(),
    '/Buy': (context) => BuyScreen(),
    '/Business': (context) => BusinessPage(),
  };
}
