import 'dart:math';

import 'package:digitalrand/models/jobs/base.dart';
import 'package:digitalrand/models/pro/pro_wallet_state.dart';
import 'package:digitalrand/models/pro/token.dart';
import 'package:digitalrand/models/transactions/transaction.dart';
import 'package:digitalrand/models/transactions/transactions.dart';
import 'package:digitalrand/redux/actions/pro_mode_wallet_actions.dart';
import 'package:digitalrand/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

final proWalletReducers = combineReducers<ProWalletState>([
  TypedReducer<ProWalletState, StartListenToTransferEventsSuccess>(
      _startListenToTransferEventsSuccess),
  TypedReducer<ProWalletState, UpdateToken>(_updateToken),
  TypedReducer<ProWalletState, UpadteBlockNumber>(_updateBlockNumber),
  TypedReducer<ProWalletState, StartProcessingTokensJobs>(
      _startProcessingTokensJobs),
  TypedReducer<ProWalletState, StartFetchTransferEvents>(
      _startFetchTransferEvents),
  TypedReducer<ProWalletState, InitWeb3ProModeSuccess>(_initWeb3ProModeSuccess),
  TypedReducer<ProWalletState, CreateLocalAccountSuccess>(
      _createNewWalletSuccess),
  TypedReducer<ProWalletState, GetTokenListSuccess>(_getTokenListSuccess),
  TypedReducer<ProWalletState, AddProJob>(_addProJob),
  TypedReducer<ProWalletState, StartFetchTokensBalances>(
      _startFetchTokensBalances),
  TypedReducer<ProWalletState, UpdateEtherBalabnce>(_updateEtherBalabnce),
  TypedReducer<ProWalletState, StartProcessingSwapActions>(
      _startProcessingSwapActions),
  TypedReducer<ProWalletState, StartFetchTokensLastestPrices>(
      _startFetchTokensLastestPrices),
  TypedReducer<ProWalletState, AddProTransaction>(_addProTransaction),
  TypedReducer<ProWalletState, ReplaceProTransaction>(_replaceProTransaction),
  TypedReducer<ProWalletState, ProJobDone>(_proJobDone),
]);

ProWalletState _proJobDone(ProWalletState state, ProJobDone action) {
  Token current = state.erc20Tokens[action.tokenAddress];
  Token newToken = current.copyWith(
      jobs: List<Job>.from(current.jobs ?? [])..remove(action.job));
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  newOne[action.tokenAddress] = newToken;
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _replaceProTransaction(
    ProWalletState state, ReplaceProTransaction action) {
  Token current = state.erc20Tokens[action.tokenAddress];
  List<Transaction> oldTxs = List<Transaction>.from(current.transactions.list
      .where((tx) =>
          (tx.jobId != null && tx.jobId == action.transaction.jobId) ||
          (tx.txHash != null && tx.txHash == action.transaction.txHash) ||
          (tx.jobId != null && tx.jobId == action.transactionToReplace.jobId) ||
          (tx.txHash != null &&
              tx.txHash == action.transactionToReplace.txHash)));
  if (oldTxs.isEmpty) {
    return state;
  }
  int index = current.transactions.list.indexOf(oldTxs[0]);
  current.transactions.list[index] = action.transactionToReplace;
  oldTxs.removeAt(0);
  current.transactions.list.removeWhere((tx) => oldTxs.contains(tx));
  Token newToken = current.copyWith(
      transactions:
          current.transactions.copyWith(list: current.transactions.list));
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  newOne[action.tokenAddress] = newToken;
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _addProTransaction(
    ProWalletState state, AddProTransaction action) {
  Token current = state.erc20Tokens[action.tokenAddress];
  Transaction saved = current.transactions.list.firstWhere(
      (tx) => ((tx.jobId != null && tx.jobId == action.transaction.jobId) ||
          (tx.txHash != null && tx.txHash == action.transaction.txHash)),
      orElse: () => null);
  Transactions transactions;
  if (saved == null) {
    transactions = current.transactions
        .copyWith(list: current.transactions.list..add(action.transaction));
  } else {
    if (action.transaction.isPending()) {
      return state;
    }
    int index = current.transactions.list.indexOf(saved);
    transactions = current.transactions.copyWith();
    transactions.list[index] = action.transaction;
  }
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  newOne[action.tokenAddress] = current.copyWith(transactions: transactions);
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _updateEtherBalabnce(
    ProWalletState state, UpdateEtherBalabnce action) {
  return state.copyWith(etherBalance: action.balance);
}

ProWalletState _addProJob(ProWalletState state, AddProJob action) {
  Token currentToken = state.erc20Tokens[action.tokenAddress];
  Token newToken = currentToken.copyWith(
      jobs: List<Job>.from(currentToken?.jobs ?? [])..add(action.job));
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
  newOne[action.tokenAddress] = newToken;
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _createNewWalletSuccess(
    ProWalletState state, CreateLocalAccountSuccess action) {
  return ProWalletState.initial();
}

ProWalletState _startProcessingTokensJobs(
    ProWalletState state, StartProcessingTokensJobs action) {
  return state.copyWith(isProcessingTokensJobs: true);
}

ProWalletState _startFetchTokensLastestPrices(
    ProWalletState state, StartFetchTokensLastestPrices action) {
  return state.copyWith(isFetchTokensLastestPrice: true);
}

ProWalletState _startProcessingSwapActions(
    ProWalletState state, StartProcessingSwapActions action) {
  return state.copyWith(isProcessingSwapActions: true);
}

ProWalletState _startFetchTransferEvents(
    ProWalletState state, StartFetchTransferEvents action) {
  return state.copyWith(isFetchTransferEvents: true);
}

ProWalletState _initWeb3ProModeSuccess(
    ProWalletState state, InitWeb3ProModeSuccess action) {
  return state.copyWith(web3: action.web3);
}

ProWalletState _updateBlockNumber(
    ProWalletState state, UpadteBlockNumber action) {
  return state.copyWith(blockNumber: action.blockNumber);
}

ProWalletState _startListenToTransferEventsSuccess(
    ProWalletState state, StartListenToTransferEventsSuccess action) {
  return state.copyWith(isListenToTransferEvents: true);
}

ProWalletState _getTokenListSuccess(
    ProWalletState state, GetTokenListSuccess action) {
  List<Token> currentErc20TokensList =
      List<Token>.from(action.erc20Tokens.values ?? Iterable<Token>.empty());
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens
    ..removeWhere((key, token) {
      if (token.timestamp == 0) return false;
      double formatedValue =
          token.amount / BigInt.from(pow(10, token.decimals));
      return num.parse(formatedValue.toString()).compareTo(0) != 1;
    }));
  for (Token token in currentErc20TokensList) {
    if (newOne.containsKey(token.address)) {
      newOne[token.address] = newOne[token.address].copyWith(
          amount: token.amount,
          timestamp: token.timestamp,
          priceInfo: token.priceInfo);
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

ProWalletState _startFetchTokensBalances(
    ProWalletState state, StartFetchTokensBalances action) {
  return state.copyWith(isFetchTokensBalances: true);
}
