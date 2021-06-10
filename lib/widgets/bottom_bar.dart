import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/l10n.dart';

class BottomBar extends StatelessWidget {
  late final TabsRouter tabsRouter;

  BottomBar(
    this.tabsRouter,
  );

  BottomNavigationBarItem bottomBarItem(
    String title,
    String imgSvg,
  ) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg\.svg',
            width: 25,
            height: 25,
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg\_selected.svg',
            width: 26,
            height: 26,
          ),
        ),
        label: title,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 3.0,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        key: tabsRouter.key,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: [
          bottomBarItem(I10n.of(context).home, 'home'),
          bottomBarItem(I10n.of(context).send_button, 'send'),
          bottomBarItem(I10n.of(context).swap, 'swap'),
          bottomBarItem(I10n.of(context).earn, 'earn'),
          bottomBarItem(I10n.of(context).account, 'account'),
        ],
      ),
    );
  }
}
