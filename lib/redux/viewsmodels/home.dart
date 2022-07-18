import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class HomeViewModel extends Equatable {
  final bool showBanner;
  final Function() refreshFeed;
  final Function(
    VoidCallback onSuccess,
  ) fetchNextPage;

  const HomeViewModel({
    required this.showBanner,
    required this.refreshFeed,
    required this.fetchNextPage,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    CashWalletState cashWalletState = store.state.cashWalletState;
    final List<WalletAction> walletActions =
        cashWalletState.walletActions != null
            ? cashWalletState.walletActions!.list.toList()
            : [];
    return HomeViewModel(
      showBanner: walletActions.length > 3,
      refreshFeed: () {
        store.dispatch(refresh());
      },
      fetchNextPage: (
        onSuccess,
      ) {
        store.dispatch(getWalletActionsCall(
          onSuccess: onSuccess,
        ));
      },
    );
  }

  @override
  List<Object?> get props => [
        showBanner,
      ];
}
