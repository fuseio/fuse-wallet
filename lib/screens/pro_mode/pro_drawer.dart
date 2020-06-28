import 'dart:core';
import 'package:digitalrand/screens/cash_home/webview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/models/views/drawer.dart';
import 'package:digitalrand/screens/backup/show_mnemonic.dart';
import 'package:digitalrand/screens/misc/settings.dart';
import 'package:digitalrand/utils/forks.dart';
import 'package:digitalrand/utils/format.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final assetIdController = TextEditingController(text: "");
  String userName = "";

  @override
  void initState() {
    super.initState();
  }

  Widget getListTile(label, onTap, {String icon}) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
      title: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/' '$icon',
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  List<Widget> pluginsItems(DrawerViewModel viewModel) {
    List<Widget> plugins = [];
    plugins.add(new Divider(
      color: Color(0xFFCBCBCB),
    ));
    plugins.add(ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
      title: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/top_up.svg',
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              I18n.of(context).deposit,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                  pageArgs: WebViewPageArguments(
                      url: 'https://digitalrand.co.za/deposit.html',
                      title: I18n.of(context).deposit)),
              fullscreenDialog: true),
        );
        Segment.track(eventName: 'User clicked on deposit');
      },
    ));

    return plugins;
  }

  List<Widget> menuItem(DrawerViewModel viewModel) {
    if (isFork()) {
      return [
        getListTile(I18n.of(context).backup_wallet, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => ShowMnemonic()));
        }, icon: 'backup_icon.svg'),
        getListTile(I18n.of(context).settings, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => SettingsScreen()));
        }, icon: 'settings_icon.svg'),
      ];
    } else {
      return [
        getListTile(I18n.of(context).backup_wallet, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => ShowMnemonic()));
        }, icon: 'backup_icon.svg'),
        getListTile(I18n.of(context).settings, () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => SettingsScreen()));
        }, icon: 'settings_icon.svg'),
      ];
    }
  }

  Widget drawerHeader(DrawerViewModel viewModel) {
    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              print('click on account');
            },
            child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15, left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: new AssetImage('assets/images/anom.png'),
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            (viewModel?.firstName() ?? ''),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.normal),
                          ),
                          viewModel.walletAddress != null
                              ? Row(
                                  children: <Widget>[
                                    Text(
                                      formatAddress(viewModel.walletAddress),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
    );
  }

  Widget switchToCashMode(viewModel) {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 50.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColorLight,
                Theme.of(context).primaryColorDark,
              ],
            ),
            color: Theme.of(context).splashColor,
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            border: Border.all(
                color: Theme.of(context).primaryColor.withAlpha(14))),
        child: InkWell(
          onTap: () {
            viewModel.replaceNavigator(false);
          },
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Cash mode',
                      style: TextStyle(
                          color: Theme.of(context).splashColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
                new FloatingActionButton(
                    heroTag: 'pro_scanner',
                    mini: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: SvgPicture.asset(
                      'assets/images/pro_mode_icon.svg',
                      width: 20.0,
                      color: Theme.of(context).splashColor,
                    ),
                    onPressed: () {
                      viewModel.replaceNavigator(false);
                    })
              ]),
        ));
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, DrawerViewModel>(
      converter: DrawerViewModel.fromStore,
      builder: (_, viewModel) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.78,
          child: Drawer(
              child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: <Widget>[
                    drawerHeader(viewModel),
                    ...menuItem(viewModel),
                    ...pluginsItems(viewModel),
                  ],
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    child: switchToCashMode(viewModel),
                    padding: EdgeInsets.all(20),
                  )),
            ],
          )),
        );
      },
    );
  }
}
