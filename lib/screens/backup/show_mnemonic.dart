import 'dart:core';
import 'package:flutter/material.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/widgets/main_scaffold.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:paywise/models/app_state.dart';
import 'package:paywise/models/user_state.dart';
import 'package:paywise/widgets/copy.dart';
import 'package:paywise/widgets/preloader.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:paywise/widgets/transparent_button.dart';

class ShowMnemonic extends StatelessWidget {
  ShowMnemonic();

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      withPadding: true,
      footer: null,
      title: I18n.of(context).back_up,
      titleFontSize: 15,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      children: <Widget>[
      Container(
        padding:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(I18n.of(context).write_words, // "Please write down those 12 words:",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                wordWidget(context, viewModel.user.mnemonic[0]),
                                wordWidget(context, viewModel.user.mnemonic[1]),
                                wordWidget(context, viewModel.user.mnemonic[2])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                wordWidget(context, viewModel.user.mnemonic[3]),
                                wordWidget(context, viewModel.user.mnemonic[4]),
                                wordWidget(context, viewModel.user.mnemonic[5])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                wordWidget(context, viewModel.user.mnemonic[6]),
                                wordWidget(context, viewModel.user.mnemonic[7]),
                                wordWidget(context, viewModel.user.mnemonic[8])
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                wordWidget(context, viewModel.user.mnemonic[9]),
                                wordWidget(context, viewModel.user.mnemonic[10]),
                                wordWidget(context, viewModel.user.mnemonic[11])
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, bottom: 25),
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
                  const SizedBox(height: 30.0),
                  Center(
                      child: PrimaryButton(
                    fontSize: 15,
                    width: 160,
                    label: I18n.of(context).next_button,
                    labelFontWeight: FontWeight.normal,
                    onPressed: () async {
                      Navigator.pushNamed(context, '/Backup2');
                    },
                  )),
                  const SizedBox(height: 16.0),
                  TransparentButton(
                      label: I18n.of(context).skip_button,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Cash');
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

  Widget wordWidget(context, word) {
    return Expanded(
      child: Center(
        child: Padding(
          child: Text(word,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal)),
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
