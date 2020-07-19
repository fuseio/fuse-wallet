// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fusecash/screens/contacts/contacts_list.dart';
import 'package:fusecash/screens/contacts/send_contact.dart';

class ContactsRoutes {
  static const String contactsList = '/contacts-list';
  static const String emptyContacts = '/';
  static const all = <String>{
    contactsList,
    emptyContacts,
  };
}

class ContactsRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(ContactsRoutes.contactsList, page: ContactsList),
    RouteDef(ContactsRoutes.emptyContacts, page: EmptyContacts),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ContactsList: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ContactsList(),
        settings: data,
      );
    },
    EmptyContacts: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EmptyContacts(),
        settings: data,
      );
    },
  };
}
