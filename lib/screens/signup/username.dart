import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/widgets/drawer.dart';
import 'package:paywise/widgets/main_scaffold.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:paywise/models/views/onboard.dart';

class UserNameScreen extends StatefulWidget {
  @override
  _UserNameScreenState createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  final verificationCodeController = TextEditingController(text: "");
  bool isPreloading = false;
  final displayNameController = TextEditingController(text: "");

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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              withPadding: true,
              titleFontSize: 15,
              title: I18n.of(context).sign_up,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, bottom: 0, top: 10.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/username.png',
                        width: 95,
                        height: 80,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        I18n.of(context).pickup_display_name,
                        style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                          I18n.of(context).pickup_display_name_text,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.secondary)),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                        controller: displayNameController,
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        cursorColor: Color(0xFFC6C6C6),
                        decoration: InputDecoration(
                          focusColor: Color(0xFFC6C6C6),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFC6C6C6))),
                        ),
                      )
                    ],
                  ),
                ),
              ],
              footer: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(children: <Widget>[
                    Center(
                      child: PrimaryButton(
                        label: I18n.of(context).next_button,
                        labelFontWeight: FontWeight.normal,
                        fontSize: 16,
                        preload: isPreloading,
                        onPressed: () async {
                          viewModel.setDisplayName(capitalize(displayNameController.text ?? 'Anom'));
                          Navigator.of(context).pushNamedAndRemoveUntil('/Cash', (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ])));
        });
  }
}
