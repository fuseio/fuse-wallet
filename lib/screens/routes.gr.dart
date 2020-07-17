// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/misc/lock_screen.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/misc/security.dart';
import 'package:fusecash/screens/misc/pincode_colored.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/misc/webview_page.dart';
import 'package:fusecash/screens/home/home_page.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/route_guards.dart';

class Routes {
  static const String lockScreen = '/';
  static const String backupScreen = '/show-mnemonic';
  static const String securityScreen = '/security-screen';
  static const String pincode = '/colors-pincode-screen';
  static const String recoveryPage = '/recovery-page';
  static const String splashScreen = '/splash-screen';
  static const String signupScreen = '/signup-screen';
  static const String verifyScreen = '/verify-screen';
  static const String userNameScreen = '/user-name-screen';
  static const String webview = '/web-view-page';
  static const String homePage = '/home-page';
  static const all = <String>{
    lockScreen,
    backupScreen,
    securityScreen,
    pincode,
    recoveryPage,
    splashScreen,
    signupScreen,
    verifyScreen,
    userNameScreen,
    webview,
    homePage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.lockScreen, page: LockScreen),
    RouteDef(Routes.backupScreen, page: ShowMnemonic),
    RouteDef(Routes.securityScreen, page: SecurityScreen),
    RouteDef(Routes.pincode, page: ColorsPincodeScreen),
    RouteDef(Routes.recoveryPage, page: RecoveryPage),
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.signupScreen, page: SignupScreen),
    RouteDef(Routes.verifyScreen, page: VerifyScreen),
    RouteDef(Routes.userNameScreen, page: UserNameScreen),
    RouteDef(Routes.webview, page: WebViewPage),
    RouteDef(Routes.homePage, page: HomePage, guards: [AuthGuard]),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LockScreen: (RouteData data) {
      var args = data.getArgs<LockScreenArguments>(
          orElse: () => LockScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => LockScreen(store: args.store),
        settings: data,
      );
    },
    ShowMnemonic: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowMnemonic(),
        settings: data,
      );
    },
    SecurityScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SecurityScreen(),
        settings: data,
      );
    },
    ColorsPincodeScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ColorsPincodeScreen(),
        settings: data,
      );
    },
    RecoveryPage: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecoveryPage(),
        settings: data,
      );
    },
    SplashScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    SignupScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupScreen(),
        settings: data,
      );
    },
    VerifyScreen: (RouteData data) {
      var args = data.getArgs<VerifyScreenArguments>(
          orElse: () => VerifyScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyScreen(verificationId: args.verificationId),
        settings: data,
      );
    },
    UserNameScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserNameScreen(),
        settings: data,
      );
    },
    WebViewPage: (RouteData data) {
      var args = data.getArgs<WebViewPageArguments>(
          orElse: () => WebViewPageArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => WebViewPage(
          url: args.url,
          title: args.title,
          withBack: args.withBack,
        ),
        settings: data,
      );
    },
    HomePage: (RouteData data) {
      var args =
          data.getArgs<HomePageArguments>(orElse: () => HomePageArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePage(
          key: args.key,
          tabIndex: args.tabIndex,
          primaryToken: args.primaryToken,
        ),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//LockScreen arguments holder class
class LockScreenArguments {
  final Store<AppState> store;
  LockScreenArguments({this.store});
}

//VerifyScreen arguments holder class
class VerifyScreenArguments {
  final String verificationId;
  VerifyScreenArguments({this.verificationId});
}

//WebViewPage arguments holder class
class WebViewPageArguments {
  final String url;
  final String title;
  final bool withBack;
  WebViewPageArguments({this.url, this.title, this.withBack});
}

//HomePage arguments holder class
class HomePageArguments {
  final Key key;
  final int tabIndex;
  final Token primaryToken;
  HomePageArguments({this.key, this.tabIndex = 0, this.primaryToken});
}
