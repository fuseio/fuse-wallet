import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/contacts.dart';
import 'package:fusecash/screens/send/contact_tile.dart';
import 'package:fusecash/screens/send/recent_contacts.dart';
import 'package:fusecash/utils/barcode.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:fusecash/utils/send.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import "package:ethereum_address/ethereum_address.dart";
import 'package:fusecash/widgets/preloader.dart';
import 'package:fusecash/widgets/silver_app_bar.dart';

class ContactsList extends StatefulWidget {
  final List<Contact> contacts;
  ContactsList({this.contacts});

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> userList = [];
  List<Contact> filteredUsers = [];
  bool hasSynced = false;
  TextEditingController searchController = TextEditingController();
  bool isPreloading = false;
  List<Contact> _contacts;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        onInit: (store) {
          Segment.screen(screenName: '/send-to-contact-screen');
        },
        converter: ContactsViewModel.fromStore,
        builder: (_, viewModel) {
          return _contacts != null
              ? MainScaffold(
                  automaticallyImplyLeading: false,
                  title: I18n.of(context).send_to,
                  sliverList: _buildPageList(context, viewModel),
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
    searchController.addListener(() {
      filterList();
    });

    for (final contact in contacts) {
      ContactsService.getAvatar(contact).then((avatar) {
        if (avatar == null) return;
        if (mounted) {
          setState(() => contact.avatar = avatar);
        }
      });
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

  listHeader(String title) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: 40.0,
        maxHeight: 40.0,
        child: Container(
          color: Color(0xFFF8F8F8),
          padding: EdgeInsets.only(left: 20, top: 7),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  listBody(BuildContext context, ContactsViewModel viewModel, List<Contact> group) {
    List<Widget> listItems = List();

    for (Contact user in group) {
      Iterable<Item> phones = user.phones.map((e) => Item(label: e.label, value: clearNotNumbersAndPlusSymbol(e.value))).toSet().toList();
      for (Item phone in phones) {
        listItems.add(ContactTile(
            avatar: user.avatar,
            displayName: user.displayName,
            phoneNumber: phone.value,
            onTap: () {
              sendToContact(context, viewModel, user.displayName, phone.value, avatar: user.avatar);
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

  Widget sendToAcccountAddress(BuildContext context, ContactsViewModel viewModel, String accountAddress) {
    Widget component = ContactTile(
      displayName: formatAddress(accountAddress),
      onTap: () {
        sendToPastedAddress(context, viewModel, accountAddress);
      },
      trailing: InkWell(
        child: Text(
          I18n.of(context).next_button,
          style: TextStyle(color: Color(0xFF0377FF)),
        ),
        onTap: () {
          sendToPastedAddress(context, viewModel, accountAddress);
        },
      ),
    );
    return SliverList(
      delegate: SliverChildListDelegate([component]),
    );
  }

  List<Widget> _buildPageList(context, ContactsViewModel viewModel) {
    List<Widget> listItems = List();

    listItems.add(searchPanel());

    if (searchController.text.isEmpty && !viewModel.isProMode) {
      listItems.add(RecentContacts());
    } else if (isValidEthereumAddress(searchController.text)) {
      listItems.add(
          sendToAcccountAddress(context, viewModel, searchController.text));
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
      listItems.add(listHeader(title));
      listItems.add(listBody(context, viewModel, group));
    }

    return listItems;
  }

  searchPanel() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 100.0,
        child: Container(
          decoration: new BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border:
                  Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TextFormField(
                      controller: searchController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFE0E0E0), width: 3)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF292929)),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFACACAC),
                        ),
                        labelText: I18n.of(context).search,
                      ),
                    ),
                ),
              ),
              Container(
                child: new FloatingActionButton(
                    heroTag: 'cash_scanner',
                    backgroundColor: const Color(0xFF292929),
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/scan.png',
                      width: 25.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: () {
                      bracodeScannerHandler(context);
                    }),
                width: 50.0,
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
