import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/screens/set_up_pincode.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/security.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class ProtectYourWalletPage extends StatefulWidget {
  const ProtectYourWalletPage({Key? key}) : super(key: key);

  @override
  State<ProtectYourWalletPage> createState() => _ProtectYourWalletPageState();
}

class _ProtectYourWalletPageState extends SfWidget<ProtectYourWalletPage> {
  BiometricAuth _biometricType = BiometricAuth.none;

  @override
  onInitApp() async {
    _checkBiometrical();
  }

  Future<void> _checkBiometrical() async {
    _biometricType = await BiometricUtils.getAvailableBiometrics();
    if (_biometricType != BiometricAuth.none) {
      setState(() {
        _biometricType = _biometricType;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      hasScrollBody: false,
      title: I10n.of(context).protect_wallet,
      body: StoreConnector<AppState, SecurityViewModel>(
        distinct: true,
        converter: SecurityViewModel.fromStore,
        builder: (_, viewModel) {
          final isBiometric = viewModel.authType == BiometricAuth.faceID ||
              viewModel.authType == BiometricAuth.touchID;
          return SizedBox(
            height: 1,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                MenuTile(
                  menuIcon: 'backup_icon.svg',
                  label: I10n.of(context).back_up,
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
                          : const SizedBox.shrink(),
                      !viewModel.isBackup
                          ? const Flexible(
                              child: SizedBox(
                                width: 10,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Flexible(
                        child: Icon(
                          Icons.navigate_next,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Analytics.track(
                      eventName: AnalyticsEvents.protectionBackUp1,
                    );
                    context.router.push(const ShowMnemonicRoute());
                  },
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(I10n.of(context).please_choose_security),
                ),
                if (_biometricType == BiometricAuth.none)
                  const SizedBox.shrink()
                else
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
                    onTap: () {
                      BiometricUtils.getAvailableBiometrics()
                          .then((BiometricAuth biometricAuth) async {
                        final String biometric =
                            BiometricUtils.getBiometricString(
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
                      });
                    },
                  ),
                _biometricType == BiometricAuth.none
                    ? const SizedBox.shrink()
                    : const Divider(),
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
