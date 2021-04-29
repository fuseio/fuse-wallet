import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/redux/viewsmodels/onboard.dart';
import 'package:fusecash/widgets/snackbars.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  VerifyScreen({this.verificationId});
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String autoCode = "";
  TextEditingController codeController = TextEditingController(text: '');
  String currentText = "";
  // StreamController<ErrorAnimationType> errorController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Segment.screen(screenName: '/verify-phone-number-screen');
    super.initState();
  }

  @override
  void dispose() {
    // errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).sign_up,
      body: StoreConnector<AppState, OnboardViewModel>(
        distinct: true,
        converter: OnboardViewModel.fromStore,
        onInitialBuild: (viewModel) {
          if (viewModel.credentials != null &&
              viewModel.verificationId != null) {
            autoCode = viewModel.credentials.smsCode ?? "";
            viewModel.verify(autoCode);
          }
        },
        onWillChange: (previousViewModel, newViewModel) {
          if (previousViewModel.verifyErrorMessage !=
              newViewModel.verifyErrorMessage) {
            showErrorSnack(
              title: I10n.of(context).oops,
              message: newViewModel.verifyErrorMessage,
              context: context,
              margin: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 120),
            );
            // Future.delayed(Duration(seconds: Variables.INTERVAL_SECONDS), () {
            //   newViewModel.resetErrors();
            // });
          }
        },
        builder: (_, viewModel) {
          return Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        I10n.of(context).we_just_sent +
                            "${viewModel.phoneNumber}" +
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
                            showCursor: false,
                            appContext: context,
                            enableActiveFill: true,
                            enablePinAutofill: false,
                            keyboardType: TextInputType.phone,
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
                          preload: viewModel.isVerifyRequest,
                          onPressed: () {
                            formKey.currentState.validate();
                            // conditions for validating
                            log.info(
                                'currentText.length ${currentText.length}');
                            if (currentText.length != 6) {
                              // errorController.add(ErrorAnimationType
                              //     .shake); // Triggering error shake animation
                            } else {
                              viewModel.verify(codeController.text);
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
                          FlatButton(
                            padding: EdgeInsets.only(right: 10),
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
