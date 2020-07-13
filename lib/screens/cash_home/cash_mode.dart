import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/screens/cash_home/fuse_points_explained.dart';
import 'package:fusecash/widgets/back_up_dialog.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/bottom_bar.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/screens/buy/buy.dart';
import 'package:fusecash/screens/cash_home/cash_header.dart';
import 'package:fusecash/screens/cash_home/cash_home.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';
import 'package:fusecash/screens/send/contacts_list.dart';
import 'package:fusecash/screens/send/receive.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/widgets/bottom_bar_item.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:fusecash/widgets/my_app_bar.dart';
import 'package:fusecash/widgets/tabs_scaffold.dart';

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

  List<Widget> _pages(
      List<Contact> contacts, bool isDefualtCommunity, String webUrl) {
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
    } else if (isDefualtCommunity) {
      return [
        CashHomeScreen(),
        !hasContactsInStore ? SendToContactScreen() : ContactsList(),
        FusePointsExplainedScreen(),
        ReceiveScreen()
      ];
    } else {
      return [
        CashHomeScreen(),
        !hasContactsInStore ? SendToContactScreen() : ContactsList(),
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
          vm.isDefaultCommunity
              ? bottomBarItem(I18n.of(context).fuse_points, 'fuse_points_tab')
              : bottomBarItem(I18n.of(context).buy, 'buy'),
          bottomBarItem(I18n.of(context).receive, 'receive'),
        ],
        onTap: _onTap,
      );

  onInit(Store<AppState> store) {
    String walletStatus = store.state.cashWalletState.walletStatus;
    String accountAddress = store.state.userState.accountAddress;
    bool isBackup = store.state.userState.backup ?? false;

    if (!isBackup) {
      Future.delayed(const Duration(milliseconds: 2500), () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return BackUpDialog();
            });
      });
    }

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
          final List<Widget> pages =
              _pages(vm.contacts, vm.isDefaultCommunity, vm.community?.webUrl);
          return TabsScaffold(
              header: MyAppBar(
                height: 200.0,
                backgroundColor: Colors.white,
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
