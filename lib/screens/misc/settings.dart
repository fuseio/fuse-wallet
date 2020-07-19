import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/drawer.dart';
import 'package:fusecash/screens/home/router/home_router.gr.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/widgets/language_selector.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:fusecash/screens/routes.gr.dart';

class SettingsScreen extends StatelessWidget {
  Widget getListTile(context, label, onTap) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
      title: Text(
        label,
        style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
      ),
      onTap: onTap,
    );
  }

  List<Widget> menuItem(context, DrawerViewModel viewModel) {
    if (isFork()) {
      return [
        getListTile(context, I18n.of(context).about, () {
          ExtendedNavigator.byName('homeRouter')
              .pushNamed(HomeRoutes.aboutScreen);
        }),
      ];
    } else {
      return [
        getListTile(context, I18n.of(context).about, () {
          ExtendedNavigator.byName('homeRouter')
              .pushNamed(HomeRoutes.aboutScreen);
        }),
        Divider(),
        getListTile(context, I18n.of(context).protect_wallet, () {
          ExtendedNavigator.byName('homeRouter')
              .pushNamed(HomeRoutes.protectYourWallet);
        }),
        Divider(),
        LanguageSelector(),
        Divider(),
        getListTile(context, I18n.of(context).logout, () {
          viewModel.logout();
          ExtendedNavigator.root.pushReplacementNamed(Routes.splashScreen);
        })
      ];
    }
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, DrawerViewModel>(
        distinct: true,
        onInit: (store) {
          Segment.screen(screenName: '/settings-screen');
        },
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).settings,
            withPadding: true,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        children: <Widget>[...menuItem(context, viewModel)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
