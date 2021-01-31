// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/tokens/token.dart';
import 'review_trade.dart';
import 'trade.dart';

class TradeRoutes {
  static const String tradeScreen = '/';
  static const String reviewTradeScreen = '/review-trade-screen';
  static const all = <String>{
    tradeScreen,
    reviewTradeScreen,
  };
}

class TradeRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(TradeRoutes.tradeScreen, page: TradeScreen),
    RouteDef(TradeRoutes.reviewTradeScreen, page: ReviewTradeScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    TradeScreen: (data) {
      final args = data.getArgs<TradeScreenArguments>(
        orElse: () => TradeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TradeScreen(
          key: args.key,
          primaryToken: args.primaryToken,
        ),
        settings: data,
      );
    },
    ReviewTradeScreen: (data) {
      final args = data.getArgs<ReviewTradeScreenArguments>(
        orElse: () => ReviewTradeScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ReviewTradeScreen(
          key: args.key,
          swapObject: args.swapObject,
          fromToken: args.fromToken,
          toToken: args.toToken,
          amountIn: args.amountIn,
          amountOut: args.amountOut,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension TradeRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushTradeScreen({
    Key key,
    Token primaryToken,
  }) =>
      push<dynamic>(
        TradeRoutes.tradeScreen,
        arguments: TradeScreenArguments(key: key, primaryToken: primaryToken),
      );

  Future<dynamic> pushReviewTradeScreen({
    Key key,
    Map<dynamic, dynamic> swapObject,
    Token fromToken,
    Token toToken,
    String amountIn,
    String amountOut,
  }) =>
      push<dynamic>(
        TradeRoutes.reviewTradeScreen,
        arguments: ReviewTradeScreenArguments(
            key: key,
            swapObject: swapObject,
            fromToken: fromToken,
            toToken: toToken,
            amountIn: amountIn,
            amountOut: amountOut),
      );
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TradeScreen arguments holder class
class TradeScreenArguments {
  final Key key;
  final Token primaryToken;
  TradeScreenArguments({this.key, this.primaryToken});
}

/// ReviewTradeScreen arguments holder class
class ReviewTradeScreenArguments {
  final Key key;
  final Map<dynamic, dynamic> swapObject;
  final Token fromToken;
  final Token toToken;
  final String amountIn;
  final String amountOut;
  ReviewTradeScreenArguments(
      {this.key,
      this.swapObject,
      this.fromToken,
      this.toToken,
      this.amountIn,
      this.amountOut});
}
