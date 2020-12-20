import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:bit2c/generated/i18n.dart';
import 'package:bit2c/models/app_state.dart';
import 'package:bit2c/models/views/contacts.dart';
import 'package:bit2c/screens/contacts/screens/send_to_account.dart';
import 'package:bit2c/screens/contacts/widgets/contact_tile.dart';
import 'package:bit2c/screens/contacts/widgets/list_header.dart';
import 'package:bit2c/screens/contacts/widgets/recent_contacts.dart';
import 'package:bit2c/screens/contacts/widgets/search_panel.dart';
import 'package:bit2c/utils/contacts.dart';
import 'package:bit2c/utils/phone.dart';
import 'package:bit2c/utils/send.dart';
import 'package:bit2c/widgets/main_scaffold.dart';
import "package:ethereum_address/ethereum_address.dart";
import 'package:bit2c/widgets/preloader.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> userList = [];
  List<Contact> filteredUsers = [];
  bool hasSynced = false;
  TextEditingController searchController = TextEditingController();
  List<Contact> _contacts;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        onInitialBuild: (viewModel) {
          Segment.screen(screenName: '/contacts-screen');
        },
        converter: ContactsViewModel.fromStore,
        builder: (_, viewModel) {
          return _contacts != null
              ? MainScaffold(
                  automaticallyImplyLeading: false,
                  title: I18n.of(context).send_to,
                  sliverList: _buildPageList(viewModel),
                )
              : Center(
                  child: Preloader(),
                );
        });
  }

  Future<void> refreshContacts() async {
    List<Contact> contacts = await ContactController.getContacts();
    if (mounted) {
      setState(() {
        _contacts = contacts;
      });
    }

    filterList();
    searchController.addListener(filterList);

    if (Platform.isAndroid) {
      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return;
          if (mounted) {
            setState(() => contact.avatar = avatar);
          }
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    refreshContacts();
  }

  filterList() {
    List<Contact> users = [];
    users.addAll(_contacts);
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.displayName
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }

    if (this.mounted) {
      setState(() {
        filteredUsers = users;
      });
    }
  }

  void resetSearch() {
    FocusScope.of(context).unfocus();
    if (mounted) {
      setState(() {
        searchController.text = '';
      });
    }
  }

  SliverList listBody(ContactsViewModel viewModel, List<Contact> group) {
    List<Widget> listItems = List();
    for (Contact user in group) {
      Iterable<Item> phones = user.phones
          .map((e) => Item(
              label: e.label, value: clearNotNumbersAndPlusSymbol(e.value)))
          .toSet()
          .toList();
      for (Item phone in phones) {
        listItems.add(ContactTile(
            image: user.avatar != null && user.avatar.isNotEmpty
                ? MemoryImage(user.avatar)
                : null,
            displayName: user.displayName,
            phoneNumber: phone.value,
            onTap: () {
              resetSearch();
              sendToContact(ExtendedNavigator.named('contactsRouter').context,
                  user.displayName, phone.value,
                  isoCode: viewModel.isoCode,
                  countryCode: viewModel.countryCode,
                  avatar: user.avatar != null && user.avatar.isNotEmpty
                      ? MemoryImage(user.avatar)
                      : new AssetImage('assets/images/anom.png'));
            },
            trailing: Text(
              phone.value,
              style: TextStyle(
                  fontSize: 13, color: Theme.of(context).primaryColor),
            )));
      }
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  List<Widget> _buildPageList(ContactsViewModel viewModel) {
    List<Widget> listItems = List();

    listItems.add(SearchPanel(
      searchController: searchController,
    ));

    if (searchController.text.isEmpty) {
      listItems.add(RecentContacts());
    } else if (isValidEthereumAddress(searchController.text)) {
      listItems.add(SendToAccount(
        accountAddress: searchController.text,
        resetSearch: resetSearch,
      ));
    }

    Map<String, List<Contact>> groups = new Map<String, List<Contact>>();
    for (Contact c in filteredUsers) {
      String groupName = c.displayName[0];
      if (!groups.containsKey(groupName)) {
        groups[groupName] = new List<Contact>();
      }
      groups[groupName].add(c);
    }

    List<String> titles = groups.keys.toList()..sort();

    for (String title in titles) {
      List<Contact> group = groups[title];
      listItems.add(ListHeader(title: title));
      listItems.add(listBody(viewModel, group));
    }

    return listItems;
  }
}
