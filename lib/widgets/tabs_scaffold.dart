import 'package:flutter/material.dart';

class TabsScaffold extends StatefulWidget {
  final Widget drawer;
  final double drawerEdgeDragWidth;
  final PreferredSizeWidget header;
  final Widget bottomNavigationBar;
  final List<Widget> pages;
  final int currentIndex;
  TabsScaffold(
      {Key key,
      @required this.drawer,
      @required this.drawerEdgeDragWidth,
      @required this.header,
      @required this.bottomNavigationBar,
      @required this.pages,
      @required this.currentIndex})
      : super(key: key);

  @override
  _TabsScaffoldState createState() => _TabsScaffoldState();
}

class _TabsScaffoldState extends State<TabsScaffold> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to exit?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: Scaffold(
          key: widget.key,
          drawer: widget.drawer,
          drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
          appBar: widget.currentIndex != 0 ? null : widget.header,
          bottomNavigationBar: widget.bottomNavigationBar,
          body: widget.pages[widget.currentIndex]),
    );
  }
}
