import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';

import '../common.dart';

Widget bottomBar(context) {
  return new Container(
    padding: EdgeInsets.only(
        top: 0.0, bottom: isIPhoneX() ? 16 : 0, right: 0.0, left: 0.0),
    color: const Color(0xFFFFFFFF),
    child: new Directionality(
      textDirection: TextDirection.rtl,
      child: new Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          bottomBarItem("arrow-down.png", "Send", () {
            //openPage(context, new SendAmountPage());
          }),
          bottomBarItem("buy.png", "Buy", () {
            //openPage(context, new BuyPage());
          }),
          bottomBarItem("arrow-up.png", "Discover", () {
            //openPage(context, new ReceivePage());
          })
        ],
      ),
    ),
  );
}

Widget bottomBarItem(String img, String text, ontap) {
  return new Material(
    color: Colors.transparent,
    child: new InkWell(
      borderRadius: BorderRadius.all(new Radius.circular(30.0)),
      child: new Container(
        width: 100,
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 0.0, left: 0.0),
        child: new Column(
          children: <Widget>[
            Image.asset('assets/images/' + img, width: 28.0, color: const Color(0xFF979797)),
            new Text(text,
                style: new TextStyle(
                    fontSize: 14.0, color: const Color(0xFF979797)))
          ],
        ),
      ),
      onTap: ontap,
    ),
  );
}