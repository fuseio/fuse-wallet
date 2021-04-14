// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../features/contacts/screens/contacts_list.dart';
import '../../features/contacts/send_amount_arguments.dart';
import '../../features/home/screens/action_details.dart';
import '../../features/onboard/screens/restore_wallet_screen.dart';
import '../../features/onboard/screens/security_screen.dart';
import '../../features/onboard/screens/signup_screen.dart';
import '../../features/onboard/screens/username_screen.dart';
import '../../features/onboard/screens/verify_screen.dart';
import '../../features/screens/home_screen.dart';
import '../../features/screens/on_board_screen.dart';
import '../../features/screens/on_boarding_screen.dart';
import '../../features/screens/pincode_screen.dart';
import '../../features/screens/send_amount.dart';
import '../../features/screens/send_review.dart';
import '../../features/screens/send_success.dart';
import '../../features/screens/splash_screen.dart';
import '../../features/screens/unknown_route.dart';
import '../../features/screens/webview_screen.dart';
import '../../features/swap/screens/review_swap.dart';
import '../../features/swap/screens/swap.dart';
import '../../models/actions/wallet_action.dart';
import '../../models/swap/swap.dart';
import '../../models/tokens/token.dart';
import 'route_guards.dart';

class Routes {
  static const String splashScreen = '/';
  static const String securityScreen = '/security-screen';
  static const String pinCodeScreen = '/pin-code-screen';
  static const String recoveryPage = '/recovery-page';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String onBoardScreen = '/on-board-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String verifyScreen = '/verify-screen';
  static const String userNameScreen = '/user-name-screen';
  static const String webview = '/web-view-screen';
  static const String homeScreen = '/main-home-screen';
  static const String actionDetailsScreen = '/action-details-screen';
  static const String sendAmountScreen = '/send-amount-screen';
  static const String sendReviewScreen = '/send-review-screen';
  static const String sendSuccessScreen = '/send-success-screen';
  static const String swapScreen = '/swap-screen';
  static const String reviewSwapScreen = '/review-swap-screen';
  static const String contactsList = '/contacts-list';
  static const String unknownRouteScreen = '*';
  static const all = <String>{
    splashScreen,
    securityScreen,
    pinCodeScreen,
    recoveryPage,
    onBoardingScreen,
    onBoardScreen,
    signUpScreen,
    verifyScreen,
    userNameScreen,
    webview,
    homeScreen,
    actionDetailsScreen,
    sendAmountScreen,
    sendReviewScreen,
    sendSuccessScreen,
    swapScreen,
    reviewSwapScreen,
    contactsList,
    unknownRouteScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.securityScreen, page: SecurityScreen),
    RouteDef(Routes.pinCodeScreen, page: PinCodeScreen),
    RouteDef(Routes.recoveryPage, page: RecoveryPage),
    RouteDef(Routes.onBoardingScreen, page: OnBoardingScreen),
    RouteDef(Routes.onBoardScreen, page: OnBoardScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.verifyScreen, page: VerifyScreen),
    RouteDef(Routes.userNameScreen, page: UserNameScreen),
    RouteDef(Routes.webview, page: WebViewScreen),
    RouteDef(Routes.homeScreen, page: MainHomeScreen, guards: [AuthGuard]),
    RouteDef(Routes.actionDetailsScreen,
        page: ActionDetailsScreen, guards: [AuthGuard]),
    RouteDef(Routes.sendAmountScreen,
        page: SendAmountScreen, guards: [AuthGuard]),
    RouteDef(Routes.sendReviewScreen,
        page: SendReviewScreen, guards: [AuthGuard]),
    RouteDef(Routes.sendSuccessScreen,
        page: SendSuccessScreen, guards: [AuthGuard]),
    RouteDef(Routes.swapScreen, page: SwapScreen, guards: [AuthGuard]),
    RouteDef(Routes.reviewSwapScreen,
        page: ReviewSwapScreen, guards: [AuthGuard]),
    RouteDef(Routes.contactsList, page: ContactsList, guards: [AuthGuard]),
    RouteDef(Routes.unknownRouteScreen, page: UnknownRouteScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    SecurityScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SecurityScreen(),
        settings: data,
      );
    },
    PinCodeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PinCodeScreen(),
        settings: data,
      );
    },
    RecoveryPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RecoveryPage(),
        settings: data,
      );
    },
    OnBoardingScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardingScreen(),
        settings: data,
      );
    },
    OnBoardScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => OnBoardScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpScreen(),
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
    WebViewScreen: (data) {
      final args = data.getArgs<WebViewScreenArguments>(
        orElse: () => WebViewScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => WebViewScreen(
          url: args.url,
          title: args.title,
          withBack: args.withBack,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    MainHomeScreen: (data) {
      final args = data.getArgs<MainHomeScreenArguments>(
        orElse: () => MainHomeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainHomeScreen(key: args.key),
        settings: data,
      );
    },
    ActionDetailsScreen: (data) {
      final args = data.getArgs<ActionDetailsScreenArguments>(
        orElse: () => ActionDetailsScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ActionDetailsScreen(
          action: args.action,
          image: args.image,
          displayName: args.displayName,
          accountAddress: args.accountAddress,
          symbol: args.symbol,
          contact: args.contact,
        ),
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
    SwapScreen: (data) {
      final args = data.getArgs<SwapScreenArguments>(
        orElse: () => SwapScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SwapScreen(
          key: args.key,
          primaryToken: args.primaryToken,
        ),
        settings: data,
      );
    },
    ReviewSwapScreen: (data) {
      final args = data.getArgs<ReviewSwapScreenArguments>(
        orElse: () => ReviewSwapScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ReviewSwapScreen(
          tradeInfo: args.tradeInfo,
          rateInfo: args.rateInfo,
          swapRequestBody: args.swapRequestBody,
        ),
        settings: data,
      );
    },
    ContactsList: (data) {
      final args = data.getArgs<ContactsListArguments>(
        orElse: () => ContactsListArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ContactsList(pageArgs: args.pageArgs),
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
  Future<dynamic> pushSplashScreen() => push<dynamic>(Routes.splashScreen);

  Future<dynamic> pushSecurityScreen() => push<dynamic>(Routes.securityScreen);

  Future<dynamic> pushPinCodeScreen() => push<dynamic>(Routes.pinCodeScreen);

  Future<dynamic> pushRecoveryPage() => push<dynamic>(Routes.recoveryPage);

  Future<dynamic> pushOnBoardingScreen() =>
      push<dynamic>(Routes.onBoardingScreen);

  Future<dynamic> pushOnBoardScreen() => push<dynamic>(Routes.onBoardScreen);

  Future<dynamic> pushSignUpScreen() => push<dynamic>(Routes.signUpScreen);

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
            WebViewScreenArguments(url: url, title: title, withBack: withBack),
      );

  Future<dynamic> pushHomeScreen({Key key, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.homeScreen,
        arguments: MainHomeScreenArguments(key: key),
        onReject: onReject,
      );

  Future<dynamic> pushActionDetailsScreen(
          {WalletAction action,
          ImageProvider<dynamic> image,
          String displayName,
          String accountAddress,
          String symbol,
          Contact contact,
          OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.actionDetailsScreen,
        arguments: ActionDetailsScreenArguments(
            action: action,
            image: image,
            displayName: displayName,
            accountAddress: accountAddress,
            symbol: symbol,
            contact: contact),
        onReject: onReject,
      );

  Future<dynamic> pushSendAmountScreen(
          {SendFlowArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.sendAmountScreen,
        arguments: SendAmountScreenArguments(pageArgs: pageArgs),
        onReject: onReject,
      );

  Future<dynamic> pushSendReviewScreen(
          {SendFlowArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.sendReviewScreen,
        arguments: SendReviewScreenArguments(pageArgs: pageArgs),
        onReject: onReject,
      );

  Future<dynamic> pushSendSuccessScreen(
          {SendFlowArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.sendSuccessScreen,
        arguments: SendSuccessScreenArguments(pageArgs: pageArgs),
        onReject: onReject,
      );

  Future<dynamic> pushSwapScreen(
          {Key key, Token primaryToken, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.swapScreen,
        arguments: SwapScreenArguments(key: key, primaryToken: primaryToken),
        onReject: onReject,
      );

  Future<dynamic> pushReviewSwapScreen(
          {TradeInfo tradeInfo,
          TradeInfo rateInfo,
          SwapRequestBody swapRequestBody,
          OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.reviewSwapScreen,
        arguments: ReviewSwapScreenArguments(
            tradeInfo: tradeInfo,
            rateInfo: rateInfo,
            swapRequestBody: swapRequestBody),
        onReject: onReject,
      );

  Future<dynamic> pushContactsList(
          {SendFlowArguments pageArgs, OnNavigationRejected onReject}) =>
      push<dynamic>(
        Routes.contactsList,
        arguments: ContactsListArguments(pageArgs: pageArgs),
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

/// WebViewScreen arguments holder class
class WebViewScreenArguments {
  final String url;
  final String title;
  final bool withBack;
  WebViewScreenArguments({this.url, this.title, this.withBack = false});
}

/// MainHomeScreen arguments holder class
class MainHomeScreenArguments {
  final Key key;
  MainHomeScreenArguments({this.key});
}

/// ActionDetailsScreen arguments holder class
class ActionDetailsScreenArguments {
  final WalletAction action;
  final ImageProvider<dynamic> image;
  final String displayName;
  final String accountAddress;
  final String symbol;
  final Contact contact;
  ActionDetailsScreenArguments(
      {this.action,
      this.image,
      this.displayName,
      this.accountAddress,
      this.symbol,
      this.contact});
}

/// SendAmountScreen arguments holder class
class SendAmountScreenArguments {
  final SendFlowArguments pageArgs;
  SendAmountScreenArguments({this.pageArgs});
}

/// SendReviewScreen arguments holder class
class SendReviewScreenArguments {
  final SendFlowArguments pageArgs;
  SendReviewScreenArguments({this.pageArgs});
}

/// SendSuccessScreen arguments holder class
class SendSuccessScreenArguments {
  final SendFlowArguments pageArgs;
  SendSuccessScreenArguments({this.pageArgs});
}

/// SwapScreen arguments holder class
class SwapScreenArguments {
  final Key key;
  final Token primaryToken;
  SwapScreenArguments({this.key, this.primaryToken});
}

/// ReviewSwapScreen arguments holder class
class ReviewSwapScreenArguments {
  final TradeInfo tradeInfo;
  final TradeInfo rateInfo;
  final SwapRequestBody swapRequestBody;
  ReviewSwapScreenArguments(
      {this.tradeInfo, this.rateInfo, this.swapRequestBody});
}

/// ContactsList arguments holder class
class ContactsListArguments {
  final SendFlowArguments pageArgs;
  ContactsListArguments({this.pageArgs});
}
