import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fusecash/models/token.dart';
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
     
     /*
     Map<PermissionGroup, PermissionStatus> permissions =
         await PermissionHandler()
             .requestPermissions([PermissionGroup.contacts]);

     Iterable<Contact> contacts =
         await ContactsService.getContacts(withThumbnails: true);
     contacts = contacts
         .where((i) =>
             i.displayName != null && i.displayName != "" && i.phones.length > 0)
         .toList();
*/

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
              contentPadding:  EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                radius: 25,
                backgroundImage: user.avatar != null && user.avatar.isNotEmpty
                    ? MemoryImage(user.avatar)
                    : new AssetImage('assets/images/anom.png'),
              ),
              title: Text(
                user.displayName,
                style: TextStyle(fontSize: 18),
              ),
              //subtitle: Text("user.company" ?? ""),
              onTap: () {
                Navigator.pushNamed(context, '/SendAmount',
                    arguments: SendAmountArguments(
                        name: user.displayName,
                        avatar: user.avatar != null && user.avatar.isNotEmpty ? MemoryImage(user.avatar) : new AssetImage('assets/images/anom.png'),
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
        strList;
        normalList;
        strList;
      });
    }
  }

  List<Widget> _emptyList() {
    List<Widget> listItems = List();
    return listItems;
  }

  List<Widget> _buildList() {
    List<Widget> listItems = List();

    return listItems;

    for (int index = 0; index < normalList.length; index++) {
      listItems.add(Container(
        //height: widget.indexedHeight(index),
        child: normalList[index],
      ));
    }

    return listItems;
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          color: Colors.white,
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
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFE0E0E0), width: 3)),
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
                                SendAmountArguments(
                                  accountAddress: parts[1]));
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
      sliverList: _buildPageList(),
      children: <Widget>[
        isPreloading
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

    @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return ContactsViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          return SendToContactScreen(viewModel);
        });
  }
}


class ContactsViewModel {
  final List<Contact> contacts;
  final Token token;
  // final Function(String, num, VoidCallback, VoidCallback) sendToContact;
  // final Function(String, num, VoidCallback, VoidCallback) sendToAccountAddress;

  ContactsViewModel({this.contacts, this.token});

  static ContactsViewModel fromStore(Store<AppState> store) {
    return ContactsViewModel(
        contacts: store.state.userState.contacts,
        token: store.state.cashWalletState.token);
  }
}
