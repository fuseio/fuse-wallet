import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/screens/cash_home/cash_header.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/cash_home/dai_explained.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:flutter/services.dart';

class CashModeScaffold extends StatefulWidget {
  CashModeScaffold({Key key}) : super(key: key);
  @override
  _CashModeScaffoldState createState() => _CashModeScaffoldState();
}

class _CashModeScaffoldState extends State<CashModeScaffold> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.dark));

    List<Widget> _pages = [
      CashHomeScreen(),
      SendToContactScreen(),
      DaiExplainedScreen(),
      ReceiveScreen()
    ];

    _onTap(int itemIndex) {
      setState(() {
        _currentIndex = itemIndex;
      });
    }

    return Scaffold(
        key: widget.key,
        drawer: DrawerWidget(),
        // drawerEdgeDragWidth: 0,
        appBar: _currentIndex == 0 ? new PreferredSize(
            child: CashHeader(),
            preferredSize: new Size(MediaQuery.of(context).size.width, 350.0)) : null,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset('assets/images/home.svg'),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SvgPicture.asset('assets/images/home_selected.svg'),
                ),
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: new Text(I18n.of(context).home,
                      style: new TextStyle(
                          fontSize: 13.0, color: const Color(0xFF292929))),
                )),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset('assets/images/send.svg'),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset('assets/images/send_selected.svg'),
                ),
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: new Text(I18n.of(context).send_button,
                      style: new TextStyle(
                          fontSize: 13.0, color: const Color(0xFF292929))),
                )),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset('assets/images/daipoints.svg'),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child:
                      SvgPicture.asset('assets/images/daipoints_selected.svg'),
                ),
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: new Text(I18n.of(context).dai_points,
                      style: new TextStyle(
                          fontSize: 13.0, color: const Color(0xFF292929))),
                )),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset('assets/images/receive.svg'),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: SvgPicture.asset('assets/images/receive_selected.svg'),
                ),
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: new Text(I18n.of(context).receive,
                      style: new TextStyle(
                          fontSize: 13.0, color: const Color(0xFF292929))),
                )),
          ],
        ),
        body: _pages[_currentIndex]);
  }
}
