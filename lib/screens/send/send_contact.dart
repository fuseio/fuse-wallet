import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/models/views/contacts.dart';
import 'package:peepl/screens/send/recent_contacts.dart';
import 'package:peepl/utils/barcode.dart';
import 'package:peepl/screens/send/enable_contacts.dart';
import 'package:peepl/screens/send/send_amount.dart';
import 'package:peepl/screens/send/send_amount_arguments.dart';
import 'package:peepl/utils/contacts.dart';
import 'package:peepl/utils/format.dart';
import 'package:peepl/utils/send.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import "package:ethereum_address/ethereum_address.dart";
import 'package:peepl/widgets/silver_app_bar.dart';
import 'package:redux/redux.dart';

class SendToContactScreen extends StatefulWidget {
  @override
  _SendToContactScreenState createState() => _SendToContactScreenState();
}

class _SendToContactScreenState extends State<SendToContactScreen> {
  List<Contact> userList = [];
  List<Contact> filteredUsers = [];
  bool showFooter = true;
  bool hasSynced = false;
  TextEditingController searchController = TextEditingController();
  bool isPreloading = false;

  loadContacts(List<Contact> contacts, isContactsSynced) async {
    bool isPermitted = await Contacts.checkPermissions();
    if (this.mounted) {
      if (!isPermitted && isContactsSynced == null) {
        Future.delayed(
            Duration.zero,
            () => showDialog(
                child: new ContactsConfirmationScreen(), context: context));
      }
      setState(() {
        isPreloading = true;
        hasSynced = isPermitted;
      });
    }
    if (contacts != null) {
      for (var contact in contacts) {
        userList.add(contact);
      }
      userList.sort((a, b) =>
          a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
      filterList();
      searchController.addListener(() {
        filterList();
      });

      if (this.mounted) {
        setState(() {
          isPreloading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _onFocusChange(hasFocus) {
    if (mounted) {
      setState(() {
        showFooter = !hasFocus;
      });
    }
  }

  filterList() {
    List<Contact> users = [];
    users.addAll(userList);
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

  listHeader(title) {
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

  listBody(ContactsViewModel viewModel, List<Contact> group) {
    List<Widget> listItems = List();

    for (Contact user in group) {
      for (Item phone in user.phones.toList()) {
        dynamic component = Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            decoration: new BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                radius: 25,
                backgroundImage: user.avatar != null && user.avatar.isNotEmpty
                    ? MemoryImage(user.avatar)
                    : new AssetImage('assets/images/anom.png'),
              ),
              title: Text(
                user.displayName,
                style: TextStyle(
                    fontSize: 15, color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                phone.value,
                style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () {
                sendToContact(context, viewModel, user.displayName, phone.value,
                    avatar: user.avatar != null && user.avatar.isNotEmpty
                      ? MemoryImage(user.avatar)
                      : new AssetImage('assets/images/anom.png'));
              },
            ),
          ),
        );
        listItems.add(component);
      }
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  Widget sendToAcccountAddress(String accountAddress, viewModel) {
    Widget component = Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: new BoxDecoration(
            border: Border(bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
        child: ListTile(
          contentPadding:
              EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
          leading: CircleAvatar(
            backgroundColor: Color(0xFFE0E0E0),
            radius: 25,
            backgroundImage: new AssetImage('assets/images/anom.png'),
          ),
          title: Text(
            formatAddress(accountAddress),
            style: TextStyle(fontSize: 16),
          ),
          trailing: InkWell(
            child: Text(
              I18n.of(context).next_button,
              style: TextStyle(color: Color(0xFF0377FF)),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => SendAmountScreen(
                          pageArgs: SendAmountArguments(
                              erc20Token: viewModel.isProMode
                                  ? viewModel.daiToken
                                  : null,
                              sendType: viewModel.isProMode
                                  ? SendType.ETHEREUM_ADDRESS
                                  : SendType.PASTED_ADDRESS,
                              accountAddress: accountAddress,
                              name: formatAddress(accountAddress),
                              avatar:
                                  new AssetImage('assets/images/anom.png')))));
            },
          ),
          onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => SendAmountScreen(
                          pageArgs: SendAmountArguments(
                              erc20Token: viewModel.isProMode
                                  ? viewModel.daiToken
                                  : null,
                              sendType: viewModel.isProMode
                                  ? SendType.ETHEREUM_ADDRESS
                                  : SendType.PASTED_ADDRESS,
                              accountAddress: accountAddress,
                              name: formatAddress(accountAddress),
                              avatar:
                                  new AssetImage('assets/images/anom.png')))));
            },
        ),
      ),
    );
    return SliverList(
      delegate: SliverChildListDelegate([component]),
    );
  }

  List<Widget> _buildPageList(viewModel) {
    List<Widget> listItems = List();

    listItems.add(searchPanel());

    if (searchController.text.isEmpty) {
      if (hasSynced) {
        listItems.add(RecentContacts());
      }
    } else if (isValidEthereumAddress(searchController.text)) {
      listItems.add(sendToAcccountAddress(searchController.text, viewModel));
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
      listItems.add(listBody(viewModel, group));
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
                  child: FocusScope(
                    onFocusChange: (showFooter) => _onFocusChange(showFooter),
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

  onInit(Store<AppState> store) {
    Segment.screen(screenName: '/send-to-contact-screen');
    loadContacts(store.state.userState?.contacts ?? [], store.state.userState.isContactsSynced);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: ContactsViewModel.fromStore,
        onInit: onInit,
        builder: (_, viewModel) {
          if (hasSynced) {
            return MainScaffold(
                automaticallyImplyLeading: false,
                title: I18n.of(context).send_to,
                sliverList: _buildPageList(viewModel),
                children: <Widget>[]);
          } else {
            return MainScaffold(
                automaticallyImplyLeading: false,
                title: I18n.of(context).send_to,
                sliverList: _buildPageList(viewModel),
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 100),
                        child: SvgPicture.asset(
                          'assets/images/contacts.svg',
                          width: 70.0,
                          height: 70,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      new Text(I18n.of(context).sync_your_contacts),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            child: new Text(I18n.of(context).learn_more),
                            onTap: () {
                              showDialog(
                                  child: new ContactsConfirmationScreen(),
                                  context: context);
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    I18n.of(context).activate,
                                    style: TextStyle(color: Color(0xFF0377FF)),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                      'assets/images/blue_arrow.svg')
                                ],
                              ),
                              onTap: () async {
                                bool premission =
                                    await ContactController.getPermissions();
                                if (premission) {
                                  List<Contact> contacts =
                                      await ContactController.getContacts();
                                  viewModel.syncContacts(contacts);
                                  loadContacts(
                                      contacts, viewModel.isContactsSynced);
                                  viewModel.trackCall(
                                      "Wallet: Contacts Permission Granted");
                                  viewModel.idenyifyCall(Map.from(
                                      {"Contacts Permission Granted": false}));
                                  setState(() {
                                    hasSynced = true;
                                  });
                                } else {
                                  viewModel.trackCall(
                                      "Wallet: Contacts Permission Rejected");
                                  viewModel.idenyifyCall(Map.from(
                                      {"Contacts Permission Granted": false}));
                                }
                              })
                        ],
                      )
                    ],
                  )
                ]);
          }
        });
  }
}
