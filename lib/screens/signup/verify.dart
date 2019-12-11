import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/onboard.dart';
import 'package:redux/redux.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final verificationCodeController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(title: "Sign up", children: <Widget>[
      new StoreConnector<AppState, OnboardViewModel>(
          distinct: true,
          converter: (Store<AppState> store) {
        return OnboardViewModel.fromStore(store);
      }, onWillChange: (viewModel) {
        if (viewModel.loginVerifySuccess) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.popAndPushNamed(context, '/Cash');
        }
      }, builder: (_, viewModel) {
        return Container(
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
            child: Text(
                "We just sent a message to \n" +
                    "${viewModel.countryCode} ${viewModel.phoneNumber}" +
                    "\n\n" +
                    "Please enter 6-digit code from\n that message here",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0, top: 50.0, right: 0.0),
            child:
             Container(
               width: 280,
               child: TextFormField(
              controller: verificationCodeController,
              autofocus: false,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                labelText: 'Verification Code',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Verification Code is required';
                }
                return null;
              },
            ),
             ) ,
          ),
          const SizedBox(height: 40.0),
          Center(
            child: PrimaryButton(
              label: "VERIFY",
              onPressed: () async {
                viewModel.verify(viewModel.countryCode, viewModel.phoneNumber,
                    verificationCodeController.text, viewModel.accountAddress);
              },
            ),
          ),
        ]));
      })
    ]);
  }
}
