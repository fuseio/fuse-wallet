import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:fusecash/widgets/language_selector.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen();
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
          Navigator.pushNamed(context, '/About');
        }),
      ];
    } else {
      return [
        getListTile(context, I18n.of(context).about, () {
          Navigator.pushNamed(context, '/About');
        }),
        new Divider(),
        // getListTile(context, I18n.of(context).protect_wallet, () {}),
        // new Divider(),
        new LanguageSelector(),
        new Divider(),
        getListTile(context, I18n.of(context).logout, () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
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
