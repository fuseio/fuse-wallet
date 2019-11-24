import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, InitWeb3Success>(_initWeb3Success),
  TypedReducer<CashWalletState, GetPublicKeySuccess>(_getPublicKeySuccess),
  TypedReducer<CashWalletState, GetWalletAddressSuccess>(_getWalletAddressSuccess),
  TypedReducer<CashWalletState, GetTokenBalancesSuccess>(_getTokenBalancesSuccess),
  TypedReducer<CashWalletState, SendTokenSuccess>(_sendTokenSuccess),
  TypedReducer<CashWalletState, ReceiveTokenSuccess>(_receiveTokenSuccess),
  TypedReducer<CashWalletState, JoinCommunitySuccess>(_joinCommunitySuccess),
  TypedReducer<CashWalletState, SwitchCommunitySuccess>(_switchCommunitySuccess),
  TypedReducer<CashWalletState, GetJoinBonusSuccess>(_getJoinBonusSuccess),
  TypedReducer<CashWalletState, GetBusinessListSuccess>(_getBusinessListSuccess)
]);

CashWalletState _initWeb3Success(CashWalletState state, InitWeb3Success action) {
  return state.copyWith(web3: action.web3);
}

CashWalletState _getPublicKeySuccess(CashWalletState state, GetPublicKeySuccess action) {
  return state.copyWith(publicKey: action.publicKey);
}

CashWalletState _getWalletAddressSuccess(CashWalletState state, GetWalletAddressSuccess action) {
  return state.copyWith(walletAddress: action.walletAddress);
}

CashWalletState _getTokenBalancesSuccess(CashWalletState state, GetTokenBalancesSuccess action) {
  // TODO
}

CashWalletState _sendTokenSuccess(CashWalletState state, SendTokenSuccess action) {
  // TODO
}

CashWalletState _receiveTokenSuccess(CashWalletState state, ReceiveTokenSuccess action) {
  // TODO
}

CashWalletState _joinCommunitySuccess(CashWalletState state, JoinCommunitySuccess action) {
  // TODO
}

CashWalletState _switchCommunitySuccess(CashWalletState state, SwitchCommunitySuccess action) {
  // TODO
}

CashWalletState _getJoinBonusSuccess(CashWalletState state, GetJoinBonusSuccess action) {
  // TODO
}

CashWalletState _getBusinessListSuccess(CashWalletState state, GetBusinessListSuccess action) {
  // TODO
}