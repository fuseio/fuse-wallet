import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/common/di/package_info.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/features/account/widgets/language_selector.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/shared/dialogs/wallet_upgrade.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/viewsmodels/settings.dart';
import 'package:fusecash/utils/analytics/analytics.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF7E7E7E),
            );
    return InnerScaffold(
      hasScrollBody: false,
      title: I10n.of(context).settings,
      body: SizedBox(
        height: 1,
        child: StoreConnector<AppState, SettingsViewModel>(
          distinct: true,
          converter: SettingsViewModel.fromStore,
          builder: (_, viewModel) => ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            children: [
              const LanguageSelector(),
              const Divider(),
              MenuTile(
                label: I10n.of(context).version,
                menuIcon: 'app_version.svg',
                trailing: Text(
                  "${packageInfo.version} ${(packageInfo.buildNumber)}",
                  style: textStyle,
                ),
              ),
              const Divider(),
              if (viewModel.contractVersion != null)
                MenuTile(
                  label: I10n.of(context).contract_version,
                  menuIcon: 'contract_version.svg',
                  trailing: viewModel.hasUpgrade
                      ? GradientButton(
                          height: 35,
                          text: I10n.of(context).update,
                          width: 80,
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            const WalletUpgradeDialog().showSheet(context);
                          },
                        )
                      : Text(
                          viewModel.contractVersion!,
                          style: textStyle,
                        ),
                  onTap: viewModel.hasUpgrade
                      ? () => const WalletUpgradeDialog().showSheet(context)
                      : null,
                ),
              if (viewModel.contractVersion != null) const Divider(),
              MenuTile(
                withTrailing: false,
                label: I10n.of(context).logout,
                menuIcon: 'log-out.svg',
                onTap: () {
                  StoreProvider.of<AppState>(context).dispatch(
                    LogoutRequestSuccess(),
                  );
                  Analytics.track(eventName: AnalyticsEvents.logout);
                  context.router.replace(const OnBoardingRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
