import 'package:auto_route/auto_route.dart';
import 'package:esol/screens/contacts/widgets/header.dart';
import 'package:esol/widgets/custom_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/models/views/contacts.dart';
import 'package:esol/screens/contacts/widgets/contact_tile.dart';
import 'package:esol/screens/contacts/router/router_contacts.gr.dart';
import 'package:esol/utils/contacts.dart';
import 'package:esol/utils/format.dart';
import 'package:esol/utils/send.dart';
import 'package:esol/widgets/main_scaffold.dart';
import "package:ethereum_address/ethereum_address.dart";

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
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  void resetSearch() {
    FocusScope.of(context).unfocus();
    if (mounted) {
      setState(() {
        searchController.text = '';
      });
    }
  }

  Widget sendToAcccountAddress(String accountAddress) {
    Widget component = ContactTile(
      displayName: formatAddress(accountAddress),
      onTap: () {
        resetSearch();
        sendToPastedAddress(accountAddress);
      },
      trailing: InkWell(
        child: Text(
          I18n.of(context).next_button,
          style: TextStyle(color: Color(0xFF0377FF)),
        ),
        onTap: () {
          resetSearch();
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

    // listItems.add(SearchPanel(
    //   searchController: searchController,
    // ));

    if (isValidEthereumAddress(searchController.text)) {
      listItems.add(sendToAcccountAddress(searchController.text));
    }

    listItems.add(SliverList(
        delegate: SliverChildListDelegate(
      [
        Column(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(MediaQuery.of(context).size.width.toString()),
            CustomRectangle(
              borderSize: 20,
              borderColor: Colors.white,
              height: 40.0,
              borderRadius: 40.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 18, top: 20),
                child: Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.white,
                  child: Text(
                    I18n.of(context).transactions,
                  ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 5,
            ),
            Container(
              height: MediaQuery.of(context).size.height * (1 / 70) * 8,
              width: MediaQuery.of(context).size.width * 1 - 110,
              child: Text(
                I18n.of(context).sync_your_contacts,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (1 / 70) * 1,
            ),
            Container(
              height: MediaQuery.of(context).size.height * (1 / 70) * 6,
              width: MediaQuery.of(context).size.width * 1 - 110,
              // child: Image.asset('assets\images\gift.png'),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: NetworkImage(
                //       'https://www.w3schools.com/howto/img_avatar.png'),
                //   fit: BoxFit.contain,
                // ),
                // border: Border.all(
                //     // color: Colors.black,
                //     // width: 8,
                //     ),
                color: Theme.of(context).buttonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: () async {
                  bool premission = await ContactController.getPermissions();
                  if (premission) {
                    List<Contact> contacts =
                        await ContactController.getContacts();
                    viewModel.syncContacts(contacts);
                    ExtendedNavigator.named('contactsRouter')
                        .replace(ContactsRoutes.contactsList);
                    viewModel.trackCall("Wallet: Contacts Permission Granted");
                    viewModel.idenyifyCall(
                        Map.from({"Contacts Permission Granted": false}));
                    setState(() {
                      hasSynced = true;
                    });
                  } else {
                    viewModel.trackCall("Wallet: Contacts Permission Rejected");
                    viewModel.idenyifyCall(
                        Map.from({"Contacts Permission Granted": false}));
                  }
                },
                child: Center(
                  child: Text(
                    I18n.of(context).activate,
                    style: TextStyle(
                      // color: Color(0xFF0377FF),
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    )));

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: ContactsViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            drawerIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Image.asset(
                'assets/images/menu_white.png',
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.20,
            newHeaderAppBar: ContactsHeader(
              image: null,
              contactEmpty: true,
              imageshow: false,
              textshow: false,
            ),
            automaticallyImplyLeading: true,
            title: Text(''),
            sliverList: _buildPageList(viewModel),
          );
        });
  }
}
