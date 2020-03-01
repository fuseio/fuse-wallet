import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/backup.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';

class DoneBackup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BackupViewModel>(
      converter: BackupViewModel.fromStore,
      builder: (_, viewModal) => MainScaffold(
          withPadding: false,
          footer: bottomBar(context),
          title: I18n.of(context).back_up,
          titleFontSize: 15,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        'assets/images/wallet_protect.png',
                        fit: BoxFit.cover,
                        height: 85,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        I18n.of(context).wallet_protected,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          I18n.of(context).wallet_protected_text,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: PrimaryButton(
                    labelFontWeight: FontWeight.normal,
                    label: I18n.of(context).ok,
                    fontSize: 15,
                    // width: 160,
                    onPressed: () async {
                      viewModal.backupWallet();
                      Navigator.popUntil(context, ModalRoute.withName('/Cash'));
                    },
                  ))
                ],
              ),
            )
          ]),
    );
  }
}
