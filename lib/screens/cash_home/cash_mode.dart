import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:BIM/generated/i18n.dart';
import 'package:BIM/models/app_state.dart';
import 'package:BIM/models/views/bottom_bar.dart';
import 'package:BIM/screens/buy/buy.dart';
import 'package:BIM/screens/cash_home/cash_header.dart';
import 'package:BIM/screens/cash_home/cash_home.dart';
import 'package:BIM/screens/cash_home/webview_page.dart';
import 'package:BIM/screens/send/contacts_list.dart';
import 'package:BIM/screens/send/receive.dart';
import 'package:BIM/screens/send/send_contact.dart';
import 'package:BIM/widgets/bottom_bar_item.dart';
import 'package:BIM/widgets/drawer.dart';
import 'package:BIM/widgets/my_app_bar.dart';
import 'package:BIM/widgets/tabs_scaffold.dart';

class CashModeScaffold extends StatefulWidget {
  final int tabIndex;
  CashModeScaffold({Key key, this.tabIndex = 0}) : super(key: key);
  @override
  _CashModeScaffoldState createState() => _CashModeScaffoldState();
}

class _CashModeScaffoldState extends State<CashModeScaffold> {
  int _currentIndex = 0;
  List<Color> colors = [Colors.red, Colors.white, Colors.white, Colors.white];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabIndex;
  }

  List<Widget> _pages(
      List<Contact> contacts, String webUrl) {
    bool hasContactsInStore = contacts.isNotEmpty;
    if (webUrl != null && webUrl.isNotEmpty) {
      return [
        CashHomeScreen(),
        !hasContactsInStore
            ? SendToContactScreen()
            : ContactsList(contacts: contacts),
        WebViewPage(
          pageArgs: WebViewPageArguments(
              url: webUrl, withBack: false, title: 'Community webpage'),
        ),
        ReceiveScreen()
      ];
    } else {
      return [
        CashHomeScreen(),
        !hasContactsInStore
            ? SendToContactScreen()
            : ContactsList(contacts: contacts),
        BuyScreen(),
        ReceiveScreen()
      ];
    }
  }

  void _onTap(int itemIndex) {
    setState(() {
      _currentIndex = itemIndex;
    });
  }

  BottomNavigationBar _bottomNavigationBar(BottomBarViewModel vm) =>
      BottomNavigationBar(
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        showUnselectedLabels: true,
        items: [
          bottomBarItem(I18n.of(context).home, 'home'),
          bottomBarItem(I18n.of(context).send_button, 'send'),
          bottomBarItem(I18n.of(context).buy, 'buy'),
          bottomBarItem(I18n.of(context).receive, 'receive'),
        ],
        onTap: _onTap,
      );

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BottomBarViewModel>(
        converter: BottomBarViewModel.fromStore,
        builder: (_, vm) {
          final List<Widget> pages =
              _pages(vm.contacts, vm.community?.webUrl);
          return TabsScaffold(
              header: MyAppBar(
                height: MediaQuery.of(context).size.height * .25,
                backgroundColor: Colors.red,
                child: CashHeader(),
              ),
              drawerEdgeDragWidth: 0,
              pages: pages,
              currentIndex: _currentIndex,
              drawer: DrawerWidget(),
              bottomNavigationBar: _bottomNavigationBar(vm));
        });
  }
}
