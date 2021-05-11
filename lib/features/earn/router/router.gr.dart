// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/earn.dart';
import '../screens/earn_coming_soon.dart';

class EarnRoutes {
  static const String earnScreen = '/earn-screen';
  static const String earnComingSoonScreen = '/';
  static const all = <String>{
    earnScreen,
    earnComingSoonScreen,
  };
}

class EarnRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(EarnRoutes.earnScreen, page: EarnScreen),
    RouteDef(EarnRoutes.earnComingSoonScreen, page: EarnComingSoonScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    EarnScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EarnScreen(),
        settings: data,
      );
    },
    EarnComingSoonScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EarnComingSoonScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension EarnRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushEarnScreen() => push<dynamic>(EarnRoutes.earnScreen);

  Future<dynamic> pushEarnComingSoonScreen() =>
      push<dynamic>(EarnRoutes.earnComingSoonScreen);
}
