import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'dart:core';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

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
      title: Text(
        label,
        style: TextStyle(fontSize: 18),
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
          dynamic widgets = <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                   //Padding(
                   //  padding: EdgeInsets.only(top: 10, bottom: 15),
                   //  child:
                   //      Image.asset('assets/images/anom.png', width: 70),
                   //),
                   //Text(
                   //  "Hello",
                   //  style: TextStyle(
                   //      color: const Color(0xFF787878), fontSize: 50),
                   //)
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))
              ),
            ),
            getListTile("Switch community", () {
              Navigator.pushNamed(context, '/Switch');
            }),
            //Divider(),
            getListTile("Protect your wallet", () {
              
            }),
            //Divider(),
            getListTile("Back up wallet", () {
              
            }),
            //Divider(),
            getListTile("Log out", () {
              viewModel.logout();
                Navigator.popUntil(context, ModalRoute.withName('/'));
                Navigator.pushNamed(context, '/');
            }),
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

  DrawerViewModel({this.logout});

  static DrawerViewModel fromStore(Store<AppState> store) {
    return DrawerViewModel(logout: () {
      store.dispatch(logoutCall());
    });
  }
}
