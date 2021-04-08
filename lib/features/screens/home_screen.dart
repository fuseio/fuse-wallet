import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/features/buy/router/buy_router.gr.dart';
import 'package:fusecash/features/contacts/dialogs/enable_contacts.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';
import 'package:fusecash/features/screens/fuse_studio_explained.dart';
import 'package:fusecash/features/screens/receive_screen.dart';
import 'package:fusecash/features/contacts/router/router_contacts.gr.dart';
import 'package:fusecash/features/home/widgets/drawer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/viewsmodels/main_page.dart';
import 'package:fusecash/utils/contacts.dart';
import 'package:fusecash/features/home/dialogs/back_up_dialog.dart';
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, HomeScreenViewModel>(
      distinct: true,
      converter: HomeScreenViewModel.fromStore,
      onInit: (store) {
        store.dispatch(updateTokensPrices());
      },
      builder: (_, vm) {
        return Scaffold(
          key: AppKeys.homePageKey,
          drawer: DrawerWidget(),
          drawerEdgeDragWidth: 0,
          drawerEnableOpenDragGesture: false,
          body: IndexedStack(
            index: currentIndex,
            children: [
              ExtendedNavigator(
                router: HomeRouter(),
                name: 'homeRouter',
                observers: [
                  SegmentObserver(),
                  SentryNavigatorObserver(),
                ],
              ),
              ExtendedNavigator(
                router: ContactsRouter(),
                name: 'contactsRouter',
                initialRoute: vm.isContactsSynced != null && vm.isContactsSynced
                    ? ContactsRoutes.contactsList
                    : ContactsRoutes.emptyContacts,
                observers: [
                  SegmentObserver(),
                  SentryNavigatorObserver(),
                ],
              ),
              vm.isDefaultCommunity
                  ? FusePointsExplainedScreen()
                  : ExtendedNavigator(
                      router: BuyRouter(),
                      name: 'buyRouter',
                      observers: [
                        SegmentObserver(),
                        SentryNavigatorObserver(),
                      ],
                    ),
              ReceiveScreen(),
            ],
          ),
          bottomNavigationBar: BottomBar(
            tabIndex: currentIndex,
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
                    },
                  );
                });
              }
            },
          ),
        );
      },
    );
  }
}
