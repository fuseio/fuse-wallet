import 'package:flutter/material.dart';
import 'package:localdolarmx/screens/pro_mode/bottombar.dart';
import 'package:flutter/services.dart';
import 'package:localdolarmx/screens/pro_mode/pro_drawer.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold(
      {this.title,
      this.header,
      this.children,
      this.key,
      this.showFooter,
      this.isProMode});
  final String title;
  final Widget header;
  final List<Widget> children;
  final Key key;
  final bool showFooter;
  final bool isProMode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(isProMode
        ? SystemUiOverlayStyle.light
            .copyWith(statusBarIconBrightness: Brightness.light)
        : SystemUiOverlayStyle.dark
            .copyWith(statusBarIconBrightness: Brightness.dark));

    return Scaffold(
        key: key,
        drawer: DrawerWidget(),
        drawerEdgeDragWidth: 0,
        appBar: header != null
            ? new PreferredSize(
                child: header,
                preferredSize:
                    new Size(MediaQuery.of(context).size.width, 350.0))
            : null,
        body: Column(children: <Widget>[
          Expanded(child: ListView(children: children)),
          bottomBar(context)
        ]));
  }
}
