// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/home/screens/home.dart';
import 'package:fusecash/screens/home/screens/transaction_details.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/screens/home/widgets/token_transfers.dart';
import 'package:fusecash/screens/trade/trade.dart';
import 'package:fusecash/screens/trade/review_trade.dart';
import 'package:fusecash/screens/misc/about.dart';
import 'package:fusecash/screens/backup/show_mnemonic.dart';
import 'package:fusecash/screens/backup/verify_mnemonic.dart';
import 'package:fusecash/screens/backup/done_backup.dart';
import 'package:fusecash/screens/misc/settings.dart';
import 'package:fusecash/screens/misc/switch_commmunity.dart';
import 'package:fusecash/screens/misc/protect_your_wallet.dart';

class HomeRoutes {
  static const String mainHomeScreen = '/';
  static const String transactionDetailsScreen = '/transaction-details-screen';
  static const String tokenTransfersScreen = '/token-transfers-screen';
  static const String tradeScreen = '/trade-screen';
  static const String reviewTradeScreen = '/review-trade-screen';
  static const String aboutScreen = '/about-screen';
  static const String showMnemonic = '/show-mnemonic';
  static const String verifyMnemonic = '/verify-mnemonic';
  static const String doneBackup = '/done-backup';
  static const String settingsScreen = '/settings-screen';
  static const String switchCommunityScreen = '/switch-community-screen';
  static const String protectYourWallet = '/protect-your-wallet';
  static const all = <String>{
    mainHomeScreen,
    transactionDetailsScreen,
    tokenTransfersScreen,
    tradeScreen,
    reviewTradeScreen,
    aboutScreen,
    showMnemonic,
    verifyMnemonic,
    doneBackup,
    settingsScreen,
    switchCommunityScreen,
    protectYourWallet,
  };
}

class HomeRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(HomeRoutes.mainHomeScreen, page: MainHomeScreen),
    RouteDef(HomeRoutes.transactionDetailsScreen,
        page: TransactionDetailsScreen),
    RouteDef(HomeRoutes.tokenTransfersScreen, page: TokenTransfersScreen),
    RouteDef(HomeRoutes.tradeScreen, page: TradeScreen),
    RouteDef(HomeRoutes.reviewTradeScreen, page: ReviewTradeScreen),
    RouteDef(HomeRoutes.aboutScreen, page: AboutScreen),
    RouteDef(HomeRoutes.showMnemonic, page: ShowMnemonic),
    RouteDef(HomeRoutes.verifyMnemonic, page: VerifyMnemonic),
    RouteDef(HomeRoutes.doneBackup, page: DoneBackup),
    RouteDef(HomeRoutes.settingsScreen, page: SettingsScreen),
    RouteDef(HomeRoutes.switchCommunityScreen, page: SwitchCommunityScreen),
    RouteDef(HomeRoutes.protectYourWallet, page: ProtectYourWallet),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    MainHomeScreen: (RouteData data) {
      var args = data.getArgs<MainHomeScreenArguments>(
          orElse: () => MainHomeScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainHomeScreen(key: args.key),
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
        builder: (context) => TokenTransfersScreen(
          key: args.key,
          token: args.token,
          tokenPrice: args.tokenPrice,
        ),
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
    ReviewTradeScreen: (RouteData data) {
      var args = data.getArgs<ReviewTradeScreenArguments>(
          orElse: () => ReviewTradeScreenArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => ReviewTradeScreen(
          key: args.key,
          exchangeSummry: args.exchangeSummry,
          fromToken: args.fromToken,
          toToken: args.toToken,
        ),
        settings: data,
      );
    },
    AboutScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AboutScreen(),
        settings: data,
      );
    },
    ShowMnemonic: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowMnemonic(),
        settings: data,
      );
    },
    VerifyMnemonic: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyMnemonic(),
        settings: data,
      );
    },
    DoneBackup: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DoneBackup(),
        settings: data,
      );
    },
    SettingsScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
        settings: data,
      );
    },
    SwitchCommunityScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SwitchCommunityScreen(),
        settings: data,
      );
    },
    ProtectYourWallet: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProtectYourWallet(),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//MainHomeScreen arguments holder class
class MainHomeScreenArguments {
  final Key key;
  MainHomeScreenArguments({this.key});
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
  final String tokenPrice;
  TokenTransfersScreenArguments({this.key, this.token, this.tokenPrice});
}

//TradeScreen arguments holder class
class TradeScreenArguments {
  final Key key;
  final Token primaryToken;
  TradeScreenArguments({this.key, this.primaryToken});
}

//ReviewTradeScreen arguments holder class
class ReviewTradeScreenArguments {
  final Key key;
  final Map<dynamic, dynamic> exchangeSummry;
  final Token fromToken;
  final Token toToken;
  ReviewTradeScreenArguments(
      {this.key, this.exchangeSummry, this.fromToken, this.toToken});
}
