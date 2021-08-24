import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/features/account/widgets/avatar.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/account.dart';
import 'package:fusecash/utils/webview.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).account,
      body: StoreConnector<AppState, AccountViewModel>(
        distinct: true,
        converter: AccountViewModel.fromStore,
        builder: (_, viewModel) {
          List depositPlugins = viewModel.plugins.getDepositPlugins();
          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Avatar(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            MenuTile(
                              label: I10n.of(context).settings,
                              menuIcon: 'settings_icon.svg',
                              onTap: () {
                                context.router.push(SettingsScreen());
                              },
                            ),
                            // MenuTile(
                            //   label: I10n.of(context).switch_community,
                            //   menuIcon: 'switch_icon.svg',
                            //   onTap: () {
                            //     context.router.push(SwitchCommunityScreen());
                            //   },
                            // ),
                            MenuTile(
                              label: I10n.of(context).protect_wallet,
                              menuIcon: 'protect_wallet.svg',
                              onTap: () {
                                context.router.push(ProtectYourWallet());
                              },
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            depositPlugins.isNotEmpty
                                ? MenuTile(
                                    label: '${I10n.of(context).top_up} \$',
                                    menuIcon: 'top_up_icon.svg',
                                    onTap: () {
                                      String url = depositPlugins[0].widgetUrl;
                                      if (viewModel.isFuseDollarCommunity) {
                                        openDepositWebview(
                                          context: context,
                                          url: url,
                                        );
                                      } else {
                                        context.router.push(
                                          Webview(
                                            url: url,
                                            title: I10n.of(context).top_up,
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : SizedBox.shrink(),
                            MenuTile(
                              label: I10n.of(context).legal,
                              menuIcon: 'legal_icon.svg',
                              onTap: () {
                                context.router.root.push(
                                  Webview(
                                    title: I10n.of(context).legal,
                                    url: 'https://fuse.cash/privacy',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
