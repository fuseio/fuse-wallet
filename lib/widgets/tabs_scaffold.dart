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
      onWillPop: () {
        return new Future(() => false);
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
