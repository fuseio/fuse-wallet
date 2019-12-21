import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({this.title, this.children, this.sliverList, this.key, this.footer});
  final String title;
  final List<Widget> children;
  final List<Widget> sliverList;
  final Widget footer;
  final Key key;

  scrollView(context) {
    return CustomScrollView(
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
          iconTheme:
              IconThemeData(color: Theme.of(context).textTheme.body1.color),
          backgroundColor: Color(0xFFF5F5F5),
        ),
        //sliverList != null ? sliverList : Container(),
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: scrollView(context)),
          footer == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 40), child: footer)
        ],
      ),
    );
  }
}
