import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/features/account/widgets/avatar.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/features/screens/webview_screen.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/account.dart';
import 'package:fusecash/utils/url.dart';
import 'package:fusecash/utils/webview.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
// import 'package:fusecash/features/account/router/router.gr.dart';
import 'package:share/share.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    Segment.screen(screenName: '/account-screen');
    super.initState();
  }

  List<Widget> pluginsItems(AccountViewModel viewModel) {
    List<Widget> plugins = [];
    List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
    if (depositPlugins.isNotEmpty) {
      plugins.add(MenuTile(
        label: '${I10n.of(context).top_up} \$',
        menuIcon: 'top_up_icon.svg',
        onTap: () {
          String url = depositPlugins[0].widgetUrl;
          openDepositWebview(
            context: context,
            withBack: true,
            url: url,
          );
          Segment.track(eventName: 'User clicked on top up');
        },
      ));
    }

    return plugins;
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).account,
      body: StoreConnector<AppState, AccountViewModel>(
        distinct: true,
        converter: AccountViewModel.fromStore,
        builder: (_, viewModel) {
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
                                // context.router
                                //     .navigateNamed('/settings/newSegment');
                              },
                              // onTap: ExtendedNavigator.named('accountRouter')
                              //     .pushSettingsScreen,
                              trailing: SvgPicture.asset(
                                'assets/images/go_to_pro.svg',
                                width: 10,
                                height: 10,
                              ),
                            ),
                            MenuTile(
                              label: I10n.of(context).protect_wallet,
                              menuIcon: 'protect_wallet.svg',
                              onTap: () {
                                context.router.push(ProtectYourWallet());
                              },
                              // onTap: ExtendedNavigator.named('accountRouter')
                              //     .pushProtectYourWallet,
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
                                    child: SvgPicture.asset(
                                      'assets/images/go_to_pro.svg',
                                      width: 10,
                                      height: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ...pluginsItems(viewModel),
                            MenuTile(
                              label: I10n.of(context).social,
                              menuIcon: 'social_icon.svg',
                              onTap: () {
                                context.router.push(SocialScreen());
                              },
                              // onTap: ExtendedNavigator.named('accountRouter')
                              //     .pushSocialScreen,
                              trailing: SvgPicture.asset(
                                'assets/images/go_to_pro.svg',
                                width: 10,
                                height: 10,
                              ),
                            ),
                            MenuTile(
                              label: I10n.of(context).contact_us,
                              menuIcon: 'contact_us_icon.svg',
                              onTap: () {
                                final Uri _emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: 'hello@fuse.io',
                                );
                                launchUrl(_emailLaunchUri.toString());
                              },
                            ),
                            MenuTile(
                              label: I10n.of(context).invite_friend,
                              menuIcon: 'invite_friend_icon.svg',
                              onTap: () {
                                Share.share(
                                  '${I10n.of(context).invite_friend_text} https://app.fuse.cash/NXzV6y1HLfb',
                                );
                              },
                            ),
                            MenuTile(
                              label: I10n.of(context).legal,
                              menuIcon: 'legal_icon.svg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebViewScreen(
                                      'https://fuse.cash/privacy',
                                      I10n.of(context).legal,
                                      withBack: true,
                                    ),
                                    fullscreenDialog: true,
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
