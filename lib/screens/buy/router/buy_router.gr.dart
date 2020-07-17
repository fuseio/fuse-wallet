// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/buy/business.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/buy/map.dart';

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
    BuyScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BuyScreen(),
        settings: data,
      );
    },
    BusinessPage: (RouteData data) {
      var args = data.getArgs<BusinessPageArguments>(
          orElse: () => BusinessPageArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusinessPage(
          business: args.business,
          token: args.token,
          communityAddress: args.communityAddress,
        ),
        settings: data,
      );
    },
    MapScreen: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MapScreen(),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//BusinessPage arguments holder class
class BusinessPageArguments {
  final Business business;
  final Token token;
  final String communityAddress;
  BusinessPageArguments({this.business, this.token, this.communityAddress});
}
