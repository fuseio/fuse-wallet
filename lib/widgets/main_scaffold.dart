import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold(
      {this.title,
      List<Widget> actions,
      List<Widget> children,
      List<Widget> sliverList,
      double titleFontSize,
      bool automaticallyImplyLeading,
      this.key,
      this.footer,
      this.withPadding,
      this.backgroundColor,
      this.expandedHeight})
      : sliverList = sliverList ?? new List<Widget>(),
        children = children ?? new List<Widget>(),
        titleFontSize = titleFontSize ?? 15,
        automaticallyImplyLeading = automaticallyImplyLeading ?? true,
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
  final bool automaticallyImplyLeading;

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      expandedHeight: expandedHeight ?? MediaQuery.of(context).size.height / 8,
      pinned: true,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          child: Text(title,
              softWrap: true,
              style: TextStyle(
                  color: Theme.of(context).textTheme.body1.color,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w800)),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
      ),
      iconTheme: IconThemeData(color: Theme.of(context).textTheme.body1.color),
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      brightness: Brightness.light,
    );
  }

  scrollView(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        appBar(context),
        ...sliverList,
        SliverList(
          delegate: SliverChildListDelegate(children),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
