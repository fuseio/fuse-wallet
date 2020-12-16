// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../backup/show_mnemonic.dart';
import '../../profile/screen/profile.dart';
import '../screens/contacts_list.dart';
import '../screens/empty_contacts.dart';

class ContactsRoutes {
  static const String contactsList = '/contacts-list';
  static const String showMnemonic = '/show-mnemonic';
  static const String profileScreen = '/profile-screen';
  static const String emptyContacts = '/';
  static const all = <String>{
    contactsList,
    showMnemonic,
    profileScreen,
    emptyContacts,
  };
}

class ContactsRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(ContactsRoutes.contactsList, page: ContactsList),
    RouteDef(ContactsRoutes.showMnemonic, page: ShowMnemonic),
    RouteDef(ContactsRoutes.profileScreen, page: ProfileScreen),
    RouteDef(ContactsRoutes.emptyContacts, page: EmptyContacts),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ContactsList: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ContactsList(),
        settings: data,
      );
    },
    ShowMnemonic: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ShowMnemonic(),
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
    EmptyContacts: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EmptyContacts(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ProfileScreen arguments holder class
class ProfileScreenArguments {
  final Key key;
  ProfileScreenArguments({this.key});
}
