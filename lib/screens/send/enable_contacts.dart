import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/contacts.dart';
import 'package:fusecash/utils/permissions.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'dart:core';

class ContactsConfirmationScreen extends StatefulWidget {
  @override
  _ContactsConfirmationScreenState createState() =>
      _ContactsConfirmationScreenState();
}

class _ContactsConfirmationScreenState
    extends State<ContactsConfirmationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, ContactsViewModel>(converter: (store) {
      return ContactsViewModel.fromStore(store);
    }, builder: (_, viewModel) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text('Send money to friends',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, bottom: 30, right: 20),
                              child: Image.asset(
                                'assets/images/send_to_friends.png',
                                width: 145,
                                height: 65,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Please enable contacts sync for easy access your phone contacts when sending money.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 150.0),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text("Don't worry:",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal)),
                              const SizedBox(height: 20.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Your contacts will not be saved on our server and this action will not send \n them any massages',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        Center(
                            child: PrimaryButton(
                          fontSize: 15,
                          labelFontWeight: FontWeight.normal,
                          // width: 160,
                          label: "Enable Contacts Access",
                          onPressed: () async {
                            Navigator.of(context).pop();
                            loadContacts(viewModel.syncContactsRejected,
                                viewModel.syncContacts);
                          },
                        )),
                        Center(
                          child: FlatButton(
                            padding: EdgeInsets.only(top: 10),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Skip",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]));
    });
  }
}
