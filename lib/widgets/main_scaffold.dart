import 'package:auto_route/auto_route.dart';
import 'package:esol/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constans/keys.dart';

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
      @required this.drawerIcon,
      @required this.expandedHeight,
      @required this.newHeaderAppBar})
      : sliverList = sliverList ?? new List<Widget>(),
        children = children ?? new List<Widget>(),
        titleFontSize = titleFontSize ?? 15,
        automaticallyImplyLeading = automaticallyImplyLeading ?? true,
        footer = footer ?? SizedBox.shrink(),
        padding = padding ?? 40.0,
        withPadding = withPadding ?? false,
        actions = actions ?? new List<Widget>();

  final Widget title;
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
  final Widget newHeaderAppBar;
  final Widget drawerIcon;

  SliverAppBar appBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      automaticallyImplyLeading: false,
      expandedHeight: expandedHeight,
      pinned: true,
      floating: false,
      actions: actions,
      leading: InkWell(
        onTap: () {
          AppKeys.homePageKey.currentState.openDrawer();
        },
        child: drawerIcon,
      ),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            title: title,
            collapseMode: CollapseMode.none,
            background: MyAppBar(
              child: newHeaderAppBar,
            ),
          );
        },
      ),
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      backgroundColor: backgroundColor ?? Color.fromRGBO(0, 85, 255, 1),
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
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
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
    );
  }
}
