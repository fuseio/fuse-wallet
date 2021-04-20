// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/contacts_list.dart';
import '../send_amount_arguments.dart';

class ContactsRoutes {
  static const String contactsList = '/';
  static const all = <String>{
    contactsList,
  };
}

class ContactsRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(ContactsRoutes.contactsList, page: ContactsList),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ContactsList: (data) {
      final args = data.getArgs<ContactsListArguments>(
        orElse: () => ContactsListArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => ContactsList(
          pageArgs: args.pageArgs,
          automaticallyImplyLeading: args.automaticallyImplyLeading,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ContactsList arguments holder class
class ContactsListArguments {
  final SendFlowArguments pageArgs;
  final bool automaticallyImplyLeading;
  ContactsListArguments(
      {this.pageArgs, this.automaticallyImplyLeading = false});
}
