// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:roost/screens/pro_mode/pro_mode.dart';

class ProRouter {
  static const proModeHomeScreen = '/';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ProRouter.proModeHomeScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ProModeScaffold(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
