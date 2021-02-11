import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/features/screens/coming_soon.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/features/contacts/widgets/enable_contacts.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';
import 'package:fusecash/features/home/screens/receive.dart';
import 'package:fusecash/features/contacts/router/router_contacts.gr.dart';
import 'package:fusecash/features/home/widgets/drawer.dart';
import 'package:fusecash/redux/viewsmodels/main_page.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/features/home/widgets/back_up_dialog.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/widgets/bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MainHomeScreen extends StatefulWidget {
  MainHomeScreen({Key key}) : super(key: key);
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();

  static _MainHomeScreenState of(BuildContext context) {
    return context.findAncestorStateOfType<_MainHomeScreenState>();
  }
}

class _MainHomeScreenState extends State<MainHomeScreen> {
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
    return new StoreConnector<AppState, HomeScreenViewModel>(
      distinct: true,
      converter: HomeScreenViewModel.fromStore,
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
              observers: [
                SegmentObserver(),
                SentryNavigatorObserver(),
              ],
            ),
            ExtendedNavigator(
              observers: [
                SegmentObserver(),
                SentryNavigatorObserver(),
              ],
              router: ContactsRouter(),
              name: 'contactsRouter',
              initialRoute: vm.isContactsSynced != null && vm.isContactsSynced
                  ? ContactsRoutes.contactsList
                  : ContactsRoutes.emptyContacts,
            ),
            SwapScreen(),
            // !['', null].contains(vm.community.webUrl)
            //     ? WebViewScreen(
            //         url: vm.community.webUrl,
            //         withBack: false,
            //         title: I18n.of(context).community_webpage)
            //     : ExtendedNavigator(
            //         name: 'buyRouter',
            //         router: BuyRouter(),
            //         observers: [
            //           SegmentObserver(),
            //           SentryNavigatorObserver(),
            //         ],
            //       ),
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
                    builder: (_) => ContactsConfirmationScreen(),
                  ),
                );
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
          ),
        );
      },
    );
  }
}
