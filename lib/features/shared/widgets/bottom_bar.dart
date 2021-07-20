import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/contacts/dialogs/enable_contacts.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/main_page.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/utils/contacts.dart';

class BottomBar extends StatefulWidget {
  late final TabsRouter tabsRouter;

  BottomBar(
    this.tabsRouter,
  );

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool isContactSynced = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      isContactSynced = await Contacts.checkPermissions();
    });
  }

  BottomNavigationBarItem bottomBarItem(
    String title,
    String imgSvg,
  ) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg\.svg',
            width: 25,
            height: 25,
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg\_selected.svg',
            width: 26,
            height: 26,
          ),
        ),
        label: title,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 3.0,
          ),
        ),
      ),
      child: StoreConnector<AppState, HomeScreenViewModel>(
        distinct: true,
        onInit: (store) {
          store.dispatch(getRewardData());
          store.dispatch(fetchSwapList());
          store.dispatch(startFetchingCall());
          store.dispatch(startFetchTokensBalances());
          store.dispatch(updateTokensPrices());
        },
        converter: HomeScreenViewModel.fromStore,
        builder: (_, vm) => BottomNavigationBar(
          currentIndex: widget.tabsRouter.activeIndex,
          onTap: (int activeIndex) {
            if (activeIndex == widget.tabsRouter.activeIndex) {
              context.router.popTop();
            } else {
              widget.tabsRouter.setActiveIndex(activeIndex);
            }
            if (vm.isContactsSynced == null &&
                activeIndex == 1 &&
                !isContactSynced) {
              Future.delayed(
                Duration(milliseconds: 200),
                () => showDialog(
                  context: context,
                  builder: (_) => ContactsConfirmationScreen(),
                ),
              );
            }

            if (widget.tabsRouter.activeIndex == 2) {
              vm.getSwapListBalances();
            }

            if (widget.tabsRouter.activeIndex == 3) {
              vm.updateReward();
            }
          },
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          selectedFontSize: 16,
          unselectedFontSize: 16,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: [
            bottomBarItem(I10n.of(context).home, 'home'),
            bottomBarItem(I10n.of(context).send_button, 'send'),
            bottomBarItem(I10n.of(context).swap, 'swap'),
            bottomBarItem(I10n.of(context).earn, 'earn'),
            bottomBarItem(I10n.of(context).account, 'account'),
          ],
        ),
      ),
    );
  }
}
