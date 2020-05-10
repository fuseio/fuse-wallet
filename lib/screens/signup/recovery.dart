import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/views/recovery.dart';
import 'package:paywise/widgets/main_scaffold.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:paywise/screens/routes.gr.dart';

class RecoveryPage extends StatefulWidget {
  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final wordsController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecoveryViewModel>(
        converter: RecoveryViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
              expandedHeight: 130,
              withPadding: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: I18n.of(context).restore_from_backup,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(I18n.of(context).restore_words,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).bottomAppBarColor,
                          ),
                          child: TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: wordsController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            autofocus: false,
                            decoration: const InputDecoration(
                                border: null, fillColor: Colors.transparent),
                            validator: (String value) {
                              if (value.split(" ").length != 12) {
                                return 'Please enter 12 words';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                    child: PrimaryButton(
                  preload: isPreloading,
                  label: I18n.of(context).next_button,
                  fontSize: 16,
                  labelFontWeight: FontWeight.normal,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isPreloading = true;
                      });
                      viewModel.generateWalletFromBackup(
                          wordsController.text.toLowerCase(), () {
                        Router.navigator.pushNamed(Router.signupScreen);
                        setState(() {
                          isPreloading = false;
                        });
                      });
                    }
                  },
                )),
              ]);
        });
  }
}
