import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/redux/viewsmodels/bottom_bar.dart';

class BottomBar extends StatelessWidget {
  final TabsRouter tabsRouter;

  const BottomBar(this.tabsRouter, {Key? key}) : super(key: key);

  BottomNavigationBarItem bottomBarItem(
    String title,
    String imgSvg, [
    String selectedPrefix = '_selected',
  ]) =>
      BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg.svg',
            width: 21,
            height: 21,
          ),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg$selectedPrefix.svg',
            width: 21,
            height: 21,
          ),
        ),
        label: title,
      );

  void onInIt(store) {
    store.dispatch(startFetchingCall());
    store.dispatch(startFetchTokensBalances());
    store.dispatch(updateTokensPrices());
    store.dispatch(checkWalletUpgrades());
    store.dispatch(loadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BottomBarViewModel>(
      distinct: true,
      onInit: onInIt,
      converter: BottomBarViewModel.fromStore,
      builder: (_, vm) {
        final Color color = Theme.of(context).colorScheme.onSurface;
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          elevation: 0,
          selectedItemColor: color,
          unselectedItemColor: color,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: [
            bottomBarItem(
              I10n.of(context).home,
              'home',
            ),
            bottomBarItem(
              I10n.of(context).wallet,
              'wallet',
            ),
            bottomBarItem(
              I10n.of(context).swap,
              'swap',
            ),
            bottomBarItem(
              I10n.of(context).account,
              'account',
            ),
          ],
          onTap: (int activeIndex) {
            if (activeIndex == tabsRouter.activeIndex && activeIndex == 0) {
              vm.scrollToTop();
            }
            if (activeIndex == 2) {
              vm.getSwapListBalances();
            }
            if (activeIndex == tabsRouter.activeIndex) {
              tabsRouter.stackRouterOfIndex(activeIndex)?.popUntilRoot();
            } else {
              tabsRouter.setActiveIndex(activeIndex);
            }
          },
        );
      },
    );
  }
}
