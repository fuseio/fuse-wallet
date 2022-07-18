import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/user_state.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final store =
        StoreProvider.of<AppState>(router.root.navigatorKey.currentContext!);
    UserState userState = store.state.userState;
    String privateKey = userState.privateKey;
    String jwtToken = userState.jwtToken;
    bool isLoggedOut = userState.isLoggedOut;
    final canContinue =
        privateKey.isNotEmpty || jwtToken.isNotEmpty || isLoggedOut;
    if (canContinue) {
      resolver.next(true);
    } else {
      router.push(
        SplashRoute(onLoginResult: (bool isLoggedIn) {
          resolver.next(isLoggedIn);
        }),
      );
    }
  }
}
