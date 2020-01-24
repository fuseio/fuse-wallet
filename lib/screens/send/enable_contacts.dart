import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/contacts.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'dart:core';

class ContactsConfirmationScreen extends StatefulWidget {
  @override
  _ContactsConfirmationScreenState createState() =>
      _ContactsConfirmationScreenState();
}

class _ContactsConfirmationScreenState extends State<ContactsConfirmationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimatoin;
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, ContactsViewModel>(
    converter: ContactsViewModel.fromStore,
    builder: (_, viewModel) {
      return ScaleTransition(
          scale: scaleAnimatoin,
          child: AlertDialog(
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Text(I18n.of(context).send_friends,
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
                              I18n.of(context).enable_contacts_text,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 50.0),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Text(I18n.of(context).dont_worry,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal)),
                                  const SizedBox(height: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      I18n.of(context).enable_text,
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
                              preload: isPreloading,
                              labelFontWeight: FontWeight.normal,
                              label: I18n.of(context).enable_contacts_access,
                              onPressed: () async {
                                setState(() {
                                  isPreloading = true;
                                });
                                bool premission = await ContactController.getPermissions();
                                if (premission) {
                                  List<Contact> contacts = await ContactController.getContacts();
                                  viewModel.syncContacts(contacts);
                                }
                                Navigator.popUntil(context, ModalRoute.withName('/Cash'));
                                setState(() {
                                  isPreloading = false;
                                });
                              },
                            )),
                            Center(
                              child: FlatButton(
                                padding: EdgeInsets.only(top: 10),
                                onPressed: () {
                                  Navigator.popUntil(context, ModalRoute.withName('/Cash'));
                                },
                                child: Text(
                                  I18n.of(context).skip_button,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor, fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ])));
    });
  }
}
