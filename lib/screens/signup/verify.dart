import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/onboard.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class VerifyScreenArguments {
  final String verificationId;

  VerifyScreenArguments({this.verificationId});
}

class VerifyScreen extends StatefulWidget {
  final VerifyScreenArguments pageArgs;
  VerifyScreen({this.pageArgs});
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String autoCode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VerifyScreenArguments args = this.widget.pageArgs;
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return new StoreConnector<AppState, OnboardViewModel>(
        distinct: true,
        converter: OnboardViewModel.fromStore,
        onInitialBuild: (viewModel) {
          if (viewModel.credentials != null) {
            autoCode = viewModel.credentials.smsCode ?? "";
            viewModel.verify(autoCode, args.verificationId, _scaffoldKey);
          }
        },
        builder: (_, viewModel) {
          final verificationCodeController =
              TextEditingController(text: autoCode);
          return MainScaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              withPadding: true,
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
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, top: 10.0, right: 0.0),
                        child: Container(
                          width: 280,
                          child: new Theme(
                              data: new ThemeData(
                                  hintColor: Theme.of(context)
                                      .scaffoldBackgroundColor),
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
                    preload: viewModel.isVerifyRequest,
                    onPressed: () {
                      viewModel.verify(verificationCodeController.text, args.verificationId, _scaffoldKey);
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
                        Navigator.of(context).pop();
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
