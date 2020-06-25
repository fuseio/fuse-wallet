import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/views/drawer.dart';
import 'package:digitalrand/screens/misc/about.dart';
import 'package:digitalrand/screens/splash/splash.dart';
import 'package:digitalrand/utils/forks.dart';
import 'package:digitalrand/widgets/language_selector.dart';
import 'package:digitalrand/widgets/main_scaffold.dart';

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
        new Divider(),
        getListTile(context, I18n.of(context).logout, () {
          viewModel.logout();
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => SplashScreen()));
        })
      ];
    } else {
      return [
        getListTile(context, I18n.of(context).about, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => AboutScreen()));
        }),
        new Divider(),
        // getListTile(context, I18n.of(context).protect_wallet, () {}),
        // new Divider(),
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
