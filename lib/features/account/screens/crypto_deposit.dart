import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/backup.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:fusecash/widgets/snackbars.dart';

class CryptoDepositScreen extends StatelessWidget {
  final String link;
  CryptoDepositScreen({this.link});
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
                      I10n.of(context).crypto_deposit_explained,
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
                          )
                          // fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      I10n.of(context).crypto_deposit_risk_2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(
                            0xFF797979,
                          )
                          // fontWeight: FontWeight.bold,
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
                          if (ExtendedNavigator.named('accountRouter')
                              .canPop()) {
                            ExtendedNavigator.named('accountRouter')
                                .popUntilRoot();
                          } else if (ExtendedNavigator.named('homeRouter')
                              .canPop()) {
                            ExtendedNavigator.named('homeRouter')
                                .popUntilRoot();
                          }
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
          );
        },
      ),
    );
  }
}
