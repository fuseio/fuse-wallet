import 'package:equatable/equatable.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class FeedViewModel extends Equatable {
  final List<WalletAction> walletActions;
  final bool scrollToTop;

  const FeedViewModel({
    required this.walletActions,
    required this.scrollToTop,
  });

  static FeedViewModel fromStore(Store<AppState> store) {
    CashWalletState cashWalletState = store.state.cashWalletState;
    final List<WalletAction> walletActions =
        cashWalletState.walletActions != null
            ? cashWalletState.walletActions!.list.toList()
            : [];
    walletActions.sort();
    return FeedViewModel(
      scrollToTop: store.state.userState.scrollToTop,
      walletActions: walletActions.reversed.toList(),
    );
  }

  @override
  List<Object?> get props => [
        walletActions,
        scrollToTop,
      ];
}
