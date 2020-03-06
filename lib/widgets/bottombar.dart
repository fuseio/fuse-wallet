import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paywise/common.dart';
import 'package:paywise/generated/i18n.dart';
import 'package:paywise/screens/routes.gr.dart';

isCurrentRoute(BuildContext context, String route) {
  String currentRoute = ModalRoute.of(context).settings.name;
  return currentRoute == route;
}

Widget bottomBar(BuildContext context) {
  bool isHomePage = isCurrentRoute(context, '/Cash');
  return Hero(
    tag: "footerNav",
    child: new Container(
      decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          border: Border(top: BorderSide(color: Color(0xFFE8E8E8)))),
      padding: EdgeInsets.only(
        top: 8,
        bottom: isIPhoneX() ? 16 : 4,
        right: 0.0,
        left: 0.0,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          bottomBarItem(
              isCurrentRoute(context, Router.cashHomeScreen)
                  ? "home_selected.svg"
                  : "home.svg",
              I18n.of(context).home, () {
            if (isHomePage) {
              redirect(context, Router.cashHomeScreen);
            } else {
              Router.navigator
                  .popUntil(ModalRoute.withName(Router.cashHomeScreen));
              redirect(context, Router.cashHomeScreen);
            }
          }),
          bottomBarItem(
              isCurrentRoute(context, Router.sendToContactScreen)
                  ? "send_selected.svg"
                  : "send.svg",
              I18n.of(context).send_button, () {
            if (isHomePage) {
              redirect(context, Router.sendToContactScreen);
            } else {
              Router.navigator
                  .popUntil(ModalRoute.withName(Router.cashHomeScreen));
              redirect(context, Router.sendToContactScreen);
            }
          }),
          bottomBarItem(
              isCurrentRoute(context, Router.buyScreen)
                  ? "buy_selected.svg"
                  : "buy.svg",
              I18n.of(context).buy, () {
            if (isHomePage) {
              redirect(context, Router.buyScreen);
            } else {
              Router.navigator
                  .popUntil(ModalRoute.withName(Router.cashHomeScreen));
              redirect(context, Router.buyScreen);
            }
          }),
          bottomBarItem(
              isCurrentRoute(context, Router.receiveScreen)
                  ? "receive_selected.svg"
                  : "receive.svg",
              I18n.of(context).receive, () {
            if (isHomePage) {
              redirect(context, Router.receiveScreen);
            } else {
              Router.navigator
                  .popUntil(ModalRoute.withName(Router.cashHomeScreen));
              redirect(context, Router.receiveScreen);
            }
          })
        ],
      ),
    ),
  );
}

void redirect(BuildContext context, String screen) {
  Router.navigator.popUntil((route) {
    if (route.settings.name != screen) {
      Router.navigator.pushNamed(screen);
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
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: SvgPicture.asset('assets/images/' '$img'),
            ),
            new Text(text,
                style: new TextStyle(
                    fontSize: 13.0, color: const Color(0xFF292929)))
          ],
        ),
      ),
      onTap: ontap,
    ),
  );
}
