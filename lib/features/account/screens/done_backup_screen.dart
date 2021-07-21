import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';

class DoneBackup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).back_up,
      body: StoreConnector<AppState, BackupViewModel>(
        converter: BackupViewModel.fromStore,
        builder: (_, viewModal) {
          return Container(
            padding: EdgeInsets.only(
              bottom: 40.0,
              top: 0.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    SvgPicture.asset(
                      'assets/images/wallet_protect.svg',
                      fit: BoxFit.cover,
                      height: 85,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      I10n.of(context).wallet_protected,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 30,
                      ),
                      child: Text(
                        I10n.of(context).wallet_protected_text,
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: PrimaryButton(
                        label: I10n.of(context).ok,
                        onPressed: () {
                          viewModal.backupWallet();
                          context.router.popUntilRoot();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
