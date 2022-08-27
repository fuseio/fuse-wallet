import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/features/account/widgets/avatar.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/shared/bottom_sheets/deposit.dart';
import 'package:fusecash/features/shared/widgets/my_new_scaffold.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return MyNewScaffold(
      hasScrollBody: false,
      title: I10n.of(context).account,
      body: SizedBox(
        height: 1,
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          children: [
            const Avatar(),
            StoreConnector<AppState, AccountViewModel>(
              distinct: true,
              converter: AccountViewModel.fromStore,
              builder: (_, viewModel) {
                return ListView(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    MenuTile(
                      label: I10n.of(context).settings,
                      menuIcon: 'settings_icon.svg',
                      onTap: () {
                        context.router.push(const SettingsRoute());
                      },
                    ),
                    if (viewModel.hasPreviousSessions)
                      MenuTile(
                        label: I10n.of(context).connected_DApps,
                        menuIcon: 'connected_dapp.svg',
                        onTap: () {
                          context.router.push(const ConnectedDAppsRoute());
                        },
                      ),
                    MenuTile(
                      label: I10n.of(context).protect_wallet,
                      menuIcon: 'protect_wallet.svg',
                      onTap: () {
                        context.router.push(const ProtectYourWalletRoute());
                      },
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
                    ),
                    MenuTile(
                      label: '${I10n.of(context).top_up} \$',
                      menuIcon: 'top_up_icon.svg',
                      onTap: () {
                        const DepositBottomSheet().showSheet(
                          context,
                          'AccountScreen',
                        );
                      },
                    ),
                    MenuTile(
                      label: I10n.of(context).legal,
                      menuIcon: 'legal_icon.svg',
                      onTap: () {
                        context.router.push(
                          Webview(
                            title: I10n.of(context).legal,
                            url: Variables.privacyPolicyPage,
                          ),
                        );
                      },
                    ),
                    MenuTile(
                      label: "Verify a Verifiable Credential",
                      menuIcon: 'legal_icon.svg',
                      onTap: () {
                        context.router.push(
                          const VerifyVerifiableCredentialRoute(),
                        );
                      },
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
