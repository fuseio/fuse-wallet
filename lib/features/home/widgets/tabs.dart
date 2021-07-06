import 'package:flutter/material.dart';
import 'package:fusecash/features/home/widgets/feed.dart';
import 'package:fusecash/features/home/widgets/wallet.dart';
import 'package:fusecash/generated/l10n.dart';

class Tabs extends StatelessWidget {
  final int initialIndex;
  const Tabs({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Theme.of(context).canvasColor,
              bottom: PreferredSize(
                preferredSize: Size(
                  MediaQuery.of(context).size.width * .8,
                  70,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TabBar(
                    labelColor: Theme.of(context).colorScheme.onSurface,
                    indicatorColor: Theme.of(context).colorScheme.onSurface,
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 17,
                    ),
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onSurface,
                    labelStyle: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFFF4F4F4),
                    ),
                    tabs: [
                      Tab(
                        text: I10n.of(context).wallet,
                      ),
                      Tab(
                        text: I10n.of(context).feed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 10),
              child: TabBarView(
                children: [
                  Wallet(),
                  Feed(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
