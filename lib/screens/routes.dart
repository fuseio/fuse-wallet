import 'package:fusecash/screens/send/sent_contact.dart';
import 'package:fusecash/screens/send/sent_amount.dart';
import 'package:fusecash/screens/signup/level_selector.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'cash_home.dart/cash_home.dart';

getRoutes() {
  //  final Map<String, WidgetBuilder> routes;
  return {
    '/': (context) => SplashScreen(),
    '/Signup': (context) => SignupScreen(),
    '/LevelSelector': (context) => LevelSelectorScreen(),
    '/Cash': (context) => CashHomeScreen(),
    '/SendContact': (context) => SendToContactScreen(),
    '/SendAmount': (context) => SendAmountScreen(),
  };
}
