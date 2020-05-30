import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/app_state.dart';
import 'package:roost/models/views/bottom_bar.dart';
import 'package:roost/screens/buy/buy.dart';
import 'package:roost/screens/cash_home/cash_header.dart';
import 'package:roost/screens/cash_home/cash_home.dart';
import 'package:roost/widgets/bottom_bar_item.dart';
import 'package:roost/widgets/drawer.dart';
import 'package:roost/widgets/my_app_bar.dart';
import 'package:roost/widgets/tabs_scaffold.dart';
import 'package:roost/screens/cash_home/webview_page.dart';

class CashModeScaffold extends StatefulWidget {
  final int tabIndex;
  CashModeScaffold({Key key, this.tabIndex = 0}) : super(key: key);
  @override
  _CashModeScaffoldState createState() => _CashModeScaffoldState();
}

class _CashModeScaffoldState extends State<CashModeScaffold> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabIndex;
  }

  List<Widget> _pages(String walletAddress) {
    return [
      CashHomeScreen(),
      WebViewPage(
          pageArgs: WebViewPageArguments(
              withBack: false,
              url: 'https://app.roostnow.co.uk/home?wallet=$walletAddress',
              title: 'Your Home')),
      BuyScreen(),
    ];
  }

  _onTap(int itemIndex) {
    setState(() {
      _currentIndex = itemIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BottomBarViewModel>(
        converter: BottomBarViewModel.fromStore,
        builder: (_, vm) {
          final List<Widget> pages = _pages(vm.walletAddress);
          return TabsScaffold(
              header: MyAppBar(
                height: 230.0,
                backgroundColor: Colors.white,
                child: CashHeader(),
              ),
              drawerEdgeDragWidth: 0,
              pages: pages,
              currentIndex: _currentIndex,
              drawer: DrawerWidget(),
              bottomNavigationBar: BottomNavigationBar(
                onTap: _onTap,
                selectedFontSize: 13,
                unselectedFontSize: 13,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                backgroundColor: Theme.of(context).bottomAppBarColor,
                showUnselectedLabels: true,
                items: [
                  bottomBarItem(I18n.of(context).wallet, 'receive'),
                  bottomBarItem(I18n.of(context).your_home, 'home'),
                  bottomBarItem(I18n.of(context).pay_rent, 'rent'),
                  // bottomBarItem(I18n.of(context).receive, 'receive'),
                ],
              ));
        });
  }
}
