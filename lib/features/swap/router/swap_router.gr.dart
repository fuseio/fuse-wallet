// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../models/tokens/token.dart';
import '../screens/swap.dart';

class SwapRoutes {
  static const String swapScreen = '/';
  static const all = <String>{
    swapScreen,
  };
}

class SwapRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(SwapRoutes.swapScreen, page: SwapScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
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
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension SwapRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushSwapScreen({
    Key key,
    Token primaryToken,
  }) =>
      push<dynamic>(
        SwapRoutes.swapScreen,
        arguments: SwapScreenArguments(key: key, primaryToken: primaryToken),
      );
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SwapScreen arguments holder class
class SwapScreenArguments {
  final Key key;
  final Token primaryToken;
  SwapScreenArguments({this.key, this.primaryToken});
}
