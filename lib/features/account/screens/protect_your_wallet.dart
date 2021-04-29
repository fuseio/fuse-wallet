import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/screens/set_up_pincode.dart';
import 'package:fusecash/redux/viewsmodels/security.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/features/account/router/router.gr.dart';

class ProtectYourWallet extends StatefulWidget {
  @override
  _ProtectYourWalletState createState() => _ProtectYourWalletState();
}

class _ProtectYourWalletState extends State<ProtectYourWallet> {
  BiometricAuth _biometricType;

  Future<void> _checkBiometricable() async {
    _biometricType = await BiometricUtils.getAvailableBiometrics();
    if (_biometricType != BiometricAuth.none) {
      setState(() {
        _biometricType = _biometricType;
      });
    }
  }

  @override
  void initState() {
    _checkBiometricable();
    super.initState();
  }

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
                MenuTile(
                  label: I10n.of(context).back_up,
                  menuIcon: 'backup_icon.svg',
                  onTap:
                      ExtendedNavigator.named('accountRouter').pushShowMnemonic,
                  trailing: SvgPicture.asset(
                    viewModel.isBackup
                        ? 'assets/images/go_to_pro.svg'
                        : 'assets/images/back_up_icon.svg',
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
                    _biometricType,
                  ),
                  menuIcon:
                      '${BiometricAuth.faceID == _biometricType ? 'face_id' : 'fingerprint'}.svg',
                  trailing: isBiometric
                      ? SvgPicture.asset(
                          'assets/images/checkmark.svg',
                        )
                      : null,
                  onTap: () async {
                    final String biometric =
                        BiometricUtils.getBiometricString(_biometricType);

                    await BiometricUtils.showDefaultPopupCheckBiometricAuth(
                      message: 'Please use $biometric to unlock!',
                      callback: (bool result) {
                        if (result) {
                          viewModel.setSecurityType(_biometricType);
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
