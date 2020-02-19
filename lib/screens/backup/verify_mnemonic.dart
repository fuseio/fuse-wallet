import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/backup.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';

class VerifyMnemonic extends StatefulWidget {
  VerifyMnemonic({Key key, this.title}) : super(key: key);

  final String title;

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
    return StoreConnector<AppState, BackupViewModel>(
        converter: BackupViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
              withPadding: true,
              footer: null,
              titleFontSize: 15,
              title: I18n.of(context).back_up,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 20.0, top: 0.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                            I18n.of(context).write_word +
                                selectedWordsNum.join(", "),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 30, right: 30),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    labelText: I18n.of(context).word +
                                        ' ' +
                                        selectedWordsNum[0].toString(),
                                  ),
                                  validator: (String value) {
                                    if (viewModel.user.mnemonic[
                                            selectedWordsNum[0] - 1] !=
                                        value.trim()) {
                                      return I18n.of(context).word_not_match;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    labelText: I18n.of(context).word +
                                        selectedWordsNum[1].toString(),
                                  ),
                                  validator: (String value) {
                                    if (viewModel.user.mnemonic[
                                            selectedWordsNum[1] - 1] !=
                                        value.trim()) {
                                      return I18n.of(context).word_not_match;
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    labelText: I18n.of(context).word +
                                        selectedWordsNum[2].toString(),
                                  ),
                                  validator: (String value) {
                                    if (viewModel.user.mnemonic[
                                            selectedWordsNum[2] - 1] !=
                                        value.trim()) {
                                      return I18n.of(context).word_not_match;
                                    }
                                    return null;
                                  },
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                      child: PrimaryButton(
                    labelFontWeight: FontWeight.normal,
                    label: I18n.of(context).next_button,
                    fontSize: 15,
                    width: 160,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        Navigator.pushNamed(context, '/Backup3');
                      }
                    },
                  )),
                ),
                const SizedBox(height: 30.0),
              ]);
        });
  }
}
