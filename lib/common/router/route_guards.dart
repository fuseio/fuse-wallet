import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:fusecash/common/router/routes.dart';

var isAuthenticated = false;

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!isAuthenticated) {
      // ignore: unawaited_futures
      // ignore: unawaited_futures
      router.push(
        SplashScreen(onLoginResult: (bool isLoggedIn) {
          isAuthenticated = isLoggedIn;
          // we can't pop the bottom page in the navigator's stack
          // so we just remove it from our local stack
          router.removeLast();
          resolver.next();
        }),
      );
    } else {
      resolver.next(true);
    }
  }
}

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }
}
