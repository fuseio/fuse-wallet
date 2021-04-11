import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/contacts.dart';
import 'package:fusecash/features/contacts/router/router_contacts.gr.dart';
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
  Animation<double> scaleAnimation;
  bool isPreloading = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, ContactsViewModel>(
      distinct: true,
      converter: ContactsViewModel.fromStore,
      builder: (_, viewModel) {
        return ScaleTransition(
          scale: scaleAnimation,
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(I18n.of(context).sync_contacts,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 30),
                              child: SvgPicture.asset(
                                'assets/images/contacts.svg',
                                width: 70.0,
                                height: 70,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          I18n.of(context).enable_contacts_text,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Text(I18n.of(context).dont_worry,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(height: 5.0),
                              Text(
                                I18n.of(context).enable_text,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Center(
                            child: PrimaryButton(
                          preload: isPreloading,
                          disabled: isPreloading,
                          label: I18n.of(context).enable_contacts_access,
                          onPressed: () async {
                            setState(() {
                              isPreloading = true;
                            });
                            bool permission = await Contacts.getPermissions();
                            if (permission) {
                              List<Contact> contacts =
                                  await Contacts.getContacts();
                              viewModel.syncContacts(contacts);
                              viewModel.trackCall(
                                  "Wallet: Contacts Permission Granted");
                              viewModel.idenyifyCall(Map.from(
                                  {"Contacts Permission Granted": true}));
                            } else {
                              viewModel.trackCall(
                                  "Wallet: Contacts Permission Rejected");
                              viewModel.idenyifyCall(Map.from(
                                  {"Contacts Permission Granted": false}));
                            }
                            Navigator.of(context).pop();
                            ExtendedNavigator.named('contactsRouter')
                                .replace(ContactsRoutes.contactsList);
                            setState(() {
                              isPreloading = false;
                            });
                          },
                        )),
                        Center(
                          child: FlatButton(
                            padding: EdgeInsets.only(top: 10),
                            onPressed: () {
                              Navigator.of(context).pop();
                              viewModel.syncContactsRejected();
                            },
                            child: Text(
                              I18n.of(context).skip_button,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
