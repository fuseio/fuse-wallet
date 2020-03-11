// import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<ProWalletState>([
  // TypedReducer<CashWalletState, SetDefaultCommunity>(_setDefaultCommunity),
]);

// ProWalletState _setDefaultCommunity(ProWalletState state, SetDefaultCommunity action) {
//   return state;
// }
