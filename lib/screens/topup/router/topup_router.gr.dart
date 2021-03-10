// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/topup.dart';
import '../screens/topup_explained.dart';

class TopupRoutes {
  static const String topupExplained = '/';
  static const String topupScreen = '/topup-screen';
  static const all = <String>{
    topupExplained,
    topupScreen,
  };
}

class TopupRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(TopupRoutes.topupExplained, page: TopupExplained),
    RouteDef(TopupRoutes.topupScreen, page: TopupScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    TopupExplained: (data) {
      final args = data.getArgs<TopupExplainedArguments>(
        orElse: () => TopupExplainedArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TopupExplained(key: args.key),
        settings: data,
      );
    },
    TopupScreen: (data) {
      final args = data.getArgs<TopupScreenArguments>(
        orElse: () => TopupScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TopupScreen(topupType: args.topupType),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension TopupRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushTopupExplained({
    Key key,
  }) =>
      push<dynamic>(
        TopupRoutes.topupExplained,
        arguments: TopupExplainedArguments(key: key),
      );

  Future<dynamic> pushTopupScreen({
    TopupType topupType = TopupType.STRIPE,
  }) =>
      push<dynamic>(
        TopupRoutes.topupScreen,
        arguments: TopupScreenArguments(topupType: topupType),
      );
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TopupExplained arguments holder class
class TopupExplainedArguments {
  final Key key;
  TopupExplainedArguments({this.key});
}

/// TopupScreen arguments holder class
class TopupScreenArguments {
  final TopupType topupType;
  TopupScreenArguments({this.topupType = TopupType.STRIPE});
}
