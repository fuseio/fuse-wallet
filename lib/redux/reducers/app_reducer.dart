import 'package:farmlyledger/models/app_state.dart';
import 'package:farmlyledger/redux/reducers/pro_mode_reducer.dart';
import 'package:farmlyledger/redux/reducers/user_reducer.dart';
import 'package:farmlyledger/redux/reducers/cash_wallet_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducers(state.userState, action),
    cashWalletState: cashWalletReducers(state.cashWalletState, action),
    proWalletState: proWalletReducers(state.proWalletState, action)
  );
}