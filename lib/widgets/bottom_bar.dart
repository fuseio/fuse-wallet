import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/generated/i18n.dart';

class BottomBar extends StatelessWidget {
  final int tabIndex;
  final void Function(int) onTap;

  BottomBar({
    Key key,
    this.tabIndex = 0,
    this.onTap,
  }) : super(key: key);

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
            width: 25,
            height: 25,
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
        selectedItemColor: Theme.of(context).colorScheme.onSurface,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        key: AppKeys.bottomBarKey,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
        showUnselectedLabels: true,
        items: [
          bottomBarItem(I18n.of(context).home, 'home'),
          bottomBarItem(I18n.of(context).send_button, 'send'),
          bottomBarItem(I18n.of(context).swap, 'swap'),
          bottomBarItem(I18n.of(context).receive, 'receive'),
        ],
        onTap: onTap,
      ),
    );
  }
}
