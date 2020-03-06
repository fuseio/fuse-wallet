import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/screens/routes.gr.dart';
import 'package:paywise/widgets/main_scaffold.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:paywise/models/views/onboard.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class PincodeScreen extends StatefulWidget {
  @override
  _PincodeScreenState createState() => _PincodeScreenState();
}

class _PincodeScreenState extends State<PincodeScreen> {
  final pincodeController = TextEditingController(text: "");
  String lastPincode;
  bool isRetype = false;
  // bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnboardViewModel>(
        distinct: true,
        converter: OnboardViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
              withPadding: true,
              title: I18n.of(context).pincode,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                  child: Text(
                      this.isRetype ? I18n.of(context).re_type_passcode : I18n.of(context).create_passcode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      )),
                )
              ],
              footer: Container(
                  child: Column(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 0.0, top: 50.0, right: 0.0),
                  child: Container(
                    width: 280,
                    child: new Theme(
                        data: new ThemeData(hintColor: Theme.of(context).scaffoldBackgroundColor),
                        child: PinInputTextField(
                          pinLength: 6,
                          decoration: UnderlineDecoration(
                            color: Color(0xFFDDDDDD),
                            enteredColor: Color(0xFF575757),
                            obscureStyle: ObscureStyle(isTextObscure: true, obscureText: '●')
                          ),
                          controller: pincodeController,
                          autoFocus: true,
                          textInputAction: TextInputAction.go,
                          onChanged: (String pin) {
                            if (pin.length == 6 && !this.isRetype) {
                              pincodeController.text = '';
                              setState(() {
                                isRetype = true; 
                                lastPincode = pin;
                                });
                            } else if (pin.length == 6 && this.isRetype) {
                                if (pin == this.lastPincode) {
                                  Router.navigator.popUntil(ModalRoute.withName(Router.splashScreen));
                                  Router.navigator.popAndPushNamed(Router.cashHomeScreen);
                                }
                            }
                          }
                        )),
                  ),
                ),
                const SizedBox(height: 40.0),
                Center(
                  child: PrimaryButton(
                    label: I18n.of(context).skip_button,
                    onPressed: () async {
                      Router.navigator.popUntil(ModalRoute.withName(Router.splashScreen));
                      Router.navigator.popAndPushNamed(Router.cashHomeScreen);
                    },
                  ),
                ),
              ])));
        });
  }
}
