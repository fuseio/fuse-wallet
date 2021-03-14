import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/drawer.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';
import 'package:fusecash/widgets/language_selector.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  Widget getListTile(
    String label,
    void Function() onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget build(BuildContext context) {
    return MyScaffold(
      title: I18n.of(context).settings,
      body: StoreConnector<AppState, DrawerViewModel>(
        distinct: true,
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          getListTile(I18n.of(context).about, () {
                            ExtendedNavigator.named('homeRouter')
                                .pushAboutScreen();
                          }),
                          Divider(),
                          getListTile(I18n.of(context).protect_wallet, () {
                            ExtendedNavigator.named('homeRouter')
                                .pushProtectYourWallet();
                          }),
                          Divider(),
                          LanguageSelector(),
                          Divider(),
                          getListTile(I18n.of(context).logout, () {
                            viewModel.logout();
                            ExtendedNavigator.root.replace(Routes.splashScreen);
                          })
                        ],
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
