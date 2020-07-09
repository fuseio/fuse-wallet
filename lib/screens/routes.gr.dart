// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/signup/recovery.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/screens/signup/signup.dart';
import 'package:fusecash/screens/signup/verify.dart';
import 'package:fusecash/screens/signup/username.dart';
import 'package:fusecash/screens/cash_home/cash_mode.dart';
import 'package:fusecash/screens/route_guards.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/cash_home/transaction_details.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/screens/pro_mode/token_transfers.dart';
import 'package:fusecash/screens/trade/trade.dart';

class Routes {
  static const String recoveryPage = '/recovery';
  static const String splashScreen = '/splash';
  static const String signupScreen = '/signup';
  static const String verifyScreen = '/verify';
  static const String userNameScreen = '/username';
  static const String mainNavigator = '/';
  static const all = <String>{
    recoveryPage,
    splashScreen,
    signupScreen,
    verifyScreen,
    userNameScreen,
    mainNavigator,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.recoveryPage, page: RecoveryPage),
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.signupScreen, page: SignupScreen),
    RouteDef(Routes.verifyScreen, page: VerifyScreen),
    RouteDef(Routes.userNameScreen, page: UserNameScreen),
    RouteDef(
      Routes.mainNavigator,
      page: MainNavigator,
      guards: [AuthGuard],
      innerRouter: () => MainNavigatorRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
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
    MainNavigator: (RouteData data) {
      var args = data.getArgs<MainNavigatorArguments>(
          orElse: () => MainNavigatorArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainNavigator(key: args.key),
        settings: data,
      );
    },
  };
}

class MainNavigatorRoutes {
  static const String cashModeScaffold = '/';
  static const String transactionDetailsScreen = '/transaction_details';
  static const String tokenTransfersScreen = '/asset_screen';
  static const String tradeScreen = '/trade';
  static const all = <String>{
    cashModeScaffold,
    transactionDetailsScreen,
    tokenTransfersScreen,
    tradeScreen,
  };
}

class MainNavigatorRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(MainNavigatorRoutes.cashModeScaffold, page: CashModeScaffold),
    RouteDef(MainNavigatorRoutes.transactionDetailsScreen,
        page: TransactionDetailsScreen),
    RouteDef(MainNavigatorRoutes.tokenTransfersScreen,
        page: TokenTransfersScreen),
    RouteDef(MainNavigatorRoutes.tradeScreen, page: TradeScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    CashModeScaffold: (RouteData data) {
      var args = data.getArgs<CashModeScaffoldArguments>(
          orElse: () => CashModeScaffoldArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => CashModeScaffold(
          key: args.key,
          tabIndex: args.tabIndex,
          primaryToken: args.primaryToken,
        ),
        settings: data,
      );
    },
    TransactionDetailsScreen: (RouteData data) {
      var args = data.getArgs<TransactionDetailsScreenArguments>(
          orElse: () => TransactionDetailsScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => TransactionDetailsScreen(
          image: args.image,
          from: args.from,
          status: args.status,
          token: args.token,
          contact: args.contact,
          amount: args.amount,
          transfer: args.transfer,
        ),
        settings: data,
      );
    },
    TokenTransfersScreen: (RouteData data) {
      var args = data.getArgs<TokenTransfersScreenArguments>(
          orElse: () => TokenTransfersScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            TokenTransfersScreen(key: args.key, token: args.token),
        settings: data,
      );
    },
    TradeScreen: (RouteData data) {
      var args = data.getArgs<TradeScreenArguments>(
          orElse: () => TradeScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) =>
            TradeScreen(key: args.key, primaryToken: args.primaryToken),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//VerifyScreen arguments holder class
class VerifyScreenArguments {
  final String verificationId;
  VerifyScreenArguments({this.verificationId});
}

//MainNavigator arguments holder class
class MainNavigatorArguments {
  final Key key;
  MainNavigatorArguments({this.key});
}

//CashModeScaffold arguments holder class
class CashModeScaffoldArguments {
  final Key key;
  final int tabIndex;
  final Token primaryToken;
  CashModeScaffoldArguments({this.key, this.tabIndex = 0, this.primaryToken});
}

//TransactionDetailsScreen arguments holder class
class TransactionDetailsScreenArguments {
  final ImageProvider<dynamic> image;
  final String from;
  final String status;
  final Token token;
  final Contact contact;
  final List<Widget> amount;
  final Transfer transfer;
  TransactionDetailsScreenArguments(
      {this.image,
      this.from,
      this.status,
      this.token,
      this.contact,
      this.amount,
      this.transfer});
}

//TokenTransfersScreen arguments holder class
class TokenTransfersScreenArguments {
  final Key key;
  final Token token;
  TokenTransfersScreenArguments({this.key, this.token});
}

//TradeScreen arguments holder class
class TradeScreenArguments {
  final Key key;
  final Token primaryToken;
  TradeScreenArguments({this.key, this.primaryToken});
}
