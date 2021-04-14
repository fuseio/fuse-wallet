import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/contacts/dialogs/enable_contacts.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/contacts.dart';
import 'package:fusecash/utils/contacts.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, ContactsViewModel>(
        distinct: true,
        converter: ContactsViewModel.fromStore,
        builder: (_, viewModel) {
          return Column(
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
                    focusColor: Theme.of(context).canvasColor,
                    highlightColor: Theme.of(context).canvasColor,
                    child: Text(I18n.of(context).learn_more),
                    onTap: () {
                      showDialog(
                          builder: (_) => ContactsConfirmationScreen(),
                          context: context);
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      focusColor: Theme.of(context).canvasColor,
                      highlightColor: Theme.of(context).canvasColor,
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
                        bool permission = await Contacts.getPermissions();
                        if (permission) {
                          viewModel.syncContacts();
                          viewModel
                              .trackCall("Wallet: Contacts Permission Granted");
                          viewModel.identifyCall(
                            Map.from({"Contacts Permission Granted": true}),
                          );
                        } else {
                          viewModel.trackCall(
                              "Wallet: Contacts Permission Rejected");
                          viewModel.identifyCall(
                              Map.from({"Contacts Permission Granted": false}));
                        }
                      })
                ],
              )
            ],
          );
        });
  }
}
