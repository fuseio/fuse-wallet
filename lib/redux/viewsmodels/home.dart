import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';

class HomeViewModel {
  final Function() onStart;

  HomeViewModel({
    required this.onStart,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    bool isCommunityLoading = store.state.cashWalletState.isCommunityLoading;
    final bool isCommunityFetched =
        store.state.cashWalletState.isCommunityFetched;
    final String walletAddress = store.state.userState.walletAddress;
    String communityAddress = store.state.cashWalletState.communityAddress;
    return HomeViewModel(
      onStart: () {
        if (store.state.cashWalletState.tokens.isEmpty &&
            !isCommunityLoading &&
            isCommunityFetched) {
          store.dispatch(switchCommunityCall(communityAddress));
        }
        if (!isCommunityLoading &&
            !isCommunityFetched &&
            ![null, ''].contains(walletAddress)) {
          store.dispatch(refetchCommunityData());
        }
      },
    );
  }
}
