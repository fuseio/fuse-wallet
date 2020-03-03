import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/common.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/bottom_bar.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';

isCurrentRoute(BuildContext context, String route) {
  String currentRoute = ModalRoute.of(context).settings.name;
  return currentRoute == route;
}

Widget bottomBar(BuildContext context) {
  bool isHomePage = isCurrentRoute(context, '/Cash');
  return new StoreConnector<AppState, BottomBarViewModel>(
      converter: BottomBarViewModel.fromStore,
      builder: (_, viewModel) {
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
              children: <Widget>[
                bottomBarItem(
                    isCurrentRoute(context, '/Cash')
                        ? "home_selected.svg"
                        : "home.svg",
                    I18n.of(context).wallet, () {
                  if (isHomePage) {
                    redirect(context, '/Cash');
                  } else {
                    Navigator.pop(context, ModalRoute.withName('/Cash'));
                    redirect(context, '/Cash');
                  }
                }),
                bottomBarItem(
                    isCurrentRoute(context, '/Home')
                        ? "home_selected.svg"
                        : "home.svg",
                    'Your Home', () {
                  if (isHomePage) {
                    redirect(context, '/Home',
                        arguments: WebViewPageArguments(
                            url:
                                'https://app.roostnow.co.uk/home?wallet=${viewModel.walletAddress}',
                            title: 'Your Home'));
                  } else {
                    Navigator.pop(context, ModalRoute.withName('/Cash'));
                    redirect(context, '/Home',
                        arguments: WebViewPageArguments(
                            url:
                                'https://app.roostnow.co.uk/home?wallet=${viewModel.walletAddress}',
                            title: 'Your Home'));
                  }
                }),
                bottomBarItem(
                    isCurrentRoute(context, '/Buy')
                        ? "buy_selected.svg"
                        : "buy.svg",
                    'Pay Rent', () {
                  if (isHomePage) {
                    redirect(context, '/Buy');
                  } else {
                    Navigator.popUntil(context, ModalRoute.withName('/Cash'));
                    redirect(context, '/Buy');
                  }
                }),
                // bottomBarItem(
                //     isCurrentRoute(context, '/SendContact')
                //         ? "send_selected.svg"
                //         : "send.svg",
                //     I18n.of(context).send_button, () {
                //   if (isHomePage) {
                //     redirect(context, '/SendContact');
                //   } else {
                //     Navigator.pop(context, ModalRoute.withName('/Cash'));
                //     redirect(context, '/SendContact');
                //   }
                // }),
              ],
            ),
          ),
        );
      });
}

void redirect(BuildContext context, String screen, {dynamic arguments}) {
  Navigator.popUntil(context, (route) {
    if (route.settings.name != screen) {
      Navigator.pushNamed(context, screen, arguments: arguments);
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
