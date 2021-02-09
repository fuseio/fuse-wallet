import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/utils/biometric_local_auth.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:peepl/models/views/onboard.dart';
import 'package:peepl/widgets/snackbars.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class PincodeScreen extends StatefulWidget {
  final Function onSuccess;
  PincodeScreen({this.onSuccess});
  @override
  _PincodeScreenState createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  final pincodeController = TextEditingController(text: "");
  String lastPincode;
  bool isRetype = false;
  bool showError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pincodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        withPadding: false,
        title: I18n.of(context).pincode,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.height * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          this.isRetype
                              ? I18n.of(context).re_type_passcode
                              : I18n.of(context).create_passcode,
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Theme(
                            data: ThemeData(
                                hintColor:
                                    Theme.of(context).scaffoldBackgroundColor),
                            child: StoreConnector<AppState, OnboardViewModel>(
                                converter: OnboardViewModel.fromStore,
                                builder: (_, viewModel) => Container(
                                      width: 250,
                                      child: PinInputTextField(
                                        pinLength: 6,
                                        decoration: UnderlineDecoration(
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            hintTextStyle: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            colorBuilder:
                                                FixedColorListBuilder([
                                              Theme.of(context).primaryColor,
                                              Theme.of(context).primaryColor,
                                              Theme.of(context).primaryColor,
                                              Theme.of(context).primaryColor,
                                              Theme.of(context).primaryColor,
                                              Theme.of(context).primaryColor,
                                            ]),
                                            obscureStyle: ObscureStyle(
                                                isTextObscure: true,
                                                obscureText: '●')),
                                        controller: pincodeController,
                                        autoFocus: true,
                                        onChanged: (String pin) {
                                          if (pin.length == 6 &&
                                              !this.isRetype) {
                                            pincodeController.text = '';
                                            setState(() {
                                              isRetype = true;
                                              lastPincode = pin;
                                            });
                                          } else if (pin.length == 6 &&
                                              this.isRetype) {
                                            if (pin == this.lastPincode) {
                                              viewModel.setSecurityType(
                                                  BiometricAuth.pincode);
                                              viewModel
                                                  .setPincode(this.lastPincode);
                                              widget.onSuccess();
                                            } else {
                                              if (!showError) {
                                                transactionFailedSnack(
                                                    I18n.of(context)
                                                        .pincode_dont_match,
                                                    title:
                                                        I18n.of(context).oops,
                                                    duration:
                                                        Duration(seconds: 3),
                                                    context: context);
                                              }
                                              Future.delayed(
                                                  Duration(milliseconds: 2500),
                                                  () {
                                                setState(() {
                                                  showError = false;
                                                });
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    )))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ]);
  }
}
