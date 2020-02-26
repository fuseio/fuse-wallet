import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/onboard.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
//  final verificationCodeController = TextEditingController(text: "");
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnboardViewModel>(
        distinct: true,
        converter: OnboardViewModel.fromStore,
        onWillChange: (viewModel) {
          if (viewModel.loginVerifySuccess) {
            //Navigator.popUntil(context, ModalRoute.withName('/'));
            //Navigator.popAndPushNamed(context, '/Cash');
          }
        },
        builder: (_, viewModel) {
          String autoCode = "";
          if (viewModel.credentials != null) {
            autoCode = viewModel.credentials.smsCode ?? "";

            isPreloading = true;

            viewModel.verify(
                viewModel.countryCode,
                viewModel.phoneNumber,
                autoCode,
                viewModel.accountAddress,
                viewModel.verificationId, () async {
              // Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.popAndPushNamed(context, '/Cash');
              setState(() {
                isPreloading = false;
              });
            }, () {
              setState(() {
                isPreloading = false;
              });
            });
          }
          final verificationCodeController = TextEditingController(text: autoCode);
          return MainScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              withPadding: true,
              titleFontSize: 15,
              title: I18n.of(context).sign_up,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        I18n.of(context).we_just_sent +
                              "${viewModel.countryCode} ${viewModel.phoneNumber}" +
                              "\n\n" +
                              I18n.of(context).enter_verification_code,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 10.0, right: 0.0),
                        child: Container(
                          width: 280,
                          child: new Theme(
                              data: new ThemeData(hintColor: Theme.of(context).scaffoldBackgroundColor),
                              child: PinInputTextField(
                                pinLength: 6,
                                decoration: UnderlineDecoration(
                                  color: Color(0xFFDDDDDD),
                                  enteredColor: Color(0xFF575757),
                                ),
                                controller: verificationCodeController,
                                autoFocus: true,
                                textInputAction: TextInputAction.go,
                                onSubmit: (pin) {},
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
              footer: Container(
                  child: Column(children: <Widget>[
                const SizedBox(height: 10.0),
                Center(
                  child: PrimaryButton(
                    label: I18n.of(context).next_button,
                    labelFontWeight: FontWeight.normal,
                    fontSize: 16,
                    preload: isPreloading,
                    onPressed: () {
                      setState(() {
                        isPreloading = true;
                      });
                      viewModel.verify(
                          viewModel.countryCode,
                          viewModel.phoneNumber,
                          verificationCodeController.text,
                          viewModel.accountAddress,
                          viewModel.verificationId, () async {
                        Navigator.popAndPushNamed(context, '/UserName');
                        setState(() {
                          isPreloading = false;
                        });
                      }, () {
                        setState(() {
                          isPreloading = false;
                        });
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      I18n.of(context).didnt_get_message,
                      style: TextStyle(fontSize: 12),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(right: 10),
                      onPressed: () {
                        viewModel.verify(
                            viewModel.countryCode,
                            viewModel.phoneNumber,
                            verificationCodeController.text,
                            viewModel.accountAddress,
                            viewModel.verificationId, () async {
                          // Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.popAndPushNamed(context, '/Cash');
                          setState(() {
                            isPreloading = false;
                          });
                        }, () {
                          setState(() {
                            isPreloading = false;
                          });
                        });
                      },
                      child: Text(
                        I18n.of(context).resend_code,
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ])));
        });
  }
}
