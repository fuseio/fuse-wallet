import 'package:flutter/material.dart';

import 'package:fusecash/features/wallet/widgets/collectibles.dart';
import 'package:fusecash/features/wallet/widgets/tokens.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: const Color(0xFFB8B8B8),
              labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                ),
              ),
              tabs: [
                Tab(
                  text: I10n.of(context).coins,
                ),
                Tab(
                  text: I10n.of(context).collectibles,
                ),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                TokensPage(),
                CollectiblesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
