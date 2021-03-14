import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/onboard.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetUpPinCodeScreen extends StatefulWidget {
  final Function onSuccess;
  SetUpPinCodeScreen({this.onSuccess});
  @override
  _SetUpPinCodeScreenState createState() => _SetUpPinCodeScreenState();
}

class _SetUpPinCodeScreenState extends State<SetUpPinCodeScreen> {
  final textEditingController = TextEditingController(text: "");
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController;
  String lastPinCode;
  bool isRetype = false;
  String currentText = "";
  FocusNode textNode = FocusNode();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    textNode = FocusNode();
  }

  @override
  void dispose() {
    errorController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        title: I18n.of(context).pincode,
        body: Container(
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
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  StoreConnector<AppState, OnboardViewModel>(
                    converter: OnboardViewModel.fromStore,
                    builder: (_, viewModel) => Form(
                      key: formKey,
                      child: Container(
                        width: 250,
                        child: PinCodeTextField(
                          length: 6,
                          showCursor: false,
                          appContext: context,
                          enableActiveFill: true,
                          obscureText: true,
                          enablePinAutofill: false,
                          autoFocus: true,
                          focusNode: textNode,
                          keyboardType: TextInputType.phone,
                          animationType: AnimationType.fade,
                          controller: textEditingController,
                          errorAnimationController: errorController,
                          pinTheme: PinTheme(
                            borderWidth: 4,
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
                          onCompleted: (pin) {
                            if (isRetype && pin == lastPinCode) {
                              viewModel.setSecurityType(BiometricAuth.pincode);
                              viewModel.setPincode(pin);
                              widget.onSuccess();
                            } else {
                              setState(() {
                                isRetype = true;
                                lastPinCode = pin;
                              });
                              textEditingController.clear();
                              textNode.requestFocus();
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              currentText = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
