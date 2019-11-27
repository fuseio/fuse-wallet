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
    return MainScaffold(title: "Verify", children: <Widget>[
      new StoreConnector<AppState, OnboardViewModel>(
          converter: (Store<AppState> store) {
        return OnboardViewModel.fromStore(store);
      },
      onWillChange: (viewModel) {
        if (viewModel.loginVerifySuccess) {
          Navigator.pushNamed(context, '/CashLoading');
        }
      },
      builder: (_, viewModel) {
        return Container(
            child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Verifying your number!",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0, right: 16.0),
            child: Text(
              "Please type the verification code sent to",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 2.0, right: 30.0),
            child: Text(
              "${viewModel.countryCode} ${viewModel.phoneNumber}",
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 50.0, right: 30.0),
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
          ),
          Center(
            child: PrimaryButton(
              label: "VERIFY",
              onPressed: () async {
                viewModel.verify(
                    viewModel.countryCode, viewModel.phoneNumber, verificationCodeController.text);
              },
            ),
          ),
        ]));
      })
    ]);
  }
}
