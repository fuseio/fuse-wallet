import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/drawer.dart';
import 'package:fusecash/screens/misc/about.dart';
import 'package:fusecash/screens/misc/protect_your_wallet.dart';
import 'package:fusecash/screens/splash/splash.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/widgets/language_selector.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

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
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AboutScreen()));
        }),
      ];
    } else {
      return [
        getListTile(context, I18n.of(context).about, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AboutScreen()));
        }),
        new Divider(),
        getListTile(context, I18n.of(context).protect_wallet, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => ProtectYourWallet()));
        }),
        new Divider(),
        new LanguageSelector(),
        new Divider(),
        getListTile(context, I18n.of(context).logout, () {
          viewModel.logout();
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => SplashScreen()));
        })
      ];
    }
  }

  Widget build(BuildContext context) {
    return new StoreConnector<AppState, DrawerViewModel>(
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
