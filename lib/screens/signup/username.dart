import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/models/views/onboard.dart';
import 'package:redux/redux.dart';

class UserNameScreen extends StatefulWidget {
  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final verificationCodeController = TextEditingController(text: "");
  bool isPreloading = false;
  final fullnameController = TextEditingController(text: "");

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
        builder: (_, viewModel) {
          return MainScaffold(
              backgroundColor: Colors.white,
              withPadding: true,
              titleFontSize: 15,
              title: "Sign up",
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 20.0, top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/username.png',
                      ),
                      const SizedBox(height: 40.0),
                      Text(
                        'Pick up your user name',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 40.0),
                      Text(
                          'This name will be shown to contacts that send you money to identify your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(height: 80.0),
                      Container(
                        width: 280,
                        child: new Theme(
                            data: new ThemeData(hintColor: Colors.white),
                            child: TextField(
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              controller: fullnameController,
                              cursorColor: Color(0xFFC6C6C6),
                              decoration: InputDecoration(
                                hintText: 'Full name',
                                focusColor: Color(0xFFC6C6C6),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFFC6C6C6))),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
              footer: Container(
                  child: Column(children: <Widget>[
                Center(
                  child: PrimaryButton(
                    label: "Next",
                    labelFontWeight: FontWeight.normal,
                    fontSize: 16,
                    preload: isPreloading,
                    onPressed: () async {
                      viewModel.setFullName(fullnameController.text ?? 'Anom');
                      Navigator.popAndPushNamed(context, '/Cash');
                    },
                  ),
                ),
              ])));
        });
  }
}
