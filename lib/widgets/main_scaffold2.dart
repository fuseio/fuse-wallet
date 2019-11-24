import 'package:flutter/material.dart';
import 'package:fusecash/widgets/drawer.dart';

import 'bottombar.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({this.title, this.children, this.key});
  final String title;
  final List<Widget> children;
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).canvasColor,
      drawer: DrawerWidget(),
      body: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(children: children)
                    ),
                     bottomBar(context)
                     ]
      )
    );
  }
}