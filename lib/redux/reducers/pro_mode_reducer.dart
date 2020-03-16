import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:redux/redux.dart';

final proWalletReducers = combineReducers<ProWalletState>([
  TypedReducer<ProWalletState, StartListenToTransferEventsSuccess>(_startListenToTransferEventsSuccess),
  TypedReducer<ProWalletState, UpdateToken>(_updateToken),
  TypedReducer<ProWalletState, AddToken>(_addToken),
  TypedReducer<ProWalletState, UpadteBlockNumber>(_updateBlockNumber),
  TypedReducer<ProWalletState, InitWeb3ProModeSuccess>(_initWeb3ProModeSuccess),
]);

ProWalletState _initWeb3ProModeSuccess(ProWalletState state, InitWeb3ProModeSuccess action) {
  return state.copyWith(web3: action.web3);
}

ProWalletState _updateBlockNumber(ProWalletState state, UpadteBlockNumber action) {
  return state.copyWith(blockNumber: action.blockNumber);
}

ProWalletState _startListenToTransferEventsSuccess(ProWalletState state, StartListenToTransferEventsSuccess action) {
  return state.copyWith(isListenToTransferEvents: true);
}

ProWalletState _addToken(ProWalletState state, AddToken action) {
  List<Token> tokens = state.tokens;
  bool isTokenExist = tokens.any((token) => token.address == action.token.address);
  if (isTokenExist) {
    List<Token> tokens = state.tokens;
    int index = tokens.indexWhere((token) => token.address == action.token.address);
    tokens[index] = action.token;
    return state.copyWith(tokens: tokens);
  }
  return state.copyWith(tokens: state.tokens..add(action.token));
}

ProWalletState _updateToken(ProWalletState state, UpdateToken action) {
  List<Token> tokens = state.tokens;
  int index = tokens.indexOf(action.token);
  tokens[index] = action.tokenToUpdate;
  return state.copyWith(tokens: tokens);
}
