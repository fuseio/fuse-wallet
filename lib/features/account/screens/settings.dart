import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/common/di/package_info.dart';
import 'package:fusecash/features/account/widgets/menu_tile.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/drawer.dart';
import 'package:fusecash/widgets/language_selector.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/widgets/my_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).settings,
      body: StoreConnector<AppState, DrawerViewModel>(
        distinct: true,
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                LanguageSelector(),
                Divider(),
                MenuTile(
                  label: I10n.of(context).logout,
                  menuIcon: 'log-out.svg',
                  onTap: () {
                    viewModel.logout();
                    ExtendedNavigator.root.replace(Routes.onBoardScreen);
                  },
                ),
                Divider(),
                MenuTile(
                  label: I10n.of(context).version,
                  menuIcon: 'app_version.svg',
                  trailing: Text(
                    "${packageInfo.version} ${(packageInfo.buildNumber)}",
                    style: TextStyle(color: Color(0xFF7E7E7E)),
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
