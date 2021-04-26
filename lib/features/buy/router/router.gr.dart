// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../models/community/business.dart';
import '../../../models/tokens/token.dart';
import '../screens/business.dart';
import '../screens/buy.dart';
import '../screens/map.dart';

class BusinessesRoutes {
  static const String buyScreen = '/';
  static const String businessPage = '/business-page';
  static const String mapScreen = '/map-screen';
  static const all = <String>{
    buyScreen,
    businessPage,
    mapScreen,
  };
}

class BuyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(BusinessesRoutes.buyScreen, page: BuyScreen),
    RouteDef(BusinessesRoutes.businessPage, page: BusinessPage),
    RouteDef(BusinessesRoutes.mapScreen, page: MapScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    BuyScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BuyScreen(),
        settings: data,
      );
    },
    BusinessPage: (data) {
      final args = data.getArgs<BusinessPageArguments>(
        orElse: () => BusinessPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusinessPage(
          business: args.business,
          token: args.token,
        ),
        settings: data,
      );
    },
    MapScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MapScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension BuyRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushBuyScreen() => push<dynamic>(BusinessesRoutes.buyScreen);

  Future<dynamic> pushBusinessPage({
    Business business,
    Token token,
  }) =>
      push<dynamic>(
        BusinessesRoutes.businessPage,
        arguments: BusinessPageArguments(business: business, token: token),
      );

  Future<dynamic> pushMapScreen() => push<dynamic>(BusinessesRoutes.mapScreen);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// BusinessPage arguments holder class
class BusinessPageArguments {
  final Business business;
  final Token token;
  BusinessPageArguments({this.business, this.token});
}
