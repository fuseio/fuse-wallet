
import 'package:flutter/material.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contacts_service/contacts_service.dart';  
import 'package:permission_handler/permission_handler.dart';
import './send_amount.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendToContactScreen extends StatefulWidget {
  @override
  _SendToContactScreenState createState() => _SendToContactScreenState();
}

class _SendToContactScreenState extends State<SendToContactScreen> {
  
  List<Contact> userList = [];
  List<String> strList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  loadContacts() async {
    Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
    
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);  
    contacts = contacts.where((i) => i.displayName != null).toList();
    for (var contact in contacts) {
      userList.add(contact);
    }
    userList
        .sort((a, b) => a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
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
      users.retainWhere((user) =>
          user.displayName
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
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                NetworkImage("http://placeimg.com/200/200/people"),
              ),
              title: Text(user.displayName),
              subtitle: Text(user.company ?? ""),
              onTap: () {
                Navigator.pushNamed(context, '/SendAmount', arguments: SendAmountArguments(name: user.displayName, phoneNumber: user.phones.toList()[0].value));
              },
            ),
          ),
        );
        strList.add(user.displayName);
      
    });

    setState(() {
      strList;
      normalList;
      strList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      //key: key,
      backgroundColor: Theme.of(context).canvasColor,
      body: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: 
          AlphabetListScrollView(
            strList: strList,
            highlightTextStyle: TextStyle(
              color: Colors.yellow,
            ),
            showPreview: true,
            itemBuilder: (context, index) {
              return normalList[index];
            },
            indexedHeight: (i) {
              return 80;
            },
            keyboardUsage: true,
            headerWidgetList: <AlphabetScrollListHeader>[
              AlphabetScrollListHeader(widgetList: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      labelText: "Search",
                    ),
                  ),
                )
              ], icon: Icon(Icons.search), indexedHeaderHeight: (index) => 80),
              
            ],
          ),
        )
    );
  }
}

class User {
  final String name;
  final String company;
  final bool favourite;

  User(this.name, this.company, this.favourite);
}