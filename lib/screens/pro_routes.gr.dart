// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bit2c/screens/pro_mode/pro_mode.dart';
import 'package:bit2c/screens/pro_mode/token_transfers.dart';
import 'package:bit2c/models/pro/token.dart';

class ProRouter {
  static const proModeHomeScreen = '/';
  static const tokenTransfersScreen = '/token-transfers-screen';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ProRouter.proModeHomeScreen:
        if (hasInvalidArgs<ProModeScaffoldArguments>(args)) {
          return misTypedArgsRoute<ProModeScaffoldArguments>(args);
        }
        final typedArgs =
            args as ProModeScaffoldArguments ?? ProModeScaffoldArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              ProModeScaffold(key: typedArgs.key, tabIndex: typedArgs.tabIndex),
          settings: settings,
        );
      case ProRouter.tokenTransfersScreen:
        if (hasInvalidArgs<TokenTransfersScreenArguments>(args)) {
          return misTypedArgsRoute<TokenTransfersScreenArguments>(args);
        }
        final typedArgs = args as TokenTransfersScreenArguments ??
            TokenTransfersScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) =>
              TokenTransfersScreen(key: typedArgs.key, token: typedArgs.token),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//ProModeScaffold arguments holder class
class ProModeScaffoldArguments {
  final Key key;
  final int tabIndex;
  ProModeScaffoldArguments({this.key, this.tabIndex = 0});
}

//TokenTransfersScreen arguments holder class
class TokenTransfersScreenArguments {
  final Key key;
  final Token token;
  TokenTransfersScreenArguments({this.key, this.token});
}
