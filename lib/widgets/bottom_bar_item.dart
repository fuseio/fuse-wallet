import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem bottomBarItem(String title, String imgSvg) {
  return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 3),
        child: SvgPicture.asset('assets/images/$imgSvg\.svg'),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 3),
        child: SvgPicture.asset('assets/images/$imgSvg\_selected.svg'),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: new Text(title,
            style:
                new TextStyle(fontSize: 13.0, color: const Color(0xFF292929))),
      ));
}
