import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, GetPublicKeySuccess>(_getPublicKeySuccess),
  TypedReducer<CashWalletState, GetWalletAddressSuccess>(_getWalletAddressSuccess),
  TypedReducer<CashWalletState, GetTokenBalancesSuccess>(_getTokenBalancesSuccess),
  TypedReducer<CashWalletState, SendTokenSuccess>(_sendTokenSuccess),
  TypedReducer<CashWalletState, ReceiveTokenSuccess>(_receiveTokenSuccess),
  TypedReducer<CashWalletState, JoinCommunitySuccess>(_joinCommunitySuccess),
  TypedReducer<CashWalletState, SwitchCommunitySuccess>(_switchCommunitySuccess),
  TypedReducer<CashWalletState, JoinBonusSuccess>(_joinBonusSuccess),
  TypedReducer<CashWalletState, GetBusinessListSuccess>(_getBusinessListSuccess)
]);

CashWalletState _getPublicKeySuccess(CashWalletState state, GetPublicKeySuccess action) {
  
}

CashWalletState _getWalletAddressSuccess(CashWalletState state, GetWalletAddressSuccess action) {
  
}

CashWalletState _getTokenBalancesSuccess(CashWalletState state, GetTokenBalancesSuccess action) {
  
}

CashWalletState _sendTokenSuccess(CashWalletState state, SendTokenSuccess action) {
  
}

CashWalletState _receiveTokenSuccess(CashWalletState state, ReceiveTokenSuccess action) {
  
}

CashWalletState _joinCommunitySuccess(CashWalletState state, JoinCommunitySuccess action) {
  
}

CashWalletState _switchCommunitySuccess(CashWalletState state, SwitchCommunitySuccess action) {
  
}

CashWalletState _joinBonusSuccess(CashWalletState state, JoinBonusSuccess action) {
  
}

CashWalletState _getBusinessListSuccess(CashWalletState state, GetBusinessListSuccess action) {
  
}