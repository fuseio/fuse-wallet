import 'package:flutter/material.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/screens/buy/router/buy_router.gr.dart';
import 'package:fusecash/screens/home/router/home_router.gr.dart';
import 'package:fusecash/screens/home/screens/fuse_points_explained.dart';
import 'package:fusecash/screens/home/screens/receive.dart';
import 'package:fusecash/screens/misc/webview_page.dart';
import 'package:fusecash/widgets/drawer.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/bottom_bar.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/screens/send/contacts_list.dart';
import 'package:fusecash/screens/send/send_contact.dart';
import 'package:fusecash/widgets/bottom_bar_item.dart';
import 'package:auto_route/auto_route.dart';

final GlobalKey<ScaffoldState> homePageKey = new GlobalKey<ScaffoldState>();

class HomePage extends StatefulWidget {
  final int tabIndex;
  final Token primaryToken;
  HomePage({Key key, this.tabIndex = 0, this.primaryToken}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  Map pages = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.tabIndex;
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
              ? bottomBarItem(I18n.of(context).fuse_volts, 'fuse_points_tab')
              : bottomBarItem(I18n.of(context).buy, 'buy'),
          bottomBarItem(I18n.of(context).receive, 'receive'),
        ],
        onTap: _onTap,
      );

  onInit(Store<AppState> store) {
    String walletStatus = store.state.userState.walletStatus;
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
        distinct: true,
        converter: BottomBarViewModel.fromStore,
        onInit: onInit,
        builder: (_, vm) {
          return Scaffold(
              key: homePageKey,
              drawer: DrawerWidget(),
              drawerEdgeDragWidth: 0,
              drawerEnableOpenDragGesture: false,
              body: Stack(children: <Widget>[
                _buildOffstageChild(0, ExtendedNavigator(router: HomeRouter())),
                _buildOffstageChild(
                    1,
                    !vm.contacts.isNotEmpty
                        ? SendToContactScreen()
                        : ContactsList()),
                _buildOffstageChild(
                    2,
                    !['', null].contains(vm.community.webUrl)
                        ? WebViewPage(
                            url: vm.community.webUrl,
                            withBack: false,
                            title: 'Community webpage')
                        : vm.isDefaultCommunity
                            ? FusePointsExplainedScreen()
                            : ExtendedNavigator(router: BuyRouter())),
                _buildOffstageChild(3, ReceiveScreen()),
              ]),
              bottomNavigationBar: _bottomNavigationBar(vm));
        });
  }

  Widget _buildOffstageChild(int tabItem, Widget child) {
    return Offstage(
      offstage: _currentIndex != tabItem,
      child: child,
    );
  }
}
