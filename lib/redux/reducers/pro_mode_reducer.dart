import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<ProWalletState>([
  TypedReducer<ProWalletState, StartListenToTransferEventsSuccess>(_startListenToTransferEventsSuccess),
]);

ProWalletState _startListenToTransferEventsSuccess(ProWalletState state, StartListenToTransferEventsSuccess action) {
  return state.copyWith(isListenToTransferEvents: true);
}
