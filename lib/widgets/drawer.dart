import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/screens/cash_home/deposit_webview.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key, this.title}) : super(key: key);

  final String title;

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

  @override
  void dispose() {
    super.dispose();
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
    List depositPlugins = viewModel?.plugins?.getDepositPlugins();
    if (depositPlugins.isNotEmpty) {
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
                I18n.of(context).top_up,
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
                builder: (context) =>
                    DepositWebView(depositPlugin: depositPlugins[0])),
          );
        },
      ));
    }

    return plugins;
  }

  List<Widget> menuItem(DrawerViewModel viewModel) {
    if (isFork() || isPaywise(viewModel.communityAddress)) {
      return [
        getListTile(I18n.of(context).backup_wallet, () {
          Navigator.pushNamed(context, '/Backup1');
        }, icon: 'backup_icon.svg'),
        getListTile(I18n.of(context).settings, () {
          Navigator.pushNamed(context, '/Settings');
        }, icon: 'settings_icon.svg'),
      ];
    } else {
      return [
        getListTile(I18n.of(context).switch_community, () {
          Navigator.pushNamed(context, '/Switch');
        }, icon: 'switch_icon.svg'),
        getListTile(I18n.of(context).backup_wallet, () {
          Navigator.pushNamed(context, '/Backup1');
        }, icon: 'backup_icon.svg'),
        getListTile(I18n.of(context).settings, () {
          Navigator.pushNamed(context, '/Settings');
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
                            viewModel.firstName(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.normal),
                          ),
                          Row(
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
                              ),
                              // SvgPicture.asset(
                              //   'assets/images/header_arrow.svg',
                              //   width: 20,
                              //   height: 20,
                              // )
                            ],
                          )
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

  @override
  Widget build(BuildContext _context) {
    return Drawer(
      child: new StoreConnector<AppState, DrawerViewModel>(
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return Builder(
              builder: (context) => ListView(
                    padding: EdgeInsets.all(10),
                    children: <Widget>[
                      drawerHeader(viewModel),
                      ...menuItem(viewModel),
                      ...pluginsItems(viewModel),
                    ],
                  ));
        },
      ),
    );
  }
}

class DrawerViewModel {
  final Function() logout;
  final String walletStatus;
  final String walletAddress;
  final String communityAddress;
  final Plugins plugins;
  final Function() firstName;

  DrawerViewModel(
      {this.logout,
      this.walletStatus,
      this.plugins,
      this.walletAddress,
      this.firstName,
      this.communityAddress});

  static DrawerViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return DrawerViewModel(
        communityAddress: communityAddress,
        walletAddress: store.state.cashWalletState.walletAddress,
        plugins: community?.plugins,
        walletStatus: store.state.cashWalletState.walletStatus,
        logout: () {
          store.dispatch(logoutCall());
        },
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }
}
