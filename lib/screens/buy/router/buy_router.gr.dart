// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../models/community/business.dart';
import '../../../models/tokens/token.dart';
import '../business.dart';
import '../businesses_list_page.dart';
import '../buy.dart';
import '../map.dart';

class BusinessesRoutes {
  static const String buyScreen = '/';
  static const String businessesListScreen = '/businesses-list-screen';
  static const String businessPage = '/business-page';
  static const String mapScreen = '/map-screen';
  static const all = <String>{
    buyScreen,
    businessesListScreen,
    businessPage,
    mapScreen,
  };
}

class BuyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(BusinessesRoutes.buyScreen, page: BuyScreen),
    RouteDef(BusinessesRoutes.businessesListScreen, page: BusinessesListScreen),
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
    BusinessesListScreen: (data) {
      final args = data.getArgs<BusinessesListScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusinessesListScreen(
          args.businesses,
          args.communityAddress,
          args.token,
          args.title,
        ),
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

  Future<dynamic> pushBusinessesListScreen({
    @required List<Business> businesses,
    @required String communityAddress,
    @required Token token,
    @required String title,
  }) =>
      push<dynamic>(
        BusinessesRoutes.businessesListScreen,
        arguments: BusinessesListScreenArguments(
            businesses: businesses,
            communityAddress: communityAddress,
            token: token,
            title: title),
      );

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

/// BusinessesListScreen arguments holder class
class BusinessesListScreenArguments {
  final List<Business> businesses;
  final String communityAddress;
  final Token token;
  final String title;
  BusinessesListScreenArguments(
      {@required this.businesses,
      @required this.communityAddress,
      @required this.token,
      @required this.title});
}

/// BusinessPage arguments holder class
class BusinessPageArguments {
  final Business business;
  final Token token;
  BusinessPageArguments({this.business, this.token});
}
