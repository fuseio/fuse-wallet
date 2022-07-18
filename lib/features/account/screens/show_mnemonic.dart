import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/widgets/copy.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class ShowMnemonicPage extends StatelessWidget {
  const ShowMnemonicPage({Key? key}) : super(key: key);

  Widget wordWidget(
    BuildContext context,
    String word,
    int index,
  ) =>
      Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 0,
            ),
            child: Text(
              "${index.toString()}. $word",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).back_up,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
              top: 0.0,
            ),
            child: AutoSizeText.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                children: [
                  TextSpan(
                    text: '${I10n.of(context).important} ',
                  ),
                  TextSpan(
                    text: I10n.of(context).write_words,
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          StoreConnector<AppState, BackupViewModel>(
            distinct: true,
            converter: BackupViewModel.fromStore,
            builder: (_, viewModel) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            wordWidget(
                              context,
                              viewModel.userMnemonic[0],
                              1,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[1],
                              2,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[2],
                              3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            wordWidget(
                              context,
                              viewModel.userMnemonic[3],
                              4,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[4],
                              5,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[5],
                              6,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            wordWidget(
                              context,
                              viewModel.userMnemonic[6],
                              7,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[7],
                              8,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[8],
                              9,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            wordWidget(
                              context,
                              viewModel.userMnemonic[9],
                              10,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[10],
                              11,
                            ),
                            wordWidget(
                              context,
                              viewModel.userMnemonic[11],
                              12,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 25,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CopyToClipboard(
                                content: viewModel.userMnemonic.join(" "),
                              ),
                              const SizedBox(width: 4.0),
                              const Icon(
                                Icons.content_copy,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomContent: GradientButton(
        width: MediaQuery.of(context).size.width * .9,
        text: I10n.of(context).next_button,
        textColor: Theme.of(context).canvasColor,
        onPressed: () {
          Analytics.track(eventName: AnalyticsEvents.protectionBackUp2);
          context.router.push(const VerifyMnemonicRoute());
        },
      ),
    );
  }
}
