import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/onboard/dialogs/warn_before_recreate.dart';
import 'package:fusecash/features/shared/widgets/fade_slide_transition.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/transparent_button.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/splash.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class SignUpButtons extends StatefulWidget {
  const SignUpButtons({Key? key}) : super(key: key);

  @override
  State<SignUpButtons> createState() => _SignUpButtonsState();
}

class _SignUpButtonsState extends State<SignUpButtons> {
  bool isPrimaryPreloading = false;
  bool isTransparentPreloading = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
      distinct: true,
      converter: SplashViewModel.fromStore,
      builder: (_, viewModel) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyFadeSlideTransition(
                delay: 800,
                child: Text(
                  I10n.of(context).lets_start,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GradientButton(
                width: 255,
                textColor: Theme.of(context).canvasColor,
                disabled: isPrimaryPreloading,
                preload: isPrimaryPreloading,
                text: viewModel.isLoggedOut
                    ? I10n.of(context).login
                    : I10n.of(context).create_new_wallet,
                onPressed: () {
                  if (viewModel.isLoggedOut) {
                    Analytics.track(eventName: AnalyticsEvents.login);
                    viewModel.loginAgain();
                    if (context.router.canPopSelfOrChildren) {
                      context.router.popUntilRoot();
                    }
                    context.router.replaceAll([const MainRoute()]);
                  } else {
                    setState(() {
                      isPrimaryPreloading = true;
                    });
                    viewModel.createLocalAccount(() {
                      setState(() {
                        isPrimaryPreloading = false;
                      });
                      context.router.push(const SignUpRoute());
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: viewModel.isLoggedOut
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TransparentButton(
                            fontSize: 14,
                            label: I10n.of(context).restore_backup,
                            onPressed: () {
                              context.router.push(const RestoreWalletRoute());
                            },
                          ),
                          Text(
                            I10n.of(context).or,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xFFB2B2B2),
                                ),
                          ),
                          TransparentButton(
                            fontSize: 14,
                            label: I10n.of(context).create__wallet,
                            preload: isTransparentPreloading,
                            onPressed: () async {
                              bool result = await const WarnBeforeReCreation()
                                  .showSheet(context);
                              setState(() {
                                isTransparentPreloading = false;
                              });
                              if (result) {
                                viewModel.createLocalAccount(() {
                                  context.router.push(const SignUpRoute());
                                });
                              }
                            },
                          )
                        ],
                      )
                    : TransparentButton(
                        label: I10n.of(context).restore_from_backup,
                        onPressed: () {
                          context.router.push(const RestoreWalletRoute());
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
