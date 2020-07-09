import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/routes.gr.dart';

class AuthGuard extends RouteGuard {
  final bool isLoggedIn;
  AuthGuard({this.isLoggedIn});
  Future<bool> canNavigate(
    ExtendedNavigatorState navigator,
    String routeName,
    Object arguments,
  ) async {
    if (isLoggedIn) {
      return true;
    } else {
      navigator..pushNamed(Routes.splashScreen);
      return isLoggedIn;
    }
  }
}
