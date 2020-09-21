import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:digitalrand/constans/keys.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/redux/actions/cash_wallet_actions.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';
import 'package:digitalrand/screens/contacts/widgets/enable_contacts.dart';
import 'package:digitalrand/screens/home/router/home_router.gr.dart';
import 'package:digitalrand/screens/home/screens/receive.dart';
import 'package:digitalrand/screens/misc/inapp_webview_page.dart';
import 'package:digitalrand/screens/contacts/router/router_contacts.gr.dart';
import 'package:digitalrand/screens/home/widgets/drawer.dart';
import 'package:digitalrand/utils/contacts.dart';
import 'package:digitalrand/widgets/back_up_dialog.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/screens/home/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/screens/trade/trade.dart';

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
                    ? WebViewWidget(
                        url: vm.community.webUrl,
                        withBack: false,
                        title: I18n.of(context).community_webpage)
                    : TradeScreen(),
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

                  if (!vm.backup && !vm.isBackupDialogShowed && index == 3) {
                    Future.delayed(Duration.zero, () {
                      vm.setShowDialog();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BackUpDialog();
                          });
                    });
                  }
                },
                tabIndex: currentIndex,
              ));
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

  _HomePageViewModel({
    this.isContactsSynced,
    this.isDefaultCommunity,
    this.community,
    this.backup,
    this.isBackupDialogShowed,
    this.setShowDialog,
  });

  static _HomePageViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            new Community.initial();
    return _HomePageViewModel(
      isContactsSynced: store.state.userState.isContactsSynced,
      community: community,
      backup: store.state.userState.backup,
      isBackupDialogShowed:
          store.state.userState?.receiveBackupDialogShowed ?? false,
      setShowDialog: () {
        store.dispatch(ReceiveBackupDialogShowed());
      },
    );
  }

  @override
  List<Object> get props => [community, backup, isContactsSynced];
}
