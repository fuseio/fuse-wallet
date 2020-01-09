import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'dart:core';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/screens/cash_home/deposit_webview.dart';
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

  Widget getListTile(label, onTap) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 30),
      title: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext _context) {
    return Drawer(
      child: new StoreConnector<AppState, DrawerViewModel>(
        converter: (store) {
          return DrawerViewModel.fromStore(store);
        },
        builder: (_, viewModel) {
          List depositPlugins = viewModel.plugins.getDepositPlugins();
          dynamic widgets = <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(top: 10, bottom: 15),
                  //   child: Text(
                  //     "Menu",
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontSize: 22,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
            ),
            getListTile("Switch community", () {
              Navigator.pushNamed(context, '/Switch');
            }),
            //Divider(),
            getListTile("Protect your wallet", () {}),
            //Divider(),
            getListTile("Back up wallet", () {
              Navigator.pushNamed(context, '/Backup1');
            }),
            //Divider(),
            getListTile("Log out", () {
              viewModel.logout();
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.pushNamed(context, '/');
            }),
            depositPlugins.isNotEmpty
                ? Column(
                      children: <Widget>[
                        new Divider(),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10, left: 30),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Color(0xFFFFFFFF),
                                radius: 7,
                                backgroundImage:
                                    new AssetImage('assets/images/top-up.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  'Top up',
                                  style: TextStyle(
                                      color: Color(0xFF6E6E6E), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                    // Padding(
                    // padding: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                    // child: ,
                  // )
                : SizedBox.shrink(),
            ...depositPlugins.map((
              plugin,
            ) {
              if (plugin.isActive) {
                return getListTile('${capitalize(plugin.name)}', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DepositWebView(depositPlugin: plugin)),
                  );
                });
              }
              return SizedBox.shrink();
            }).toList(),
          ];

          return Builder(
              builder: (context) => ListView(
                    padding: EdgeInsets.zero,
                    children: widgets,
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
  final Plugins plugins;

  DrawerViewModel(
      {this.logout, this.walletStatus, this.plugins, this.walletAddress});

  static DrawerViewModel fromStore(Store<AppState> store) {
    return DrawerViewModel(
        walletAddress: store.state.cashWalletState.walletAddress,
        plugins: store.state.cashWalletState.plugins,
        walletStatus: store.state.cashWalletState.walletStatus,
        logout: () {
          store.dispatch(logoutCall());
        });
  }
}
