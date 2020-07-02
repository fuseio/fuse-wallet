import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/models/views/backup.dart';
import 'package:peepl/screens/backup/verify_mnemonic.dart';
import 'package:peepl/widgets/main_scaffold.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:peepl/models/app_state.dart';
import 'package:peepl/widgets/copy.dart';
import 'package:peepl/widgets/preloader.dart';
import 'package:peepl/widgets/primary_button.dart';

class ShowMnemonic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        withPadding: true,
        title: I18n.of(context).back_up,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: new TextSpan(
                          style: TextStyle(fontSize: 18),
                          children: <InlineSpan>[
                            TextSpan(
                              text: I18n.of(context).important + ' ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                                text: I18n.of(context).write_words,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))
                          ])),
                )
              ],
            ),
          ),
          new StoreConnector<AppState, BackupViewModel>(
              distinct: true,
              onInit: (store) {
                Segment.screen(screenName: '/show-mnemonic');
              },
              converter: BackupViewModel.fromStore,
              builder: (_, viewModel) {
                return (viewModel.user != null &&
                        viewModel.user.mnemonic.isNotEmpty)
                    ? Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 30, right: 30),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[0], 1),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[1], 2),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[2], 3)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[3], 4),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[4], 5),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[5], 6)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[6], 7),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[7], 8),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[8], 9)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[9], 10),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[10], 11),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[11], 12)
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 25),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          CopyToClipboard(
                                            context: context,
                                            content: viewModel.user.mnemonic
                                                .join(" "),
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
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => VerifyMnemonic()));
                              // Router.navigator.pushNamed(Router.verifyMnemonic);
                            },
                          )),
                        ],
                      )
                    : Padding(
                        child: Preloader(),
                        padding: EdgeInsets.only(top: 70),
                      );
              })
        ]);
  }

  Widget wordWidget(context, word, int index) {
    return Expanded(
      child: Center(
        child: Padding(
          child: Text("${index.toString()}. $word",
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
