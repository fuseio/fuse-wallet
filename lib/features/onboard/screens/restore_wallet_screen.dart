import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/recovery.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class RestoreWalletPage extends StatefulWidget {
  const RestoreWalletPage({Key? key}) : super(key: key);

  @override
  State<RestoreWalletPage> createState() => _RestoreWalletPageState();
}

class _RestoreWalletPageState extends SfWidget<RestoreWalletPage> {
  bool isLoading = false;
  final wordsController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    wordsController.dispose();
    super.dispose();
  }

  String? validator(value) {
    if (value?.split(" ").length != 12) {
      return 'Please enter 12 words';
    } else if (Web3.validateMnemonic(value)) {
      return null;
    } else {
      return I10n.of(context).invalid_mnemonic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).restore_from_backup,
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0,
                  top: 0.0,
                ),
                child: Column(
                  children: [
                    Text(
                      I10n.of(context).restore_words,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 30,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: wordsController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        autofocus: false,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          fillColor: Colors.transparent,
                        ),
                        validator: validator,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomContent: StoreConnector<AppState, RecoveryViewModel>(
        distinct: true,
        converter: RecoveryViewModel.fromStore,
        builder: (_, viewModel) => GradientButton(
          preload: isLoading,
          disabled: isLoading,
          width: MediaQuery.of(context).size.width * .9,
          textColor: Theme.of(context).canvasColor,
          text: I10n.of(context).next_button,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                isLoading = true;
              });
              viewModel.generateWalletFromBackup(
                  wordsController.text.toLowerCase(), () {
                setState(() {
                  isLoading = false;
                });
                context.router.push(const SignUpRoute());
              }, () {
                setState(() {
                  isLoading = false;
                });
                super.throwAlert(
                  context,
                  I10n.of(context).phrase_invaild,
                  type: AlertsTypeEnum.ERROR,
                );
              });
            }
          },
        ),
      ),
    );
  }
}
