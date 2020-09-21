import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/app_state.dart';
import 'package:roost/models/views/recovery.dart';
import 'package:roost/screens/routes.gr.dart';
import 'package:roost/widgets/main_scaffold.dart';
import 'package:roost/widgets/primary_button.dart';

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
    Segment.screen(screenName: '/restore-wallet-screen');
    return MainScaffold(
      expandedHeight: MediaQuery.of(context).size.height / 12,
      padding: 20.0,
      withPadding: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: I18n.of(context).restore_from_backup,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
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
                    controller: wordsController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    autofocus: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: null, fillColor: Colors.transparent),
                    validator: (String value) => value.split(" ").length != 12
                        ? 'Please enter 12 words'
                        : null,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 30.0),
      ],
      footer: StoreConnector<AppState, RecoveryViewModel>(
          distinct: true,
          converter: RecoveryViewModel.fromStore,
          builder: (_, viewModel) => Center(
                  child: PrimaryButton(
                preload: isPreloading,
                disabled: isPreloading,
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
                      ExtendedNavigator.root.pushSignupScreen();
                    });
                  }
                },
              ))),
    );
  }
}
