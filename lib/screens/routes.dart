import 'package:fusecash/screens/signup/level_selector.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'cash_home/cash_home.dart';
import 'cash_home/cash_loading.dart';

getRoutes() {
  //  final Map<String, WidgetBuilder> routes;
  return {
    '/': (context) => SplashScreen(),
    '/Signup': (context) => SignupScreen(),
    '/LevelSelector': (context) => LevelSelectorScreen(),
    '/Cash': (context) => CashHomeScreen(),
    '/CashLoading': (context) => CashLoadingScreen(),
    '/Verify': (context) => VerifyScreen()
  };
}
