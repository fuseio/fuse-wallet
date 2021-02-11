import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class SwapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      automaticallyImplyLeading: false,
      title: I18n.of(context).coming_soon,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF153858),
                        Color(0xFF0A0E13),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/fuseswap_logo.png',
                        width: 181,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset('assets/images/soon.svg'),
                    ],
                  ),
                ),
                Positioned.fill(
                  top: -45,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/swap_logo.png',
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Soon you will be able to swap your Fuse Dollars to other currencies with the best experience in the industry and no gas!')
            ],
          ),
        )
      ],
    );
  }
}
