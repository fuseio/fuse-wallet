import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/onboard.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:redux/redux.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final verificationCodeController = TextEditingController(text: "");
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, OnboardViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return OnboardViewModel.fromStore(store);
        },
        onWillChange: (viewModel) {
          if (viewModel.loginVerifySuccess) {
            //Navigator.popUntil(context, ModalRoute.withName('/'));
            //Navigator.popAndPushNamed(context, '/Cash');
          }
        },
        builder: (_, viewModel) {
          return MainScaffold(
              backgroundColor: Colors.white,
              withPadding: true,
              titleFontSize: 15,
              title: "Sign up",
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
                  child: Text(
                      "We just sent a message to \n" +
                          "${viewModel.countryCode} ${viewModel.phoneNumber}" +
                          "\n\n" +
                          "Please enter 6-digit code from\n that message here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
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
                        data: new ThemeData(hintColor: Colors.white),
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
                const SizedBox(height: 40.0),
                Center(
                  child: PrimaryButton(
                    label: "Next",
                    labelFontWeight: FontWeight.normal,
                    fontSize: 16,
                    preload: isPreloading,
                    onPressed: () async {
                      setState(() {
                        isPreloading = true;
                      });
                      viewModel.verify(
                          viewModel.countryCode,
                          viewModel.phoneNumber,
                          verificationCodeController.text,
                          viewModel.accountAddress, () {
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
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Didn't get the message? - ",
                      style: TextStyle(fontSize: 12),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(right: 10),
                      onPressed: () {
                        viewModel.verify(
                            viewModel.countryCode,
                            viewModel.phoneNumber,
                            verificationCodeController.text,
                            viewModel.accountAddress, () {
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
                        "Resend code",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ],
                )
              ])));
        });
  }
}
