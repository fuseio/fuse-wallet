// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/account_screen.dart';
import '../screens/done_backup_screen.dart';
import '../screens/profile.dart';
import '../screens/protect_your_wallet.dart';
import '../screens/settings.dart';
import '../screens/show_mnemonic.dart';
import '../screens/social_screen.dart';
import '../screens/verify_mnemonic.dart';

class AccountRoutes {
  static const String accountScreen = '/';
  static const String showMnemonic = '/show-mnemonic';
  static const String verifyMnemonic = '/verify-mnemonic';
  static const String doneBackup = '/done-backup';
  static const String settingsScreen = '/settings-screen';
  static const String protectYourWallet = '/protect-your-wallet';
  static const String profileScreen = '/profile-screen';
  static const String socialScreen = '/social-screen';
  static const all = <String>{
    accountScreen,
    showMnemonic,
    verifyMnemonic,
    doneBackup,
    settingsScreen,
    protectYourWallet,
    profileScreen,
    socialScreen,
  };
}

class AccountRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(AccountRoutes.accountScreen, page: AccountScreen),
    RouteDef(AccountRoutes.showMnemonic, page: ShowMnemonic),
    RouteDef(AccountRoutes.verifyMnemonic, page: VerifyMnemonic),
    RouteDef(AccountRoutes.doneBackup, page: DoneBackup),
    RouteDef(AccountRoutes.settingsScreen, page: SettingsScreen),
    RouteDef(AccountRoutes.protectYourWallet, page: ProtectYourWallet),
    RouteDef(AccountRoutes.profileScreen, page: ProfileScreen),
    RouteDef(AccountRoutes.socialScreen, page: SocialScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    AccountScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AccountScreen(),
        settings: data,
      );
    },
    ShowMnemonic: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowMnemonic(),
        settings: data,
      );
    },
    VerifyMnemonic: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyMnemonic(),
        settings: data,
      );
    },
    DoneBackup: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DoneBackup(),
        settings: data,
      );
    },
    SettingsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SettingsScreen(),
        settings: data,
      );
    },
    ProtectYourWallet: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProtectYourWallet(),
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
    SocialScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SocialScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension AccountRouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushAccountScreen() =>
      push<dynamic>(AccountRoutes.accountScreen);

  Future<dynamic> pushShowMnemonic() =>
      push<dynamic>(AccountRoutes.showMnemonic);

  Future<dynamic> pushVerifyMnemonic() =>
      push<dynamic>(AccountRoutes.verifyMnemonic);

  Future<dynamic> pushDoneBackup() => push<dynamic>(AccountRoutes.doneBackup);

  Future<dynamic> pushSettingsScreen() =>
      push<dynamic>(AccountRoutes.settingsScreen);

  Future<dynamic> pushProtectYourWallet() =>
      push<dynamic>(AccountRoutes.protectYourWallet);

  Future<dynamic> pushProfileScreen({
    Key key,
  }) =>
      push<dynamic>(
        AccountRoutes.profileScreen,
        arguments: ProfileScreenArguments(key: key),
      );

  Future<dynamic> pushSocialScreen() =>
      push<dynamic>(AccountRoutes.socialScreen);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final Key key;
  ProfileScreenArguments({this.key});
}
