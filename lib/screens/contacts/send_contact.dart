// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:fusecash/generated/i18n.dart';
// import 'package:fusecash/models/app_state.dart';
// import 'package:fusecash/models/views/contacts.dart';
// import 'package:fusecash/screens/contacts/contact_tile.dart';
// import 'package:fusecash/utils/format.dart';
// import 'package:fusecash/utils/send.dart';
// import 'package:fusecash/widgets/main_scaffold.dart';
// import "package:ethereum_address/ethereum_address.dart";
// import 'package:fusecash/widgets/silver_app_bar.dart';

// class EmptyContacts extends StatefulWidget {
//   @override
//   _EmptyContactsState createState() => _EmptyContactsState();
// }

// class _EmptyContactsState extends State<EmptyContacts> {
//   TextEditingController searchController = TextEditingController();
//   bool isPreloading = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget sendToAcccountAddress(BuildContext context, String accountAddress) {
//     Widget component = ContactTile(
//       displayName: formatAddress(accountAddress),
//       onTap: () {
//         sendToPastedAddress(accountAddress);
//       },
//       trailing: InkWell(
//         child: Text(
//           I18n.of(context).next_button,
//           style: TextStyle(color: Color(0xFF0377FF)),
//         ),
//         onTap: () {
//           sendToPastedAddress(accountAddress);
//         },
//       ),
//     );
//     return SliverList(
//       delegate: SliverChildListDelegate([component]),
//     );
//   }

//   searchPanel(ContactsViewModel viewModel) {
//     return SliverPersistentHeader(
//       pinned: true,
//       delegate: SliverAppBarDelegate(
//         minHeight: 80.0,
//         maxHeight: 100.0,
//         child: Container(
//           decoration: BoxDecoration(
//               color: Theme.of(context).scaffoldBackgroundColor,
//               border: Border(bottom: BorderSide(color: Color(0xFFDCDCDC)))),
//           padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 20),
//                   child: TextFormField(
//                     controller: searchController,
//                     style: TextStyle(fontSize: 18, color: Colors.black),
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(0.0),
//                       border: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(color: Color(0xFFE0E0E0), width: 3)),
//                       focusedBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: Color(0xFF292929)),
//                       ),
//                       suffixIcon: Icon(
//                         Icons.search,
//                         color: Color(0xFFACACAC),
//                       ),
//                       labelText: I18n.of(context).search,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 45,
//                 height: 45,
//                 child: FloatingActionButton(
//                     heroTag: 'contacts_list',
//                     backgroundColor: Color(0xFF292929),
//                     elevation: 0,
//                     child: Image.asset(
//                       'assets/images/scan.png',
//                       width: 25.0,
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                     ),
//                     onPressed: () {
//                       bracodeScannerHandler();
//                     }),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, ContactsViewModel>(
//         distinct: true,
//         converter: ContactsViewModel.fromStore,
//         builder: (_, viewModel) {
//           return MainScaffold(
//             automaticallyImplyLeading: false,
//             title: I18n.of(context).send_to,
//             sliverList: <Widget>[
//               searchPanel(viewModel),
//               isValidEthereumAddress(searchController.text)
//                   ? sendToAcccountAddress(context, searchController.text)
//                   : SizedBox.shrink()
//             ],
//           );
//         });
//   }
// }

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/contacts.dart';
import 'package:fusecash/screens/contacts/contact_tile.dart';
import 'package:fusecash/screens/contacts/enable_contacts.dart';
import 'package:fusecash/screens/contacts/router/router_contacts.gr.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/send.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import "package:ethereum_address/ethereum_address.dart";
import 'package:fusecash/widgets/silver_app_bar.dart';
import 'package:redux/redux.dart';

class EmptyContacts extends StatefulWidget {
  @override
  _EmptyContactsState createState() => _EmptyContactsState();
}

class _EmptyContactsState extends State<EmptyContacts> {
  bool showFooter = true;
  bool hasSynced = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFDCDCDC)))),
            child: ListTile(
              contentPadding:
                  EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                radius: 25,
                backgroundImage: user.avatar != null && user.avatar.isNotEmpty
                    ? MemoryImage(user.avatar)
                    : AssetImage('assets/images/anom.png'),
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
                sendToContact(context, user.displayName, phone.value,
                    avatar: user.avatar != null && user.avatar.isNotEmpty
                        ? MemoryImage(user.avatar)
                        : AssetImage('assets/images/anom.png'));
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

  Widget sendToAcccountAddress(BuildContext context, String accountAddress) {
    Widget component = ContactTile(
      displayName: formatAddress(accountAddress),
      onTap: () {
        sendToPastedAddress(accountAddress);
      },
      trailing: InkWell(
        child: Text(
          I18n.of(context).next_button,
          style: TextStyle(color: Color(0xFF0377FF)),
        ),
        onTap: () {
          sendToPastedAddress(accountAddress);
        },
      ),
    );
    return SliverList(
      delegate: SliverChildListDelegate([component]),
    );
  }

  List<Widget> _buildPageList(viewModel) {
    List<Widget> listItems = List();

    listItems.add(searchPanel(viewModel));

    if (isValidEthereumAddress(searchController.text)) {
      listItems.add(sendToAcccountAddress(context, searchController.text));
    }
    return listItems;
  }

  searchPanel(ContactsViewModel viewModel) {
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
                        borderSide: BorderSide(color: const Color(0xFF292929)),
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
                width: 45,
                height: 45,
                child: new FloatingActionButton(
                    heroTag: 'contacts_list',
                    backgroundColor: const Color(0xFF292929),
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/scan.png',
                      width: 25.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: () {
                      bracodeScannerHandler();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  onInit(Store<AppState> store) async {
    bool isPermitted = await Contacts.checkPermissions();
    if (!isPermitted && store.state.userState.isContactsSynced == null) {
      Future.delayed(
          Duration.zero,
          () => showDialog(
              child: ContactsConfirmationScreen(), context: context));
    }
    setState(() {
      hasSynced = isPermitted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: ContactsViewModel.fromStore,
        onInit: onInit,
        onInitialBuild: (vm) async {
          bool isPermitted = await Contacts.checkPermissions();
          if (!isPermitted && vm.isContactsSynced == null) {
            Future.delayed(
                Duration.zero,
                () => showDialog(
                    child: ContactsConfirmationScreen(), context: context));
            setState(() {
              hasSynced = isPermitted;
            });
          } else {
            ExtendedNavigator.of(context)
                .pushReplacementNamed(ContactsRoutes.contactsList);
          }
        },
        builder: (_, viewModel) {
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
                    Text(I18n.of(context).sync_your_contacts),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Text(I18n.of(context).learn_more),
                          onTap: () {
                            showDialog(
                                child: ContactsConfirmationScreen(),
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
                                Text(
                                  I18n.of(context).activate,
                                  style: TextStyle(color: Color(0xFF0377FF)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset('assets/images/blue_arrow.svg')
                              ],
                            ),
                            onTap: () async {
                              bool premission =
                                  await ContactController.getPermissions();
                              if (premission) {
                                List<Contact> contacts =
                                    await ContactController.getContacts();
                                viewModel.syncContacts(contacts);
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
        });
  }
}
