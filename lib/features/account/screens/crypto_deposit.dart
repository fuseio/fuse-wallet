import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:fusecash/features/shared/widgets/primary_button.dart';
import 'package:fusecash/features/shared/widgets/snackbars.dart';

class CryptoDepositScreen extends StatelessWidget {
  final String link;
  final String text;
  CryptoDepositScreen(
    this.link,
    this.text,
  );
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).top_up,
      body: StoreConnector<AppState, BackupViewModel>(
        converter: BackupViewModel.fromStore,
        builder: (_, viewModal) {
          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    SvgPicture.asset(
                      'assets/images/fusedwap_topup.svg',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      focusColor: Theme.of(context).canvasColor,
                      highlightColor: Theme.of(context).canvasColor,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: link,
                          ),
                        );
                        showCopiedFlushbar(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              link,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0076FF),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Icon(
                              Icons.copy,
                              size: 20,
                              color: Color(0xFF0076FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      I10n.of(context).crypto_deposit_risk,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(
                          0xFF797979,
                        ),
                      ),
                    ),
                    Text(
                      I10n.of(context).crypto_deposit_risk_2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(
                          0xFF797979,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: PrimaryButton(
                        label: I10n.of(context).ok,
                        onPressed: AutoRouter.of(context).popUntilRoot,
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
