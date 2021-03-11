import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/copy.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:fusecash/widgets/primary_button.dart';

class ShowMnemonic extends StatelessWidget {
  Widget wordWidget(
    BuildContext context,
    String word,
    int index,
  ) =>
      Expanded(
        child: Center(
          child: Padding(
            child: Text("${index.toString()}. $word",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I18n.of(context).back_up,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Europa',
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: I18n.of(context).important + ' ',
                              ),
                              TextSpan(
                                text: I18n.of(context).write_words,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                StoreConnector<AppState, BackupViewModel>(
                  distinct: true,
                  converter: BackupViewModel.fromStore,
                  builder: (_, viewModel) {
                    return (viewModel.user != null &&
                            viewModel.user.mnemonic.length > 0)
                        ? Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 30, right: 30),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
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
                                        padding: EdgeInsets.only(
                                          top: 30,
                                          bottom: 25,
                                        ),
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
                            ],
                          )
                        : Padding(
                            child: Preloader(),
                            padding: EdgeInsets.only(top: 70),
                          );
                  },
                ),
              ],
            ),
            Column(
              children: [
                Center(
                  child: PrimaryButton(
                    label: I18n.of(context).next_button,
                    onPressed: () async {
                      ExtendedNavigator.named('homeRouter')
                          .push(HomeRoutes.verifyMnemonic);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
