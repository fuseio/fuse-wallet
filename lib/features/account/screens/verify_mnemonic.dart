import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class Word extends StatelessWidget {
  const Word({
    Key? key,
    required this.mnemonic,
    required this.wordIndex,
  }) : super(key: key);
  final List<String> mnemonic;
  final int wordIndex;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: I10n.of(context).word + wordIndex.toString(),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        fillColor: Theme.of(context).canvasColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 2,
          ),
        ),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      validator: (String? value) {
        if (mnemonic[wordIndex - 1] != value?.trim()) {
          return I10n.of(context).word_not_match;
        }
        return null;
      },
    );
  }
}

class VerifyMnemonicPage extends StatefulWidget {
  const VerifyMnemonicPage({Key? key}) : super(key: key);

  @override
  State<VerifyMnemonicPage> createState() => _VerifyMnemonicPageState();
}

class _VerifyMnemonicPageState extends State<VerifyMnemonicPage> {
  List<int> selectedWordsNum = <int>[];
  final _formKey = GlobalKey<FormState>();

  List<int> getRandom3Numbers() {
    var list = List<int>.generate(12, (int index) => index + 1);
    list.shuffle();
    var l = list.sublist(0, 3);
    l.sort();
    return l;
  }

  @override
  void initState() {
    super.initState();

    selectedWordsNum = getRandom3Numbers();
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).back_up,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                  top: 20.0,
                ),
                child: Column(
                  children: [
                    Text(
                      I10n.of(context).write_word + selectedWordsNum.join(", "),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                          ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  children: [
                    StoreConnector<AppState, BackupViewModel>(
                      distinct: true,
                      converter: BackupViewModel.fromStore,
                      builder: (_, viewModel) => Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Word(
                              mnemonic: viewModel.userMnemonic,
                              wordIndex: selectedWordsNum[0],
                            ),
                            const SizedBox(height: 16.0),
                            Word(
                              mnemonic: viewModel.userMnemonic,
                              wordIndex: selectedWordsNum[1],
                            ),
                            const SizedBox(height: 16.0),
                            Word(
                              mnemonic: viewModel.userMnemonic,
                              wordIndex: selectedWordsNum[2],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Center(
                child: GradientButton(
                  width: MediaQuery.of(context).size.width * .9,
                  text: I10n.of(context).next_button,
                  textColor: Theme.of(context).canvasColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Analytics.track(
                        eventName: AnalyticsEvents.protectionBackUp3,
                      );
                      context.router.push(const DoneBackupRoute());
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
