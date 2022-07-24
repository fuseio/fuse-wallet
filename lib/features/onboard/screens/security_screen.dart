import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/features/screens/set_up_pincode.dart';
import 'package:fusecash/features/shared/widgets/button.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/security.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class ChooseSecurityPage extends StatefulWidget {
  const ChooseSecurityPage({Key? key}) : super(key: key);

  @override
  State<ChooseSecurityPage> createState() => _ChooseSecurityPageState();
}

class _ChooseSecurityPageState extends SfWidget<ChooseSecurityPage> {
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
      title: I10n.of(context).protect_wallet,
      hasScrollBody: false,
      body: Container(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                SvgPicture.asset('assets/images/lock.svg'),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    I10n.of(context).choose_lock_method,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF888888),
                          fontSize: 18,
                        ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _biometricType == BiometricAuth.none
                              ? const SizedBox.shrink()
                              : StoreConnector<AppState, SecurityViewModel>(
                                  distinct: true,
                                  converter: SecurityViewModel.fromStore,
                                  builder: (_, viewModel) {
                                    return GradientButton(
                                      centerContent: false,
                                      trailing: Row(
                                        children: [
                                          Icon(
                                            Icons.info,
                                            size: 15,
                                            color:
                                                Theme.of(context).canvasColor,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            I10n.of(context).recommended,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      icon: SvgPicture.asset(
                                        'assets/images/${BiometricAuth.faceID == _biometricType ? 'face_id' : 'fingerprint'}.svg',
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      textColor: Theme.of(context).canvasColor,
                                      text: BiometricUtils.getBiometricString(
                                        context,
                                        _biometricType,
                                      ),
                                      onPressed: () async {
                                        final String biometric =
                                            BiometricUtils.getBiometricString(
                                          context,
                                          _biometricType,
                                        );

                                        await BiometricUtils
                                            .showDefaultPopupCheckBiometricAuth(
                                          message:
                                              '${I10n.of(context).please_use} $biometric ${I10n.of(context).to_unlock}',
                                          callback: (bool result) {
                                            if (result) {
                                              Analytics.track(
                                                eventName:
                                                    AnalyticsEvents.lockScreen,
                                                properties: Map.from({
                                                  "protectionType": biometric,
                                                }),
                                              );
                                              viewModel.setSecurityType(
                                                _biometricType,
                                              );
                                              Analytics.track(
                                                eventName: AnalyticsEvents
                                                    .onboardingCompleted,
                                              );
                                              context.router.replaceAll(
                                                  [const MainRoute()]);
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          Button(
                            centerContent: false,
                            icon: SvgPicture.asset(
                              'assets/images/pincode.svg',
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            backgroundColor: const Color(0xFFF7F7F7),
                            width: MediaQuery.of(context).size.width * .9,
                            text: I10n.of(context).pincode,
                            textColor: Theme.of(context).colorScheme.onSurface,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SetUpPinCodeScreen(
                                    onSuccess: () {
                                      Analytics.track(
                                        eventName: AnalyticsEvents.lockScreen,
                                        properties: Map.from({
                                          "protectionType": 'PinCode',
                                        }),
                                      );
                                      Analytics.track(
                                        eventName:
                                            AnalyticsEvents.onboardingCompleted,
                                      );
                                      context.router
                                          .replaceAll([const MainRoute()]);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
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
