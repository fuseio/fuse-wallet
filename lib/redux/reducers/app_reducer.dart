import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/reducers/cash_wallet_reducer.dart';
import 'package:fusecash/redux/reducers/nft_reducer.dart';
import 'package:fusecash/redux/reducers/swap_reducer.dart';
import 'package:fusecash/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    nftsState: nftReducers(state.nftsState, action),
    userState: userReducers(state.userState, action),
    cashWalletState: cashWalletReducers(state.cashWalletState, action),
    swapState: swapReducers(state.swapState, action),
  );
}
