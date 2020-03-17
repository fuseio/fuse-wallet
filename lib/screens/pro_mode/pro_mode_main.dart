import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/bottom_bar.dart';
import 'package:fusecash/screens/pro_mode/pro_drawer.dart';
import 'package:fusecash/screens/pro_mode/pro_header.dart';
import 'package:fusecash/screens/pro_mode/pro_mode.dart';
import 'package:flutter/services.dart';
import 'package:fusecash/widgets/coming_soon.dart';
// import 'package:fusecash/screens/pro_routes.gr.dart';

class ProModeScaffold extends StatefulWidget {
  // ProModeScaffold({Key key}) : super(key: key);
  @override
  _ProModeScaffoldState createState() => _ProModeScaffoldState();
}

class _ProModeScaffoldState extends State<ProModeScaffold> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    ProModeHomeScreen(),
  ];

  BottomNavigationBarItem bottomBarItem(title, img) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 5),
          child: SvgPicture.asset('assets/images/$img\.svg'),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.only(top: 5),
          child: SvgPicture.asset('assets/images/$img\_selected.svg'),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: new Text(title,
              style: new TextStyle(
                  fontSize: 13.0, color: const Color(0xFF292929))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.light));

    return new StoreConnector<AppState, BottomBarViewModel>(
        converter: BottomBarViewModel.fromStore,
        builder: (_, vm) {
          return Scaffold(
              key: widget.key,
              drawer: DrawerWidget(),
              drawerEdgeDragWidth: 0,
              appBar: _currentIndex != 0
                  ? null
                  : new PreferredSize(
                      child: ProHeader(),
                      preferredSize:
                          new Size(MediaQuery.of(context).size.width, 350.0)),
              bottomNavigationBar: BottomNavigationBar(
              onTap: (int itemIndex) {
                  if (itemIndex != 0) {
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
              ),
              body: _pages[_currentIndex]);
        });
  }
}
