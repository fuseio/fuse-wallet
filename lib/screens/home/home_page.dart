import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:straitsx/constans/keys.dart';
import 'package:straitsx/generated/i18n.dart';
import 'package:straitsx/redux/actions/cash_wallet_actions.dart';
import 'package:straitsx/redux/actions/user_actions.dart';
import 'package:straitsx/screens/buy/router/buy_router.gr.dart';
import 'package:straitsx/screens/contacts/widgets/enable_contacts.dart';
import 'package:straitsx/screens/home/router/home_router.gr.dart';
import 'package:straitsx/screens/home/screens/receive.dart';
import 'package:straitsx/screens/misc/webview_page.dart';
import 'package:straitsx/screens/contacts/router/router_contacts.gr.dart';
import 'package:straitsx/screens/home/widgets/drawer.dart';
import 'package:straitsx/utils/contacts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:straitsx/models/app_state.dart';
import 'package:straitsx/redux/actions/pro_mode_wallet_actions.dart';
import 'package:straitsx/screens/home/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:straitsx/models/community/community.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();

  static _HomePageState of(BuildContext context) {
    return context.findAncestorStateOfType<_HomePageState>();
  }
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool isContactSynced = false;

  @override
  void initState() {
    super.initState();
    Contacts.checkPermissions().then((value) {
      setState(() {
        isContactSynced = value;
      });
    });
  }

  void _onTap(int itemIndex) {
    if (!mounted) return;
    setState(() {
      currentIndex = itemIndex;
    });
  }

  onInit(Store<AppState> store) {
    String walletStatus = store.state.userState.walletStatus;
    String accountAddress = store.state.userState.accountAddress;

    if (walletStatus != 'deploying' &&
        walletStatus != 'created' &&
        accountAddress != '') {
      store.dispatch(createAccountWalletCall(accountAddress));
    } else {
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
        store.dispatch(startFetchTokensLastestPrices());
        store.dispatch(startProcessingTokensJobsCall());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _HomePageViewModel>(
        distinct: true,
        converter: _HomePageViewModel.fromStore,
        onInit: onInit,
        builder: (_, vm) {
          return Scaffold(
              key: AppKeys.homePageKey,
              drawer: DrawerWidget(),
              drawerEdgeDragWidth: 0,
              drawerEnableOpenDragGesture: false,
              body: IndexedStack(index: currentIndex, children: <Widget>[
                ExtendedNavigator(
                  router: HomeRouter(),
                  name: 'homeRouter',
                  observers: [SegmentObserver()],
                ),
                ExtendedNavigator(
                  observers: [SegmentObserver()],
                  router: ContactsRouter(),
                  name: 'contactsRouter',
                  initialRoute:
                      vm.isContactsSynced != null && vm.isContactsSynced
                          ? ContactsRoutes.contactsList
                          : ContactsRoutes.emptyContacts,
                ),
                !['', null].contains(vm.community.webUrl)
                    ? WebViewPage(
                        url: vm.community.webUrl,
                        withBack: false,
                        title: I18n.of(context).community_webpage)
                    : ExtendedNavigator(
                        router: BuyRouter(),
                        observers: [SegmentObserver()],
                      ),
                ReceiveScreen()
              ]),
              bottomNavigationBar: BottomBar(
                onTap: (index) {
                  _onTap(index);
                  if (vm.isContactsSynced == null &&
                      index == 1 &&
                      !isContactSynced) {
                    Future.delayed(
                        Duration.zero,
                        () => showDialog(
                            context: context,
                            child: ContactsConfirmationScreen()));
                  }
                },
                tabIndex: currentIndex,
              ));
        });
  }
}

class _HomePageViewModel extends Equatable {
  final Community community;
  final bool isContactsSynced;

  _HomePageViewModel({
    this.isContactsSynced,
    this.community,
  });

  static _HomePageViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return _HomePageViewModel(
      isContactsSynced: store.state.userState.isContactsSynced,
      community: community,
    );
  }

  @override
  List<Object> get props => [community, isContactsSynced];
}
