import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'dart:core';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    child:
                        Image.asset('images/avatar.png', width: 70),
                  ),
                  Text(
                    "Mark Smargon",
                    style: TextStyle(
                        color: const Color(0xFF787878), fontSize: 16),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
            ),
            ListTile(
              title: Text(
                'Switch community',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Protect your wallet',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Back up wallet',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Fuse studio',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Log out',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                viewModel.logout();
              },
            ),
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


  DrawerViewModel({
    this.logout
  });

  static DrawerViewModel fromStore(Store<AppState> store) {
    return DrawerViewModel(
      logout: () {
      }
    );
  }
}
