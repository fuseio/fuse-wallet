import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:roost/constans/keys.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/redux/actions/cash_wallet_actions.dart';
import 'package:roost/redux/actions/user_actions.dart';
import 'package:roost/screens/buy/router/buy_router.gr.dart';
import 'package:roost/screens/home/router/home_router.gr.dart';
import 'package:roost/screens/misc/inapp_webview_page.dart';
import 'package:roost/screens/home/widgets/drawer.dart';
import 'package:roost/utils/contacts.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/models/app_state.dart';
import 'package:roost/screens/home/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:roost/models/community/community.dart';
import 'package:roost/utils/addresses.dart' as util;

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
    final String walletStatus = store.state.userState.walletStatus;
    final String accountAddress = store.state.userState.accountAddress;
    final String identifier = store.state.userState.identifier;
    final String isoCode = store.state.userState.isoCode;

    if ([null, ''].contains(identifier)) {
      store.dispatch(setDeviceId(true));
    }

    if ([null, ''].contains(isoCode)) {
      Locale myLocale = Localizations.localeOf(context);
      Map localeData = codes.firstWhere(
          (Map code) => code['code'] == myLocale.countryCode,
          orElse: () => null);
      store.dispatch(setCountryCode(CountryCode(
          dialCode: localeData['dial_code'], code: localeData['code'])));
    }

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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
      if (connectivity == ConnectivityResult.none) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Center(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  I18n.of(context).oops,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 25),
                ),
                Text(
                  I18n.of(context).offline,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
                Text(
                  I18n.of(context).connection,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
              ],
            ),
          )),
        );
      } else {
        return child;
      }
    }, builder: (BuildContext context) {
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
                  WebViewWidget(
                      withBack: false,
                      url:
                          'https://app.roostnow.co.uk/home?wallet=${vm.walletAddress}',
                      title: I18n.of(context).your_home),
                  ExtendedNavigator(
                    name: 'buyRouter',
                    router: BuyRouter(),
                    observers: [SegmentObserver()],
                  )
                ]),
                bottomNavigationBar: BottomBar(
                  onTap: (index) {
                    _onTap(index);
                    // if (vm.isContactsSynced == null &&
                    //     index == 1 &&
                    //     !isContactSynced) {
                    //   Future.delayed(
                    //       Duration.zero,
                    //       () => showDialog(
                    //           context: context,
                    //           child: ContactsConfirmationScreen()));
                    // }

                    // if (!vm.backup && !vm.isBackupDialogShowed && index == 3) {
                    //   Future.delayed(Duration.zero, () {
                    //     vm.setShowDialog();
                    //     showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //           return BackUpDialog();
                    //         });
                    //   });
                    // }
                  },
                  tabIndex: currentIndex,
                ));
          });
    });
  }
}

class _HomePageViewModel extends Equatable {
  final Community community;
  final bool isDefaultCommunity;
  final bool isContactsSynced;
  final bool backup;
  final bool isBackupDialogShowed;
  final Function setShowDialog;
  final String walletAddress;

  _HomePageViewModel(
      {this.isContactsSynced,
      this.isDefaultCommunity,
      this.community,
      this.backup,
      this.isBackupDialogShowed,
      this.setShowDialog,
      this.walletAddress});

  static _HomePageViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return _HomePageViewModel(
      walletAddress: store.state.userState.walletAddress,
      isContactsSynced: store.state.userState.isContactsSynced,
      community: community,
      isDefaultCommunity: util.isDefaultCommunity(communityAddress),
      backup: store.state.userState.backup,
      isBackupDialogShowed:
          store.state.userState?.receiveBackupDialogShowed ?? false,
      setShowDialog: () {
        store.dispatch(ReceiveBackupDialogShowed());
      },
    );
  }

  @override
  List<Object> get props => [isDefaultCommunity, community, isContactsSynced];
}
