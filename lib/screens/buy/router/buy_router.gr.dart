// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../models/community/business.dart';
import '../../../models/tokens/token.dart';
import '../../backup/show_mnemonic.dart';
import '../../profile/screen/profile.dart';
import '../business.dart';
import '../buy.dart';
import '../map.dart';

class BusinessesRoutes {
  static const String buyScreen = '/';
  static const String businessPage = '/business-page';
  static const String mapScreen = '/map-screen';
  static const String profileScreen = '/profile-screen';
  static const String showMnemonic = '/show-mnemonic';
  static const all = <String>{
    buyScreen,
    businessPage,
    mapScreen,
    profileScreen,
    showMnemonic,
  };
}

class BuyRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(BusinessesRoutes.buyScreen, page: BuyScreen),
    RouteDef(BusinessesRoutes.businessPage, page: BusinessPage),
    RouteDef(BusinessesRoutes.mapScreen, page: MapScreen),
    RouteDef(BusinessesRoutes.profileScreen, page: ProfileScreen),
    RouteDef(BusinessesRoutes.showMnemonic, page: ShowMnemonic),
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
    ProfileScreen: (data) {
      final args = data.getArgs<ProfileScreenArguments>(
        orElse: () => ProfileScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileScreen(key: args.key),
        settings: data,
      );
    },
    ShowMnemonic: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowMnemonic(),
        settings: data,
      );
    },
  };
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

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final Key key;
  ProfileScreenArguments({this.key});
}
