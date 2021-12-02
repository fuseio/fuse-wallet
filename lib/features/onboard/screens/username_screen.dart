import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/common/router/route_guards.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/common/router/routes.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:supervecina/redux/actions/user_actions.dart';
import 'package:supervecina/features/shared/widgets/my_scaffold.dart';
import 'package:supervecina/features/shared/widgets/primary_button.dart';
import 'package:supervecina/utils/string.dart';

class UserNameScreen extends StatelessWidget {
  final displayNameController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).sign_up,
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    bottom: 0,
                    top: 20.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: SvgPicture.asset(
                          'assets/images/username.svg',
                          width: 95,
                          height: 80,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        I10n.of(context).pickup_display_name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        I10n.of(context).pickup_display_name_text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: 255,
                          color: Theme.of(context).canvasColor,
                          child: TextFormField(
                            controller: displayNameController,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            autofocus: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                              fillColor: Theme.of(context).canvasColor,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 30.0),
            Column(
              children: [
                Center(
                  child: StoreConnector<AppState, Function(String)>(
                    distinct: true,
                    converter: (store) => (String displayName) {
                      isAuthenticated = true;
                      store.dispatch(SetDisplayName(displayName));
                      store.dispatch(createAccountWalletCall());
                    },
                    builder: (_, setDisplayName) {
                      return PrimaryButton(
                        label: I10n.of(context).next_button,
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              displayNameController.text != '') {
                            setDisplayName(
                              displayNameController.text.capitalize(),
                            );
                            context.router.push(ChooseSecurityOption());
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 40.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
