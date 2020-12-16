// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'backup/done_backup.dart';
import 'backup/show_mnemonic.dart';
import 'backup/verify_mnemonic.dart';
import 'contacts/send_amount_arguments.dart';
import 'home/home_page.dart';
import 'misc/about.dart';
import 'misc/lock_screen.dart';
import 'misc/pincode_colored.dart';
import 'misc/protect_your_wallet.dart';
import 'misc/security.dart';
import 'misc/settings.dart';
import 'misc/webview_page.dart';
import 'profile/screen/profile.dart';
import 'route_guards.dart';
import 'send_flow/send_amount.dart';
import 'send_flow/send_review.dart';
import 'send_flow/send_success.dart';
import 'signup/recovery.dart';
import 'signup/signup.dart';
import 'signup/username.dart';
import 'signup/verify.dart';
import 'splash/splash.dart';
import 'unknown_route.dart';

class Routes {
  static const String lockScreen = '/';
  static const String securityScreen = '/security-screen';
  static const String pincode = '/colors-pincode-screen';
  static const String recoveryPage = '/recovery-page';
  static const String splashScreen = '/splash-screen';
  static const String signupScreen = '/signup-screen';
  static const String verifyScreen = '/verify-screen';
  static const String userNameScreen = '/user-name-screen';
  static const String webview = '/web-view-page';
  static const String aboutScreen = '/about-screen';
  static const String showMnemonic = '/show-mnemonic';
  static const String verifyMnemonic = '/verify-mnemonic';
  static const String doneBackup = '/done-backup';
  static const String settingsScreen = '/settings-screen';
  static const String protectYourWallet = '/protect-your-wallet';
  static const String profileScreen = '/profile-screen';
  static const String homePage = '/home-page';
  static const String sendAmountScreen = '/send-amount-screen';
  static const String sendReviewScreen = '/send-review-screen';
  static const String sendSuccessScreen = '/send-success-screen';
  static const String unknownRouteScreen = '*';
  static const all = <String>{
    lockScreen,
    securityScreen,
    pincode,
    recoveryPage,
    splashScreen,
    signupScreen,
    verifyScreen,
    userNameScreen,
    webview,
    aboutScreen,
    showMnemonic,
    verifyMnemonic,
    doneBackup,
    settingsScreen,
    protectYourWallet,
    profileScreen,
    homePage,
    sendAmountScreen,
    sendReviewScreen,
    sendSuccessScreen,
    unknownRouteScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.lockScreen, page: LockScreen),
    RouteDef(Routes.securityScreen, page: SecurityScreen),
    RouteDef(Routes.pincode, page: ColorsPincodeScreen),
    RouteDef(Routes.recoveryPage, page: RecoveryPage),
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.signupScreen, page: SignupScreen),
    RouteDef(Routes.verifyScreen, page: VerifyScreen),
    RouteDef(Routes.userNameScreen, page: UserNameScreen),
    RouteDef(Routes.webview, page: WebViewPage),
    RouteDef(Routes.aboutScreen, page: AboutScreen, guards: [AuthGuard]),
    RouteDef(Routes.showMnemonic, page: ShowMnemonic, guards: [AuthGuard]),
    RouteDef(Routes.verifyMnemonic, page: VerifyMnemonic, guards: [AuthGuard]),
    RouteDef(Routes.doneBackup, page: DoneBackup, guards: [AuthGuard]),
    RouteDef(Routes.settingsScreen, page: SettingsScreen, guards: [AuthGuard]),
    RouteDef(Routes.protectYourWallet,
        page: ProtectYourWallet, guards: [AuthGuard]),
    RouteDef(Routes.profileScreen, page: ProfileScreen, guards: [AuthGuard]),
    RouteDef(Routes.homePage, page: HomePage, guards: [AuthGuard]),
    RouteDef(Routes.sendAmountScreen,
        page: SendAmountScreen, guards: [AuthGuard]),
    RouteDef(Routes.sendReviewScreen,
        page: SendReviewScreen, guards: [AuthGuard]),
    RouteDef(Routes.sendSuccessScreen,
        page: SendSuccessScreen, guards: [AuthGuard]),
    RouteDef(Routes.unknownRouteScreen, page: UnknownRouteScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LockScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LockScreen(),
        settings: data,
      );
    },
    SecurityScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SecurityScreen(),
        settings: data,
      );
    },
    ColorsPincodeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ColorsPincodeScreen(),
        settings: data,
      );
    },
    RecoveryPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecoveryPage(),
        settings: data,
      );
    },
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    SignupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignupScreen(),
        settings: data,
      );
    },
    VerifyScreen: (data) {
      final args = data.getArgs<VerifyScreenArguments>(
        orElse: () => VerifyScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyScreen(verificationId: args.verificationId),
        settings: data,
      );
    },
    UserNameScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => UserNameScreen(),
        settings: data,
      );
    },
    WebViewPage: (data) {
      final args = data.getArgs<WebViewPageArguments>(
        orElse: () => WebViewPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => WebViewPage(
          url: args.url,
          title: args.title,
          withBack: args.withBack,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    AboutScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AboutScreen(),
        settings: data,
      );
    },
    ShowMnemonic: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowMnemonic(),
        settings: data,
      );
    },
    VerifyMnemonic: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyMnemonic(),
        settings: data,
      );
    },
    DoneBackup: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DoneBackup(),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
        settings: data,
      );
    },
    ProtectYourWallet: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProtectYourWallet(),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      final args = data.getArgs<ProfileScreenArguments>(
        orElse: () => ProfileScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(key: args.key),
        settings: data,
      );
    },
    HomePage: (data) {
      final args = data.getArgs<HomePageArguments>(
        orElse: () => HomePageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePage(key: args.key),
        settings: data,
      );
    },
    SendAmountScreen: (data) {
      final args = data.getArgs<SendAmountScreenArguments>(
        orElse: () => SendAmountScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SendAmountScreen(pageArgs: args.pageArgs),
        settings: data,
      );
    },
    SendReviewScreen: (data) {
      final args = data.getArgs<SendReviewScreenArguments>(
        orElse: () => SendReviewScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SendReviewScreen(pageArgs: args.pageArgs),
        settings: data,
      );
    },
    SendSuccessScreen: (data) {
      final args = data.getArgs<SendSuccessScreenArguments>(
        orElse: () => SendSuccessScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SendSuccessScreen(pageArgs: args.pageArgs),
        settings: data,
      );
    },
    UnknownRouteScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => UnknownRouteScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushLockScreen() => push<dynamic>(Routes.lockScreen);

  Future<dynamic> pushSecurityScreen() => push<dynamic>(Routes.securityScreen);

  Future<dynamic> pushPincode() => push<dynamic>(Routes.pincode);

  Future<dynamic> pushRecoveryPage() => push<dynamic>(Routes.recoveryPage);

  Future<dynamic> pushSplashScreen() => push<dynamic>(Routes.splashScreen);

  Future<dynamic> pushSignupScreen() => push<dynamic>(Routes.signupScreen);

  Future<dynamic> pushVerifyScreen({
    String verificationId,
  }) =>
      push<dynamic>(
        Routes.verifyScreen,
        arguments: VerifyScreenArguments(verificationId: verificationId),
      );

  Future<dynamic> pushUserNameScreen() => push<dynamic>(Routes.userNameScreen);

  Future<dynamic> pushWebview({
    String url,
    String title,
    bool withBack = false,
  }) =>
      push<dynamic>(
        Routes.webview,
        arguments:
            WebViewPageArguments(url: url, title: title, withBack: withBack),
      );

  Future<dynamic> pushAboutScreen() => push<dynamic>(Routes.aboutScreen);

  Future<dynamic> pushShowMnemonic() => push<dynamic>(Routes.showMnemonic);

  Future<dynamic> pushVerifyMnemonic() => push<dynamic>(Routes.verifyMnemonic);

  Future<dynamic> pushDoneBackup() => push<dynamic>(Routes.doneBackup);

  Future<dynamic> pushSettingsScreen() => push<dynamic>(Routes.settingsScreen);

  Future<dynamic> pushProtectYourWallet() =>
      push<dynamic>(Routes.protectYourWallet);

  Future<dynamic> pushProfileScreen({Key key, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.profileScreen,
        arguments: ProfileScreenArguments(key: key),
        onReject: onReject,
      );

  Future<dynamic> pushHomePage({Key key, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.homePage,
        arguments: HomePageArguments(key: key),
        onReject: onReject,
      );

  Future<dynamic> pushSendAmountScreen(
          {SendAmountArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.sendAmountScreen,
        arguments: SendAmountScreenArguments(pageArgs: pageArgs),
        onReject: onReject,
      );

  Future<dynamic> pushSendReviewScreen(
          {SendAmountArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.sendReviewScreen,
        arguments: SendReviewScreenArguments(pageArgs: pageArgs),
        onReject: onReject,
      );

  Future<dynamic> pushSendSuccessScreen(
          {SendAmountArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.sendSuccessScreen,
        arguments: SendSuccessScreenArguments(pageArgs: pageArgs),
        onReject: onReject,
      );

  Future<dynamic> pushUnknownRouteScreen() =>
      push<dynamic>(Routes.unknownRouteScreen);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// VerifyScreen arguments holder class
class VerifyScreenArguments {
  final String verificationId;
  VerifyScreenArguments({this.verificationId});
}

/// WebViewPage arguments holder class
class WebViewPageArguments {
  final String url;
  final String title;
  final bool withBack;
  WebViewPageArguments({this.url, this.title, this.withBack = false});
}

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final Key key;
  ProfileScreenArguments({this.key});
}

/// HomePage arguments holder class
class HomePageArguments {
  final Key key;
  HomePageArguments({this.key});
}

/// SendAmountScreen arguments holder class
class SendAmountScreenArguments {
  final SendAmountArguments pageArgs;
  SendAmountScreenArguments({this.pageArgs});
}

/// SendReviewScreen arguments holder class
class SendReviewScreenArguments {
  final SendAmountArguments pageArgs;
  SendReviewScreenArguments({this.pageArgs});
}

/// SendSuccessScreen arguments holder class
class SendSuccessScreenArguments {
  final SendAmountArguments pageArgs;
  SendSuccessScreenArguments({this.pageArgs});
}
