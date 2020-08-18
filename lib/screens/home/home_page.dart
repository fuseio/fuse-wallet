import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:seedbed/constans/keys.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';
import 'package:seedbed/redux/actions/user_actions.dart';
import 'package:seedbed/screens/contacts/send_amount_arguments.dart';
import 'package:seedbed/screens/home/router/home_router.gr.dart';
import 'package:seedbed/screens/home/screens/receive.dart';
import 'package:seedbed/screens/contacts/router/router_contacts.gr.dart';
import 'package:seedbed/screens/home/widgets/drawer.dart';
import 'package:seedbed/screens/send_flow/send_amount.dart';
import 'package:seedbed/utils/addresses.dart';
import 'package:seedbed/utils/contacts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:seedbed/redux/actions/pro_mode_wallet_actions.dart';
import 'package:seedbed/screens/home/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:seedbed/models/community/community.dart';
import 'package:seedbed/utils/addresses.dart' as util;

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
                FutureBuilder(
                  future: Contacts.checkPermissions(),
                  builder: (context, snapshot) => ExtendedNavigator(
                    observers: [SegmentObserver()],
                    router: ContactsRouter(),
                    name: 'contactsRouter',
                    initialRoute: snapshot.data != null && snapshot.data == true
                        ? ContactsRoutes.contactsList
                        : ContactsRoutes.emptyContacts,
                  ),
                ),
                SendAmountScreen(
                    pageArgs: SendAmountArguments(
                  isConvert: true,
                  accountAddress: reserveContractAddress,
                  avatar: NetworkImage(
                      'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png'),
                  name: 'Convertor',
                )),
                ReceiveScreen()
              ]),
              bottomNavigationBar: BottomBar(
                onTap: _onTap,
                tabIndex: currentIndex,
              ));
        });
  }
}

class _HomePageViewModel extends Equatable {
  final Community community;
  final bool isDefaultCommunity;

  _HomePageViewModel({
    this.isDefaultCommunity,
    this.community,
  });

  static _HomePageViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return _HomePageViewModel(
      community: community,
      isDefaultCommunity: util.isDefaultCommunity(communityAddress),
    );
  }

  @override
  List<Object> get props => [isDefaultCommunity, community];
}
