import 'package:flutter/material.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                child: Text(title,
              softWrap: true,
              //overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.body1.color,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              //background: Container(
              //color: Theme.of(context).canvasColor,
              //),
            ),
            iconTheme: IconThemeData(color: Theme.of(context).textTheme.body1.color),
            backgroundColor: Theme.of(context).canvasColor,
          ),
          SliverList(
            delegate: SliverChildListDelegate(children),
          )
        ],
      ),
    );
  }
}