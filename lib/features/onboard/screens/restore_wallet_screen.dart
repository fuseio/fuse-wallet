import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/features/shared/widgets/snackbars.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/recovery.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';

class RestoreFromBackupScreen extends StatefulWidget {
  @override
  _RestoreFromBackupScreenState createState() =>
      _RestoreFromBackupScreenState();
}

class _RestoreFromBackupScreenState extends State<RestoreFromBackupScreen> {
  bool isLoading = false;
  final wordsController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    wordsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).restore_from_backup,
      body: Container(
        padding: EdgeInsets.only(
          bottom: 40.0,
          top: 0.0,
        ),
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
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          I10n.of(context).restore_words,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
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
                          child: TextFormField(
                            controller: wordsController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            autofocus: false,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              backgroundColor: Theme.of(context).canvasColor,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              fillColor: Colors.transparent,
                            ),
                            validator: (String? value) =>
                                value?.split(" ").length != 12
                                    ? 'Please enter 12 words'
                                    : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StoreConnector<AppState, RecoveryViewModel>(
                  distinct: true,
                  converter: RecoveryViewModel.fromStore,
                  builder: (_, viewModel) => Center(
                    child: PrimaryButton(
                      preload: isPreloading,
                      disabled: isPreloading,
                      label: I10n.of(context).next_button,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isPreloading = true;
                          });
                          viewModel.generateWalletFromBackup(
                              wordsController.text.toLowerCase(), () {
                            setState(() {
                              isPreloading = false;
                            });
                            context.router.push(SignUpScreen());
                          }, () {
                            setState(() {
                              isPreloading = false;
                            });
                            showErrorSnack(
                              context: context,
                              message: I10n.of(context).phrase_invaild,
                              title: I10n.of(context).oops,
                            );
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
