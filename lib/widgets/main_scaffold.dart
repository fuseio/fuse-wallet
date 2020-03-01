import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold(
      {this.title,
      this.children,
      List<Widget> actions,
      List<Widget> sliverList,
      this.key,
      this.footer,
      this.withPadding,
      this.backgroundColor,
      this.expandedHeight,
      this.titleFontSize})
      : sliverList = sliverList ?? new List<Widget>(),
        actions = actions ?? new List<Widget>();
  final String title;
  final List<Widget> children;
  final List<Widget> sliverList;
  final Widget footer;
  final bool withPadding;
  final Key key;
  final Color backgroundColor;
  final double expandedHeight;
  final double titleFontSize;
  final List<Widget> actions;

  scrollView(context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: expandedHeight ?? MediaQuery.of(context).size.height / 8,
          pinned: true,
          actions: actions,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              child: Text(title,
                  softWrap: true,
                  //overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.body1.color,
                      fontSize: titleFontSize ?? 20,
                      fontWeight: FontWeight.w800)),
            ),
            centerTitle: true,
            collapseMode: CollapseMode.parallax,
            //background: Container(
            //color: Theme.of(context).canvasColor,
            //),
          ),
          iconTheme:
              IconThemeData(color: Theme.of(context).textTheme.body1.color),
          backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
          brightness: Brightness.light,
        ),
        ...sliverList,
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: scrollView(context)),
          footer == null
              ? Container()
              : withPadding
                  ? Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 40),
                      child: footer)
                  : footer
        ],
      ),
    );
  }
}
