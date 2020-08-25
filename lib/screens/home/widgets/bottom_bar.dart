import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seedbed/constans/keys.dart';
import 'package:seedbed/generated/i18n.dart';
import 'package:seedbed/models/app_state.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:seedbed/models/community/community.dart';
import 'package:seedbed/utils/addresses.dart' as util;

class BottomBar extends StatelessWidget {
  final int tabIndex;
  final void Function(int) onTap;
  BottomBar({Key key, this.tabIndex = 0, this.onTap}) : super(key: key);

  BottomNavigationBarItem bottomBarItem(String title, String imgSvg) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset('assets/images/$imgSvg\.svg'),
        ),
        activeIcon: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 3),
          child: SvgPicture.asset('assets/images/$imgSvg\_selected.svg'),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(title,
              style: TextStyle(fontSize: 13.0, color: Color(0xFF292929))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _BottomBarViewModel>(
        distinct: true,
        converter: _BottomBarViewModel.fromStore,
        builder: (_, vm) {
          return BottomNavigationBar(
            key: AppKeys.bottomBarKey,
            selectedFontSize: 13,
            unselectedFontSize: 13,
            type: BottomNavigationBarType.fixed,
            currentIndex: tabIndex,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            showUnselectedLabels: true,
            items: [
              bottomBarItem(I18n.of(context).home, 'home'),
              bottomBarItem(I18n.of(context).send_button, 'send'),
              vm.hasReserveContract
                  ? bottomBarItem(I18n.of(context).convert, 'buy')
                  : null,
              bottomBarItem(I18n.of(context).receive, 'receive'),
            ]
              ..removeWhere((element) => element == null)
              ..toList(),
            onTap: onTap,
          );
        });
  }
}

class _BottomBarViewModel extends Equatable {
  final bool hasReserveContract;

  _BottomBarViewModel({
    this.hasReserveContract,
  });

  static _BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    final Community community =
        store.state.cashWalletState.communities[communityAddress];
    return _BottomBarViewModel(
      hasReserveContract:
          community?.customData?.containsKey('reserveContractAddress') ?? false,
    );
  }

  @override
  List<Object> get props => [hasReserveContract];
}
