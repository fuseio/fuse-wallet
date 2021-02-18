import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/redux/viewsmodels/onboard.dart';

class UserNameScreen extends StatelessWidget {
  onInit(store) {
    final String accountAddress = store.state.userState.accountAddress;
    store.dispatch(createAccountWalletCall(accountAddress));
  }

  @override
  Widget build(BuildContext context) {
    Segment.screen(screenName: '/user-name-screen');
    return StoreConnector<AppState, OnboardViewModel>(
      distinct: true,
      onInit: onInit,
      converter: OnboardViewModel.fromStore,
      builder: (_, viewModel) {
        return MainScaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          withPadding: true,
          padding: 20.0,
          title: I18n.of(context).sign_up,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 30.0,
                right: 30.0,
                bottom: 0,
                top: 10.0,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/username.png',
                      width: 95,
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    I18n.of(context).pickup_display_name,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    I18n.of(context).pickup_display_name_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: 255,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      autofocus: true,
                      onFieldSubmitted: (value) {
                        viewModel.setDisplayName(value ?? 'Anom');
                        ExtendedNavigator.root.pushSecurityScreen();
                      },
                      cursorColor: Color(0xFFC6C6C6),
                      decoration: InputDecoration(
                        focusColor: Color(0xFFC6C6C6),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFC6C6C6),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
          // footer: Center(
          //   child: PrimaryButton(
          //     label: I18n.of(context).next_button,
          //     labelFontWeight: FontWeight.normal,
          //     fontSize: 16,
          //     onPressed: () {
          //       viewModel.setDisplayName(
          //           displayNameController.text.capitalize() ?? 'Anom');
          //       ExtendedNavigator.root.pushSecurityScreen();
          //     },
          //   ),
          // ),
        );
      },
    );
  }
}
