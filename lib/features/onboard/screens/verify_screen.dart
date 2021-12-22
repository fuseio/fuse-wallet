import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';
import 'package:fusecash/redux/viewsmodels/onboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneNumber extends StatefulWidget {
  final String? verificationId;
  VerifyPhoneNumber({this.verificationId});
  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  String autoCode = "";
  TextEditingController codeController = TextEditingController(text: '');
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).sign_up,
      body: StoreConnector<AppState, VerifyOnboardViewModel>(
        distinct: true,
        converter: VerifyOnboardViewModel.fromStore,
        onInitialBuild: (viewModel) {
          if (viewModel.credentials != null &&
              viewModel.verificationId != null) {
            autoCode = viewModel.credentials?.smsCode ?? "";
            setState(() {
              isPreloading = true;
            });
            viewModel.verify(
              autoCode,
              () {
                setState(() {
                  isPreloading = false;
                });
              },
              (error) {
                setState(() {
                  isPreloading = false;
                });
              },
            );
          }
        },
        builder: (_, viewModel) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        I10n.of(context).we_just_sent +
                            viewModel.phoneNumber +
                            "\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        I10n.of(context).enter_verification_code,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: Container(
                          width: 280,
                          child: PinCodeTextField(
                            length: 6,
                            backgroundColor: Theme.of(context).canvasColor,
                            showCursor: false,
                            appContext: context,
                            enableActiveFill: true,
                            enablePinAutofill: false,
                            keyboardType: TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            animationType: AnimationType.fade,
                            controller: codeController,
                            autoFocus: true,
                            pinTheme: PinTheme(
                              borderWidth: 4,
                              borderRadius: BorderRadius.circular(20),
                              shape: PinCodeFieldShape.underline,
                              inactiveColor: Color(0xFFDDDDDD),
                              inactiveFillColor: Theme.of(context).canvasColor,
                              selectedFillColor: Theme.of(context).canvasColor,
                              disabledColor: Theme.of(context).primaryColor,
                              selectedColor:
                                  Theme.of(context).colorScheme.onSurface,
                              activeColor:
                                  Theme.of(context).colorScheme.onSurface,
                              activeFillColor: Theme.of(context).canvasColor,
                            ),
                            onChanged: (value) {
                              setState(() {
                                currentText = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                        child: PrimaryButton(
                          label: I10n.of(context).next_button,
                          width: MediaQuery.of(context).size.width * .9,
                          preload: isPreloading,
                          disabled: isPreloading,
                          onPressed: () {
                            formKey.currentState!.validate();
                            if (currentText.length != 6) {
                            } else {
                              setState(() {
                                isPreloading = true;
                              });
                              viewModel.verify(
                                codeController.text,
                                () {
                                  setState(() {
                                    isPreloading = false;
                                  });
                                },
                                (dynamic error) {
                                  setState(() {
                                    isPreloading = false;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            I10n.of(context).didnt_get_message,
                            style: TextStyle(fontSize: 12),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              I10n.of(context).resend_code,
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
