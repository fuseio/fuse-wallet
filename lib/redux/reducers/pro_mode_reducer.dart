import 'package:BIM/models/jobs/base.dart';
import 'package:BIM/models/pro/pro_wallet_state.dart';
import 'package:BIM/models/pro/token.dart';
import 'package:BIM/redux/actions/pro_mode_wallet_actions.dart';
import 'package:BIM/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

final proWalletReducers = combineReducers<ProWalletState>([
  TypedReducer<ProWalletState, StartListenToTransferEventsSuccess>(_startListenToTransferEventsSuccess),
  TypedReducer<ProWalletState, UpdateToken>(_updateToken),
  TypedReducer<ProWalletState, UpadteBlockNumber>(_updateBlockNumber),
  TypedReducer<ProWalletState, StartProcessingTokensJobs>(_startProcessingTokensJobs),
  TypedReducer<ProWalletState, StartFetchTransferEvents>(_startFetchTransferEvents),
  TypedReducer<ProWalletState, InitWeb3ProModeSuccess>(_initWeb3ProModeSuccess),
  TypedReducer<ProWalletState, CreateLocalAccountSuccess>(_createNewWalletSuccess),
  TypedReducer<ProWalletState, GetTokenListSuccess>(_getTokenListSuccess),
  TypedReducer<ProWalletState, AddProJob>(_addProJob),
]);

ProWalletState _addProJob(ProWalletState state, AddProJob action) {
  Token currentToken = state.erc20Tokens[action.tokenAddress];
  Token newToken = currentToken.copyWith(jobs: List<Job>.from(currentToken.jobs)..add(action.job));
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  newOne[action.tokenAddress] = newToken;
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _createNewWalletSuccess(ProWalletState state, CreateLocalAccountSuccess action) {
  return ProWalletState.initial();
}

ProWalletState _startProcessingTokensJobs(ProWalletState state, StartProcessingTokensJobs action) {
  return state.copyWith(isProcessingTokensJobs: true);
}

ProWalletState _startFetchTransferEvents(ProWalletState state, StartFetchTransferEvents action) {
  return state.copyWith(isFetchTransferEvents: true);
}

ProWalletState _initWeb3ProModeSuccess(ProWalletState state, InitWeb3ProModeSuccess action) {
  return state.copyWith(web3: action.web3);
}

ProWalletState _updateBlockNumber(ProWalletState state, UpadteBlockNumber action) {
  return state.copyWith(blockNumber: action.blockNumber);
}

ProWalletState _startListenToTransferEventsSuccess(ProWalletState state, StartListenToTransferEventsSuccess action) {
  return state.copyWith(isListenToTransferEvents: true);
}

ProWalletState _getTokenListSuccess(ProWalletState state, GetTokenListSuccess action) {
  List<Token> currentErc20TokensList = List<Token>.from(action.erc20Tokens.values);
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  for (Token token in currentErc20TokensList) {
    if (newOne.containsKey(token.address)) {
      newOne[token.address] = newOne[token.address].copyWith(amount: token.amount, timestamp: token.timestamp);
    } else if (!newOne.containsKey(token.address)) {
      newOne[token.address] = token;
    }
  }
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _updateToken(ProWalletState state, UpdateToken action) {
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  newOne[action.tokenToUpdate.address] = action.tokenToUpdate;
  return state.copyWith(erc20Tokens: newOne);
}
