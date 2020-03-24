import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localpay/generated/i18n.dart';
import 'package:localpay/models/app_state.dart';
import 'package:localpay/models/views/drawer.dart';
import 'package:localpay/screens/routes.gr.dart';
import 'package:localpay/utils/forks.dart';
import 'package:localpay/widgets/language_selector.dart';
import 'package:localpay/widgets/main_scaffold.dart';

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

  List<Widget> menuItem(context, viewModel) {
    if (isFork()) {
      return [
        getListTile(context, I18n.of(context).about, () {
          Router.navigator.pushNamed(Router.aboutScreen);
        }),
      ];
    } else {
      return [
        getListTile(context, I18n.of(context).about, () {
          Router.navigator.pushNamed(Router.aboutScreen);
        }),
        new Divider(),
        // getListTile(context, I18n.of(context).protect_wallet, () {}),
        // new Divider(),
        new LanguageSelector(),
        new Divider(),
        getListTile(context, I18n.of(context).logout, () {
          Router.navigator.pushNamedAndRemoveUntil(Router.splashScreen, (Route<dynamic> route) => false);
          viewModel.logout();
        })
      ];
    }
  }

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DrawerViewModel>(
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return MainScaffold(
            title: I18n.of(context).settings,
            titleFontSize: 15,
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
