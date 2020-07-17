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

class HomeRoutes {
  static const String mainHomeScreen = '/';
  static const String transactionDetailsScreen = '/transaction-details-screen';
  static const String tokenTransfersScreen = '/token-transfers-screen';
  static const String tradeScreen = '/trade-screen';
  static const all = <String>{
    mainHomeScreen,
    transactionDetailsScreen,
    tokenTransfersScreen,
    tradeScreen,
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
