import 'dart:async';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/widgets/copy.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/transparent_button.dart';

class ShowMnemonic extends StatefulWidget {
  ShowMnemonic({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShowMnemonicState createState() => _ShowMnemonicState();
}

class _ShowMnemonicState extends State<ShowMnemonic> {
  static GlobalKey<ScaffoldState> scaffoldState;

  @override
  Future initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      withPadding: true,
      footer: null,
      title: "Back up",
      titleFontSize: 15,
      backgroundColor: Colors.white,
      children: <Widget>[
      Container(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("Please write down those 12 words:",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal)),
            )
          ],
        ),
      ),
      new StoreConnector<AppState, BackupViewModel>(converter: (store) {
        return BackupViewModel.fromStore(store);
      }, builder: (_, viewModel) {
        return (viewModel.user != null && viewModel.user.mnemonic.length > 0)
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Container(
                      // decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      //     color: const Color(0xFFFFFFFF)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 12.0, // soften the shadow
                            spreadRadius: .10, //extend the shadow
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              // blurRadius: 10.0, // soften the shadow
                              // spreadRadius: 7.0, //extend the shadow
                            )
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                wordWidget(viewModel.user.mnemonic[0]),
                                wordWidget(viewModel.user.mnemonic[1]),
                                wordWidget(viewModel.user.mnemonic[2])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                wordWidget(viewModel.user.mnemonic[3]),
                                wordWidget(viewModel.user.mnemonic[4]),
                                wordWidget(viewModel.user.mnemonic[5])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                wordWidget(viewModel.user.mnemonic[6]),
                                wordWidget(viewModel.user.mnemonic[7]),
                                wordWidget(viewModel.user.mnemonic[8])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                wordWidget(viewModel.user.mnemonic[9]),
                                wordWidget(viewModel.user.mnemonic[10]),
                                wordWidget(viewModel.user.mnemonic[11])
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 25),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CopyToClipboard(
                                      context: context,
                                      // scaffoldState: scaffoldState,
                                      content:
                                          viewModel.user.mnemonic.join(" "),
                                    ),
                                    const SizedBox(width: 4.0),
                                    Icon(
                                      Icons.content_copy,
                                      color: const Color(0xFF546c7c),
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Center(
                      child: PrimaryButton(
                    fontSize: 15,
                    width: 160,
                    label: "Next",
                    labelFontWeight: FontWeight.normal,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/Backup2');
                    },
                  )),
                  const SizedBox(height: 16.0),
                  TransparentButton(
                      label: "Skip",
                      onPressed: () {
                        Navigator.pushNamed(context, '/Cash');
                      }),
                  const SizedBox(height: 30.0),
                ],
              )
            : Padding(
                child: Preloader(),
                padding: EdgeInsets.only(top: 70),
              );
      })
    ]);
  }

  Widget wordWidget(word) {
    return Expanded(
      child: Center(
        child: Padding(
          child: Text(word,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
        ),
      ),
    );
  }
}

class BackupViewModel {
  final UserState user;

  BackupViewModel({this.user});

  static BackupViewModel fromStore(Store<AppState> store) {
    return BackupViewModel(
      user: store.state.userState,
    );
  }
}
