import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/features/account/router/router.gr.dart';

class Word extends StatelessWidget {
  Word({
    Key key,
    this.mnemonic,
    this.wordIndex,
  }) : super(key: key);
  final List<String> mnemonic;
  final int wordIndex;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
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
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      validator: (String value) {
        if (mnemonic[wordIndex - 1] != value.trim()) {
          return I10n.of(context).word_not_match;
        }
        return null;
      },
    );
  }
}

class VerifyMnemonic extends StatefulWidget {
  @override
  _VerifyMnemonicState createState() => _VerifyMnemonicState();
}

class _VerifyMnemonicState extends State<VerifyMnemonic> {
  List<int> selectedWordsNum = new List<int>();
  final _formKey = GlobalKey<FormState>();

  List<int> getRandom3Numbers() {
    var list = new List<int>.generate(12, (int index) => index + 1);
    list.shuffle();
    var _l = list.sublist(0, 3);
    _l.sort();
    return _l;
  }

  @override
  void initState() {
    super.initState();

    selectedWordsNum = getRandom3Numbers();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).back_up,
      body: StoreConnector<AppState, BackupViewModel>(
        converter: BackupViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        bottom: 20.0,
                        top: 20.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            I10n.of(context).write_word +
                                selectedWordsNum.join(", "),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Column(
                        children: <Widget>[
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Word(
                                  mnemonic: viewModel.user.mnemonic,
                                  wordIndex: selectedWordsNum[0],
                                ),
                                SizedBox(height: 16.0),
                                Word(
                                  mnemonic: viewModel.user.mnemonic,
                                  wordIndex: selectedWordsNum[1],
                                ),
                                SizedBox(height: 16.0),
                                Word(
                                  mnemonic: viewModel.user.mnemonic,
                                  wordIndex: selectedWordsNum[2],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Center(
                          child: PrimaryButton(
                        label: I10n.of(context).next_button,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            ExtendedNavigator.named('accountRouter')
                                .pushDoneBackup();
                          }
                        },
                      )),
                    ),
                    SizedBox(height: 30.0),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
