import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/features/contacts/widgets/empty_state.dart';
// import 'package:fusecash/features/contacts/widgets/recent_contacts.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/contacts.dart';
import 'package:fusecash/features/contacts/widgets/send_to_account.dart';
import 'package:fusecash/features/contacts/widgets/contact_tile.dart';
import 'package:fusecash/features/contacts/widgets/list_header.dart';
import 'package:fusecash/features/contacts/widgets/search_panel.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/utils/send.dart';
import "package:ethereum_address/ethereum_address.dart";
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';

class ContactsList extends StatefulWidget {
  final SendFlowArguments? pageArgs;
  ContactsList({
    this.pageArgs,
  });
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> filteredUsers = [];
  TextEditingController searchController = TextEditingController();
  List<Contact>? _contacts;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
      distinct: true,
      onInitialBuild: (viewModel) {
        refreshContacts(viewModel.contacts);
      },
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.contacts != newViewModel.contacts) {
          refreshContacts(newViewModel.contacts);
        }
      },
      converter: ContactsViewModel.fromStore,
      builder: (_, viewModel) {
        return _contacts != null
            ? MyScaffold(
                title: I10n.of(context).send_to,
                body: InkWell(
                  focusColor: Theme.of(context).canvasColor,
                  highlightColor: Theme.of(context).canvasColor,
                  onTap: () {
                    WidgetsBinding.instance!.focusManager.primaryFocus
                        ?.unfocus();
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: CustomScrollView(
                          slivers: <Widget>[..._buildPageList(viewModel)],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Preloader(),
              );
      },
    );
  }

  Future<void> refreshContacts(List<Contact> contacts) async {
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

  filterList() {
    List<Contact> users = [];
    users.addAll(_contacts ?? []);
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.displayName!
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
    List<Widget> listItems = <Widget>[];
    for (Contact user in group) {
      Iterable<Item> phones = user.phones!
          .map((e) => Item(value: clearNotNumbersAndPlusSymbol(e.value!)))
          .toSet()
          .toList();
      for (Item phone in phones) {
        listItems.add(
          ContactTile(
            image: user.avatar != null && (user.avatar?.isNotEmpty ?? false)
                ? MemoryImage(user.avatar!)
                : null,
            displayName: user.displayName!,
            onTap: () {
              resetSearch();
              sendToContact(
                context,
                user.displayName!,
                phone.value!,
                viewModel.countryCode,
                viewModel.isoCode,
                tokenToSend: widget.pageArgs?.tokenToSend,
              );
            },
            trailing: Text(
              phone.value!,
              style: TextStyle(fontSize: 13),
            ),
          ),
        );
      }
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  List<Widget> _buildPageList(ContactsViewModel viewModel) {
    List<Widget> listItems = [];

    listItems.add(SearchPanel(
      searchController: searchController,
    ));
    final String accountAddress = ![null, ''].contains(searchController.text) &&
            searchController.text.length > 1 &&
            searchController.text[1] == 'f'
        ? searchController.text.replaceFirst('f', 'x')
        : searchController.text;
    if (isValidEthereumAddress(accountAddress)) {
      listItems.add(
        SendToAccount(
          accountAddress: accountAddress,
          resetSearch: resetSearch,
          token: widget.pageArgs?.tokenToSend,
        ),
      );
    } else {
      Map<String, List<Contact>> groups = new Map<String, List<Contact>>();
      for (Contact c in filteredUsers) {
        String groupName = c.displayName![0];
        if (!groups.containsKey(groupName)) {
          groups[groupName] = [];
        }
        groups[groupName]!.add(c);
      }

      if (groups.isEmpty) {
        listItems.add(SliverList(
          delegate: SliverChildListDelegate([
            EmptyState(),
          ]),
        ));
        // if (searchController.text.isEmpty) {
        //   listItems.insert(
        //     1,
        //     RecentContacts(
        //       token: widget.pageArgs?.tokenToSend,
        //     ),
        //   );
        // }
      } else {
        List<String> titles = groups.keys.toList()..sort();
        for (String title in titles) {
          List<Contact> group = groups[title]!;
          listItems.add(ListHeader(title: title));
          listItems.add(listBody(viewModel, group));
        }
        // if (searchController.text.isEmpty) {
        //   listItems.insert(
        //     1,
        //     RecentContacts(
        //       token: widget.pageArgs?.tokenToSend,
        //     ),
        //   );
        // }
      }
    }

    return listItems;
  }
}
