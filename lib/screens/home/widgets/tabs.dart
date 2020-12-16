import 'package:esol/screens/home/widgets/assets_list.dart';
import 'package:esol/screens/home/widgets/feed.dart';
import 'package:esol/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

final List<String> tabsTitles = ['Feed', 'Wallet'];

class Tabs extends StatefulWidget {
  const Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Container(
        child: Builder(
          builder: (BuildContext context) => Scaffold(
            appBar: MyAppBar(
              backgroundColor: Theme.of(context).splashColor,
              child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    color: Theme.of(context).splashColor,
                    child: TabBar(
                      indicator: BoxDecoration(color: Colors.white),
                      onTap: (int index) {
                        setState(() {});
                      },
                      unselectedLabelStyle: TextStyle(
                          backgroundColor: Theme.of(context).splashColor),
                      tabs: tabsTitles.asMap().entries.map((title) {
                        final int index =
                            DefaultTabController.of(context).index;
                        final bool isSeleceted =
                            index != null ? title.key == index : false;
                        return Chip(
                          labelPadding: EdgeInsets.only(
                              top: 2, bottom: 2, right: 50, left: 50),
                          label: Text(title.value),
                          shadowColor: Theme.of(context).splashColor,
                          backgroundColor: isSeleceted
                              ? Color(0xFFF2F2F2)
                              : Theme.of(context).splashColor,
                        );
                      }).toList(),
                    ),
                  )),
            ),
            body: TabBarView(
              children: [
                Feed(
                  withTitle: false,
                ),
                AssetsList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
