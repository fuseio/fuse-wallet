import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/common/di/package_info.dart';
import 'package:supervecina/features/account/widgets/menu_tile.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/redux/viewsmodels/settings.dart';
import 'package:supervecina/features/shared/widgets/language_selector.dart';
import 'package:supervecina/common/router/routes.dart';
import 'package:supervecina/features/shared/widgets/my_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).settings,
      body: StoreConnector<AppState, SettingsViewModel>(
        distinct: true,
        converter: SettingsViewModel.fromStore,
        builder: (_, viewModel) => Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              LanguageSelector(),
              Divider(),
              MenuTile(
                label: I10n.of(context).version,
                menuIcon: 'app_version.svg',
                trailing: Text(
                  "${packageInfo.version} ${(packageInfo.buildNumber)}",
                  style: TextStyle(color: Color(0xFF7E7E7E)),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                onTap: () {
                  viewModel.logout();
                  context.router.replace(OnBoardScreen());
                },
                title: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/log-out.svg',
                      width: 15,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      I10n.of(context).logout,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
