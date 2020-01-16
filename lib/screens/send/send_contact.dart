import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/models/views/contacts.dart';
import 'package:fusecash/screens/cash_home/cash_transactions.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:redux/redux.dart';
import 'dart:math' as math;

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendToContactScreen extends StatefulWidget {
  final ContactsViewModel viewModel;

  SendToContactScreen(this.viewModel);

  @override
  _SendToContactScreenState createState() => _SendToContactScreenState();
}

class _SendToContactScreenState extends State<SendToContactScreen> {
  List<Contact> userList = [];
  List<String> strList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();
  bool isPreloading = false;

  loadContacts() async {
    for (var contact in this.widget.viewModel.contacts) {
      userList.add(contact);
    }
    userList.sort((a, b) =>
        a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
    });

    setState(() {
      isPreloading = false;
    });
  }

  @override
  void initState() {
    loadContacts();
    super.initState();
  }

  filterList() {
    List<Contact> users = [];
    users.addAll(userList);
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.displayName
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    users.forEach((user) {
      normalList.add(
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              iconWidget: Icon(Icons.star),
              onTap: () {},
            ),
            IconSlideAction(
              iconWidget: Icon(Icons.more_horiz),
              onTap: () {},
            ),
          ],
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
                style: TextStyle(fontSize: 15),
              ),
              //subtitle: Text("user.company" ?? ""),
              onTap: () {
                Navigator.pushNamed(context, '/SendAmount',
                    arguments: SendAmountArguments(
                        name: user.displayName,
                        avatar: user.avatar != null && user.avatar.isNotEmpty
                            ? MemoryImage(user.avatar)
                            : new AssetImage('assets/images/anom.png'),
                        phoneNumber: user.phones.toList()[0].value));
              },
            ),
          ),
        ),
      );
      strList.add(user.displayName);
    });

    if (this.mounted) {
      setState(() {
        strList = strList;
        normalList = normalList;
        strList = strList;
      });
    }
  }

  listHeader(title) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: _SliverAppBarDelegate(
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

  listBody(title) {
    List<Widget> listItems = List();

    //strList.where((i) => i.startsWith(title)).toList()
    for (int i = 0; i < strList.length; i++) {
      if (strList[i][0] == title) {
        listItems.add(normalList[i]);
      }
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  Widget recentContacts(numToShow) {
    List<Widget> listItems = List();
    final sorted = new List<Transaction>.from(
            this.widget.viewModel.transactions.list.toSet().toList())
        .where((t) {
      return t.type == 'SEND';
    }).toList()
          ..sort((a, b) {
            if (a.blockNumber != null && b.blockNumber != null) {
              return b.blockNumber?.compareTo(a.blockNumber);
            } else {
              return b.status.compareTo(a.status);
            }
          });

    Map<String, Transaction> uniqueValues = {};
    for (var item in sorted) {
      final Contact contact = getContact(
          item,
          this.widget.viewModel.reverseContacts,
          this.widget.viewModel.contacts,
          this.widget.viewModel.countryCode);
      var a = contact != null
          ? contact.displayName
          : deducePhoneNumber(item, this.widget.viewModel.reverseContacts);
      uniqueValues[a] = item;
    }

    dynamic uniqueList = uniqueValues.values.toList().length > numToShow
        ? uniqueValues.values.toList().sublist(0, numToShow)
        : uniqueValues.values.toList();
    for (int i = 0; i < uniqueList.length; i++) {
      if (i == 0) {
        listItems.add(Container(
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 8),
            child: Text("Recent",
                style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal))));
      }
      final Transaction transaction = uniqueList[i];
      final Contact contact = getContact(
          transaction,
          this.widget.viewModel.reverseContacts,
          this.widget.viewModel.contacts,
          this.widget.viewModel.countryCode);
      listItems.add(
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              iconWidget: Icon(Icons.star),
              onTap: () {},
            ),
            IconSlideAction(
              iconWidget: Icon(Icons.more_horiz),
              onTap: () {},
            ),
          ],
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
                backgroundImage: contact?.avatar != null
                    ? MemoryImage(contact.avatar)
                    : new AssetImage('assets/images/anom.png'),
              ),
              title: Text(
                contact != null
                    ? contact.displayName
                    : deducePhoneNumber(
                        transaction, this.widget.viewModel.reverseContacts),
                style: TextStyle(fontSize: 16),
              ),
              //subtitle: Text("user.company" ?? ""),
              onTap: () {
                Navigator.pushNamed(context, '/SendAmount',
                    arguments: SendAmountArguments(
                        name: contact != null
                            ? contact.displayName
                            : deducePhoneNumber(transaction,
                                this.widget.viewModel.reverseContacts),
                        avatar: contact?.avatar != null
                            ? MemoryImage(contact.avatar)
                            : new AssetImage('assets/images/anom.png'),
                        phoneNumber: contact.phones.toList()[0].value));
              },
            ),
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }

  List<Widget> _buildPageList() {
    List<Widget> listItems = List();

    if (isPreloading) {
      return listItems;
    }
    List<String> abList = new List<String>();

    for (int i = 0; i < strList.length; i++) {
      if (!abList.contains(strList[i][0])) {
        abList.add(strList[i][0]);
      }
    }

    listItems.add(searchPanel());
    if (searchController.text.isEmpty) {
      listItems.add(recentContacts(3));
    }

    for (int index = 0; index < abList.length; index++) {
      listItems.add(listHeader(abList[index]));
      listItems.add(listBody(abList[index]));
    }

    return listItems;
  }

  searchPanel() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 100.0,
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
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
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFE0E0E0), width: 3)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF292929)),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFACACAC),
                      ),
                      labelText: "Search",
                    ),
                  ),
                ),
              ),
              Container(
                child: new FloatingActionButton(
                    backgroundColor: const Color(0xFF292929),
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/scan.png',
                      width: 25.0,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      String accountAddress = await BarcodeScanner.scan();
                      List<String> parts = accountAddress.split(':');
                      if (parts.length == 2 && parts[0] == 'fuse') {
                        Navigator.pushNamed(context, '/SendAmount',
                            arguments:
                                SendAmountArguments(accountAddress: parts[1]));
                      } else {
                        print('Account address is not on Fuse');
                      }
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

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      withPadding: true,
      title: "Send to",
      titleFontSize: 15,
      sliverList: _buildPageList(),
      children: <Widget>[
        !this.widget.viewModel.isContactsSynced
            ? Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container()
      ],
    );
  }
}

class User {
  final String name;
  final String company;
  final bool favourite;

  User(this.name, this.company, this.favourite);
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool isSync = false;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: ContactsViewModel.fromStore,
        onInit: (Store<AppState> store) async {
        bool isPermitted = await Contacts.checkPermissions();
          setState(() {
            isSync = isPermitted;
          });
        },
        builder: (_, viewModel) {
          if (!isSync) {
            return MainScaffold(
                withPadding: true,
                title: "Send to",
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 180),
                        child: SvgPicture.asset(
                          'assets/images/contacts.svg',
                          width: 50.0,
                          height: 50,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: new InkWell(
                          onTap: () async {
                            bool premission = await ContactController.getPermissions();
                            if (premission) {
                              List<Contact> contacts = await ContactController.getContacts();
                              viewModel.syncContacts(contacts);
                            }
                          },
                          child: new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Text("Click here to sync your contacts"),
                          ),
                        ),
                      )
                    ],
                  )
                ]);
          } else {
            return SendToContactScreen(viewModel);
          }
        });
  }
}
