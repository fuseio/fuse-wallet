import 'package:flutter/material.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/screens/pro_mode/pro_drawer.dart';
import 'package:supervecina/screens/pro_mode/pro_header.dart';
import 'package:supervecina/screens/pro_mode/pro_home.dart';
import 'package:supervecina/screens/send/receive.dart';
import 'package:supervecina/widgets/bottom_bar_item.dart';
import 'package:supervecina/widgets/coming_soon.dart';
import 'package:supervecina/widgets/my_app_bar.dart';
import 'package:supervecina/widgets/tabs_scaffold.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ProModeScaffold extends StatefulWidget {
  @override
  _ProModeScaffoldState createState() => _ProModeScaffoldState();
}

class _ProModeScaffoldState extends State<ProModeScaffold> {
  int _currentIndex = 0;

  RateMyApp rateMyApp;

  @override
  void initState() {
    super.initState();
    rateMyApp = RateMyApp(
      minDays: 0,
      minLaunches: 0,
      googlePlayIdentifier: 'io.fuse.supervecina',
      appStoreIdentifier: '1491783654',
    );
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          rateMyApp.showStarRateDialog(
            context,
            title: 'Rate this app',
            message:
                'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
            actionsBuilder: (_, stars) {
              return [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () async {
                    print('Thanks for the ' +
                        (stars == null ? '0' : stars.round().toString()) +
                        ' star(s) !');
                    await rateMyApp
                        .callEvent(RateMyAppEventType.rateButtonPressed);
                    Navigator.pop<RateMyAppDialogButton>(
                        context, RateMyAppDialogButton.rate);
                  },
                ),
              ];
            },
            ignoreIOS: false,
            dialogStyle: DialogStyle(
              titleAlign: TextAlign.center,
              dialogShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
            starRatingOptions: StarRatingOptions(),
            onDismissed: () =>
                rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
          );
        });
      }
    });
  }

  List<Widget> _pages = [
    ProModeHomeScreen(),
    Container(),
    Container(),
    ReceiveScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return TabsScaffold(
        header: MyAppBar(child: ProHeader(), backgroundColor: Colors.red),
        drawerEdgeDragWidth: 0,
        pages: _pages,
        currentIndex: _currentIndex,
        drawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int itemIndex) {
            if (itemIndex != 0 && itemIndex != 3) {
              comingSoon(context);
              return;
            } else {
              setState(() {
                _currentIndex = itemIndex;
              });
            }
          },
          selectedFontSize: 13,
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          showUnselectedLabels: true,
          items: [
            bottomBarItem(I18n.of(context).home, 'home'),
            bottomBarItem(I18n.of(context).send_button, 'send'),
            bottomBarItem(I18n.of(context).trade, 'trade'),
            bottomBarItem(I18n.of(context).receive, 'receive'),
          ],
        ));
  }
}
