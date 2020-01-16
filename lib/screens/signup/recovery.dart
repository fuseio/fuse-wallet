import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/recovery.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';

class RecoveryPage extends StatefulWidget {
  RecoveryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  GlobalKey<ScaffoldState> scaffoldState;
  bool isLoading = false;
  final wordsController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RecoveryViewModel>(converter: (store) {
      return RecoveryViewModel.fromStore(store);
    }, builder: (_, viewModel) {
      return MainScaffold(
          expandedHeight: 130,
          footer: null,
          withPadding: true,
          titleFontSize: 15,
          backgroundColor: Colors.white,
          title: "Restore from backup",
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                        "This is a 12 word phrase you were given when you created your previous wallet",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
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
                    TextFormField(
                      controller: wordsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      autofocus: false,
                      decoration: const InputDecoration(
                          labelText: 'Write down your 12 words...',
                          fillColor: Color(0xFFF7F7F7)),
                      validator: (String value) {
                        if (value.split(" ").length != 12) {
                          return 'Please enter 12 words';
                        }
                        return '';
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
                child: PrimaryButton(
              label: "Next",
              fontSize: 16,
              labelFontWeight: FontWeight.normal,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  viewModel.generateWalletFromBackup(
                      wordsController.text.toLowerCase(), () {
                    Navigator.pushNamed(context, '/Signup');
                  });
                }
              },
            )),
          ]);
    });
  }
}
