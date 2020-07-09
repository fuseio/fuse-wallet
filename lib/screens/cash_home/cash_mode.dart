import 'package:contacts_service/contacts_service.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/screens/trade/trade.dart';
import 'package:flutter/material.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/views/bottom_bar.dart';
import 'package:digitalrand/redux/actions/pro_mode_wallet_actions.dart';
import 'package:digitalrand/screens/cash_home/cash_header.dart';
import 'package:digitalrand/screens/cash_home/cash_home.dart';
import 'package:digitalrand/screens/cash_home/webview_page.dart';
import 'package:digitalrand/screens/send/contacts_list.dart';
import 'package:digitalrand/screens/send/receive.dart';
import 'package:digitalrand/screens/send/send_contact.dart';
import 'package:digitalrand/widgets/bottom_bar_item.dart';
import 'package:digitalrand/widgets/drawer.dart';
import 'package:digitalrand/widgets/my_app_bar.dart';
import 'package:digitalrand/widgets/tabs_scaffold.dart';

class CashModeScaffold extends StatefulWidget {
  final int tabIndex;
  final Token primaryToken;
  CashModeScaffold({Key key, this.tabIndex = 0, this.primaryToken})
      : super(key: key);
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

  List<Widget> _pages(List<Contact> contacts, String webUrl) {
    bool hasContactsInStore = contacts.isNotEmpty;
    if (webUrl != null && webUrl.isNotEmpty) {
      return [
        CashHomeScreen(),
        !hasContactsInStore ? SendToContactScreen() : ContactsList(),
        WebViewPage(
          pageArgs: WebViewPageArguments(
              url: webUrl, withBack: false, title: 'Community webpage'),
        ),
        ReceiveScreen()
      ];
    } else {
      return [
        CashHomeScreen(),
        !hasContactsInStore ? SendToContactScreen() : ContactsList(),
        TradeScreen(primaryToken: widget.primaryToken),
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
          bottomBarItem(I18n.of(context).trade, 'trade'),
          bottomBarItem(I18n.of(context).receive, 'receive'),
        ],
        onTap: _onTap,
      );

  onInit(Store<AppState> store) {
    String walletStatus = store.state.cashWalletState.walletStatus;
    String accountAddress = store.state.userState.accountAddress;
    if (walletStatus != 'deploying' &&
        walletStatus != 'created' &&
        accountAddress != '') {
      store.dispatch(createAccountWalletCall(accountAddress));
    }
    String privateKey = store.state.userState.privateKey;
    String jwtToken = store.state.userState.jwtToken;
    bool isLoggedOut = store.state.userState.isLoggedOut;
    if (privateKey.isNotEmpty && jwtToken.isNotEmpty && !isLoggedOut) {
      store.dispatch(getWalletAddressessCall());
      store.dispatch(identifyCall());
      store.dispatch(loadContacts());
      store.dispatch(startListenToTransferEvents());
      store.dispatch(startFetchBalancesOnForeign());
      store.dispatch(startFetchTransferEventsCall());
      store.dispatch(fetchTokensBalances());
      store.dispatch(startProcessingTokensJobsCall());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, BottomBarViewModel>(
        converter: BottomBarViewModel.fromStore,
        onInit: onInit,
        builder: (_, vm) {
          final List<Widget> pages = _pages(vm.contacts, vm.community?.webUrl);
          return TabsScaffold(
              header: MyAppBar(
                height: 195.0,
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
