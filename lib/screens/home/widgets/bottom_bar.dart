import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esol/constans/keys.dart';
import 'package:esol/generated/i18n.dart';

class BottomBar extends StatelessWidget {
  final int tabIndex;
  final void Function(int) onTap;
  BottomBar({Key key, this.tabIndex = 0, this.onTap}) : super(key: key);

  BottomNavigationBarItem bottomBarItem(context, String title, String imgSvg) =>
      BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 3),
            child: SvgPicture.asset(
              'assets/images/$imgSvg\.svg',
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: 5, bottom: 3),
            child: SvgPicture.asset(
              'assets/images/$imgSvg\_selected.svg',
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(title,
                style: TextStyle(fontSize: 13.0, color: Color(0xFF292929))),
          ));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          key: AppKeys.bottomBarKey,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          currentIndex: tabIndex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          showUnselectedLabels: true,
          items: [
            bottomBarItem(context, I18n.of(context).home, 'home'),
            bottomBarItem(context, I18n.of(context).send_button, 'send'),
            bottomBarItem(context, I18n.of(context).buy, 'buy'),
            bottomBarItem(context, I18n.of(context).receive, 'receive'),
          ],
          onTap: onTap,
        ));
  }
}
