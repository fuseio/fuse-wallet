import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localpay/common.dart';
import 'package:localpay/generated/i18n.dart';
import 'package:localpay/models/app_state.dart';
import 'package:localpay/models/views/bottom_bar.dart';
import 'package:localpay/screens/pro_routes.gr.dart';
import 'package:localpay/screens/routes.gr.dart';
import 'package:localpay/widgets/coming_soon.dart';



isCurrentRoute(BuildContext context, String route) {
  String currentRoute = ModalRoute.of(context).settings.name;
  return currentRoute == route;
}

Widget bottomBar(BuildContext context) {
  bool isHomePage = isCurrentRoute(context, ProRouter.proModeHomeScreen);
  return new StoreConnector<AppState, BottomBarViewModel>(
      distinct: true,
      converter: BottomBarViewModel.fromStore,
      builder: (_, viewModel) {
        return Hero(
          tag: "proFooterNav",
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
              children: <Widget>[
                bottomBarItem(
                    isCurrentRoute(context, ProRouter.proModeHomeScreen)
                        ? "home_selected.svg"
                        : "home.svg",
                    I18n.of(context).home, () {
                  if (isHomePage) {
                    redirect(context, ProRouter.proModeHomeScreen);
                  } else {
                    Navigator.pop(context,
                        ModalRoute.withName(ProRouter.proModeHomeScreen));
                    redirect(context, ProRouter.proModeHomeScreen);
                  }
                }),
                bottomBarItem(
                    isCurrentRoute(context, Router.sendToContactScreen)
                        ? "send_selected.svg"
                        : "send.svg",
                    I18n.of(context).send_button, () {
                  comingSoon(context);
                }),
                bottomBarItem(
                    isCurrentRoute(context, Router.daiExplainedScreen)
                        ? "trade_selected.svg"
                        : "trade.svg",
                    I18n.of(context).trade, () {
                  comingSoon(context);
                }),
                bottomBarItem(
                    isCurrentRoute(context, Router.receiveScreen)
                        ? "receive_selected.svg"
                        : "receive.svg",
                    I18n.of(context).receive, () {
                  comingSoon(context);
                })
              ],
            ),
          ),
        );
      });
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
