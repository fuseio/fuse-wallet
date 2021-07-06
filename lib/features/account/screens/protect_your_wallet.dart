import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/screens/set_up_pincode.dart';
import 'package:fusecash/redux/viewsmodels/security.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';

class ProtectYourWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).protect_wallet,
      body: StoreConnector<AppState, SecurityViewModel>(
        distinct: true,
        converter: SecurityViewModel.fromStore,
        builder: (_, viewModel) {
          final isBiometric = viewModel.authType == BiometricAuth.faceID ||
              viewModel.authType == BiometricAuth.touchID;
          return Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  onTap: () {
                    context.router.push(ShowMnemonic());
                  },
                  title: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/backup_icon.svg',
                        width: 18,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        I10n.of(context).back_up,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !viewModel.isBackup
                          ? Flexible(
                              child: SvgPicture.asset(
                                'assets/images/back_up_icon.svg',
                                width: 12,
                              ),
                            )
                          : SizedBox.shrink(),
                      !viewModel.isBackup
                          ? Flexible(
                              child: SizedBox(
                                width: 10,
                              ),
                            )
                          : SizedBox.shrink(),
                      Flexible(
                        child: Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(I10n.of(context).please_choose_security),
                ),
                MenuTile(
                  label: BiometricUtils.getBiometricString(
                    context,
                    viewModel.authType,
                  ),
                  menuIcon:
                      '${BiometricAuth.faceID == viewModel.authType ? 'face_id' : 'fingerprint'}.svg',
                  trailing: isBiometric
                      ? SvgPicture.asset(
                          'assets/images/checkmark.svg',
                        )
                      : null,
                  onTap: () async {
                    final BiometricAuth biometricAuth =
                        await BiometricUtils.getAvailableBiometrics();
                    final String biometric = BiometricUtils.getBiometricString(
                      context,
                      biometricAuth,
                    );
                    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
                      message:
                          '${I10n.of(context).please_use} $biometric ${I10n.of(context).to_unlock}',
                      callback: (bool result) {
                        if (result) {
                          viewModel.setSecurityType(biometricAuth);
                          Navigator.of(context).pop();
                        }
                      },
                    );
                  },
                ),
                Divider(),
                MenuTile(
                  label: I10n.of(context).pincode,
                  menuIcon: 'pincode.svg',
                  trailing: !isBiometric
                      ? SvgPicture.asset(
                          'assets/images/checkmark.svg',
                        )
                      : null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetUpPinCodeScreen(
                          onSuccess: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
