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
      Widget footer,
      bool withPadding,
      double padding,
      this.key,
      this.backgroundColor,
      this.expandedHeight})
      : sliverList = sliverList ?? new List<Widget>(),
        children = children ?? new List<Widget>(),
        titleFontSize = titleFontSize ?? 15,
        automaticallyImplyLeading = automaticallyImplyLeading ?? true,
        footer = footer ?? Container(),
        padding = padding ?? 40.0,
        withPadding = withPadding ?? false,
        actions = actions ?? new List<Widget>();

  final String title;
  final List<Widget> children;
  final List<Widget> sliverList;
  final Widget footer;
  final bool withPadding;
  final double padding;
  final Key key;
  final Color backgroundColor;
  final double expandedHeight;
  final double titleFontSize;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      expandedHeight:
          expandedHeight ?? MediaQuery.of(context).size.height / 9.5,
      pinned: true,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          child: Text(title,
              softWrap: true,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w800)),
        ),
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
      ),
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      brightness: Brightness.light,
    );
  }

  CustomScrollView scrollView(BuildContext context) {
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
    return Container(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: scrollView(context)),
                ],
              ),
              Positioned(
                bottom: withPadding ? padding : 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: footer,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
