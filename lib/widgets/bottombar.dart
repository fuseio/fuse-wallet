import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';

import '../common.dart';

isCurrentRoute(BuildContext context, String route) {
  String currentRoute = ModalRoute.of(context).settings.name;
  return currentRoute == route;
}

Widget bottomBar(BuildContext context) {
  return new Container(
    decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        border: Border(top: BorderSide(color: Color(0xFFE8E8E8)))),
    padding: EdgeInsets.only(
      top: 8,
      bottom: isIPhoneX() ? 16 : 4,
      right: 0.0,
      left: 0.0,
    ),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        bottomBarItem(
            isCurrentRoute(context, '/SendContact')
                ? "send_selected.png"
                : "send.png",
            I18n.of(context).send_button, () {
          redirect(context, '/SendContact');
        }),
        bottomBarItem(
            isCurrentRoute(context, '/Buy') ? "buy_selected.png" : "buy.png",
            I18n.of(context).buy, () {
          redirect(context, '/Buy');
        }),
        bottomBarItem(
            isCurrentRoute(context, '/Receive')
                ? "receive_selected.png"
                : "receive.png",
            I18n.of(context).receive, () {
          redirect(context, '/Receive');
        })
      ],
    ),
  );
}

void redirect(BuildContext context, String screen) {
  Navigator.popUntil(context, (route) {
    if (route.settings.name != screen) {
      Navigator.pushNamed(context, screen);
    }
    return true;
  });
}

Widget bottomBarItem(String img, String text, Function ontap) {
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
              child: Image.asset('assets/images/' + img, width: 20.0),
            ),
            new Text(text,
                style: new TextStyle(
                    fontSize: 15.0, color: const Color(0xFF292929)))
          ],
        ),
      ),
      onTap: ontap,
    ),
  );
}
