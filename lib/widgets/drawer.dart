import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'dart:core';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/screens/cash_home/deposit_webview.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/widgets/language-selector.dart';
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
  bool isForked = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isForked = DotEnv().env['FORK'] == 'true';
    });
    print(isForked);
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

  List<Widget> menuItem(viewModel){
    if (isFork()) {
      return [
      getListTile(I18n.of(context).backup_wallet, () {
        Navigator.pushNamed(context, '/Backup1');
      })
    ];
    } else {
      return [
        getListTile(I18n.of(context).switch_community, () {
          Navigator.pushNamed(context, '/Switch');
        }),
        //Divider(),
        getListTile(I18n.of(context).protect_wallet, () {}),
        //Divider(),
        getListTile(I18n.of(context).backup_wallet, () {
          Navigator.pushNamed(context, '/Backup1');
        }),
        getListTile(I18n.of(context).about, () {
          Navigator.pushNamed(context, '/About');
        }),
        new LanguageSelector(),
        //Divider(),
        getListTile(I18n.of(context).logout, () {
          viewModel.logout();
          Navigator.popUntil(context, ModalRoute.withName('/'));
          Navigator.pushNamed(context, '/');
        })
      ];
    }
  }

  @override
  Widget build(BuildContext _context) {
    return Drawer(
      child: new StoreConnector<AppState, DrawerViewModel>(
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          List depositPlugins = viewModel.plugins.getDepositPlugins();
          dynamic widgets = <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
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
                          child: Text(
                            viewModel.firstName(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
            ),
            ...menuItem(viewModel),
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
                                I18n.of(context).top_up,
                                style: TextStyle(
                                    color: Color(0xFF6E6E6E), fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
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
                    padding: EdgeInsets.all(10),
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
  final Function() firstName;

  DrawerViewModel(
      {this.logout, this.walletStatus, this.plugins, this.walletAddress, this.firstName});

  static DrawerViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return DrawerViewModel(
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
