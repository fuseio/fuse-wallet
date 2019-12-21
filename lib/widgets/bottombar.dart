import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';

import '../common.dart';

Widget bottomBar(context) {
  return new Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF8F8F8),
          border: Border(top: BorderSide(color: Color(0xFFE8E8E8)))
          ),
    padding: EdgeInsets.only(
        top: 8, bottom: isIPhoneX() ? 16 : 4, right: 0.0, left: 0.0,),
    //color: const Color(0xFFF8F8F8),
    child: new Directionality(
      textDirection: TextDirection.rtl,
      child: new Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          bottomBarItem("arrow-down.png", "Receive", () {
            Navigator.pushNamed(context, '/Receive');
            //openPage(context, new SendAmountPage());
          }),
          bottomBarItem("buy.png", "Buy", () {
            //openPage(context, new BuyPage());
          }),
          bottomBarItem("arrow-up.png", "Send", () {
            Navigator.pushNamed(context, '/SendContact');
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
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/' + img, width: 20.0, color: const Color(0xFFC4C4C4)),
            )
            ,
            new Text(text,
                style: new TextStyle(
                    fontSize: 16.0, color: const Color(0xFF292929)))
          ],
        ),
      ),
      onTap: ontap,
    ),
  );
}