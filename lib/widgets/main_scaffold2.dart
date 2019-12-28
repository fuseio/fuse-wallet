import 'package:flutter/material.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:flutter/services.dart';
import 'bottombar.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({this.title, this.header, this.children, this.key});
  final String title;
  final Widget header;
  final List<Widget> children;
  final Key key;

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark
    ));

    return Scaffold(
        key: key,
        //backgroundColor: Colors.white,
        drawer: DrawerWidget(),
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

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: new Text(
          title,
          style: new TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
