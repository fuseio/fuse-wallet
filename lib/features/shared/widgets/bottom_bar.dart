import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/contacts/dialogs/enable_contacts.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/viewsmodels/main_page.dart';
import 'package:fusecash/utils/contacts.dart';

class BottomBar extends StatefulWidget {
  late final TabsRouter tabsRouter;

  BottomBar(this.tabsRouter);

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
        //TODO: change the nav color
        icon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            'assets/images/$imgSvg\.svg',
          ),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset(
            //            colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.modulate),
            'assets/images/$imgSvg\_selected.svg',
            colorBlendMode: BlendMode.dst,
            color: Theme.of(context).primaryColor,
            width: 26,
            height: 26,
          ),
        ),
        label: title,
      );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeScreenViewModel>(
      distinct: true,
      converter: HomeScreenViewModel.fromStore,
      onInit: (store) {
        store.dispatch(fetchSwapList());
        store.dispatch(startFetchingCall());
        store.dispatch(startFetchTokensBalances());
        store.dispatch(updateTokensPrices());
      },
      builder: (_, vm) => BottomNavigationBar(
        onTap: (int activeIndex) {
          if (activeIndex == widget.tabsRouter.activeIndex) {
            context.router.popTop();
          } else {
            widget.tabsRouter.setActiveIndex(activeIndex);
          }
          if (vm.isContactsSynced == null &&
              widget.tabsRouter.activeIndex == 1 &&
              !isContactSynced) {
            Future.delayed(
              Duration.zero,
              () => showDialog(
                context: context,
                builder: (_) => ContactsConfirmationScreen(),
              ),
            );
          }

          // if (widget.tabsRouter.activeIndex == 2) {
          //   vm.getSwapListBalances();
          // }
        },
        selectedItemColor: Colors.grey,
        //Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.tabsRouter.activeIndex,
        backgroundColor: Colors.white,
        //Theme.of(context).bottomAppBarColor,
        showUnselectedLabels: true,
        items: [
          bottomBarItem(I10n.of(context).home, 'home'),
          bottomBarItem(I10n.of(context).send_button, 'send'),
          bottomBarItem(I10n.of(context).buy, 'buy'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 3),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/anom.png'),
                radius: 13,
              ),
            ),
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 5, bottom: 3),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.modulate),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  height: 28,
                  child: Image.asset('assets/images/anom.png'),
                ),
              ),
              // CircleAvatar(
              //   foregroundColor: Theme.of(context).primaryColor,
              //   backgroundColor: Theme.of(context).primaryColor,
              //   backgroundImage: AssetImage('assets/images/anom.png'),
              //   radius: 14,
              //   // foregroundColor: Theme.of(context).primaryColor,
              // ),
            ),
            label: I10n.of(context).account,
          )
        ],
      ),
    );
  }
}
