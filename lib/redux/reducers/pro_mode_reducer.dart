import 'dart:math';

import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

bool Function(String, Token) clearTokensWithZero = (key, token) {
  if (token.timestamp == 0) return false;
  double formattedValue = token.amount / BigInt.from(pow(10, token.decimals));
  return num.parse(formattedValue.toString()).compareTo(0) != 1;
};

final proWalletReducers = combineReducers<ProWalletState>([
  TypedReducer<ProWalletState, ResetTokenTxs>(_resetTokensTxs),
  TypedReducer<ProWalletState, SetIsListenToTransferEvents>(
      _startListenToTransferEventsSuccess),
  TypedReducer<ProWalletState, UpdateToken>(_updateToken),
  TypedReducer<ProWalletState, SetIsProcessingTokensJobs>(
      _startProcessingTokensJobs),
  TypedReducer<ProWalletState, SetIsFetchTransferEvents>(
      _startFetchTransferEvents),
  TypedReducer<ProWalletState, CreateLocalAccountSuccess>(
      _createNewWalletSuccess),
  TypedReducer<ProWalletState, SetIsFetchTokensBalances>(
      _startFetchTokensBalances),
  TypedReducer<ProWalletState, UpdateEtherBalance>(_updateEtherBalance),
  TypedReducer<ProWalletState, SetIsFetchTokensLatestPrices>(
      _startFetchTokensLatestPrices),
  // TypedReducer<ProWalletState, AddProTransaction>(_addProTransaction),
  // TypedReducer<ProWalletState, ReplaceProTransaction>(_replaceProTransaction),
  TypedReducer<ProWalletState, AddNewToken>(_addNewToken),
  TypedReducer<ProWalletState, SetIsFetchNewTokens>(_startFetchNewTokens),
  TypedReducer<ProWalletState, ClearTokenList>(_clearTokenList),
]);

ProWalletState _resetTokensTxs(ProWalletState state, ResetTokenTxs action) {
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens!);
  for (String tokenAddress in newOne.keys) {
    newOne[tokenAddress] = newOne[tokenAddress]!.copyWith(
      walletActions: WalletActions.initial(),
    );
  }
  return state.copyWith(erc20Tokens: newOne);
}

// ProWalletState _replaceProTransaction(
//     ProWalletState state, ReplaceProTransaction action) {
//   Token current = state.erc20Tokens[action.tokenAddress];
//   List<Transaction> oldTxs = List<Transaction>.from(current.transactions.list
//       .where((tx) =>
//           (tx.jobId != null && tx.jobId == action.transaction.jobId) ||
//           (tx.txHash != null && tx.txHash == action.transaction.txHash) ||
//           (tx.jobId != null && tx.jobId == action.transactionToReplace.jobId) ||
//           (tx.txHash != null &&
//               tx.txHash == action.transactionToReplace.txHash)));
//   if (oldTxs.isEmpty) {
//     return state;
//   }
//   int index = current.transactions.list.indexOf(oldTxs[0]);
//   current.transactions.list[index] = action.transactionToReplace;
//   oldTxs.removeAt(0);
//   current.transactions.list.removeWhere((tx) => oldTxs.contains(tx));
//   Token newToken = current.copyWith(
//       transactions:
//           current.transactions.copyWith(list: current.transactions.list));
//   Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
//   newOne[action.tokenAddress] = newToken;
//   return state.copyWith(erc20Tokens: newOne);
// }

// ProWalletState _addProTransaction(
//     ProWalletState state, AddProTransaction action) {
//   Token current = state.erc20Tokens[action.tokenAddress];
//   Transaction saved = current.transactions.list.firstWhere(
//       (tx) => ((tx.jobId != null && tx.jobId == action.transaction.jobId) ||
//           (tx.txHash != null && tx.txHash == action.transaction.txHash)),
//       );
//   Transactions transactions;
//   if (saved == null) {
//     transactions = current.transactions
//         .copyWith(list: current.transactions.list..add(action.transaction));
//   } else {
//     int index = current.transactions.list.indexOf(saved);
//     transactions = current.transactions.copyWith();
//     transactions.list[index] = action.transaction;
//   }
//   Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens);
//   newOne[action.tokenAddress] = current.copyWith(transactions: transactions);
//   return state.copyWith(erc20Tokens: newOne);
// }

ProWalletState _updateEtherBalance(
    ProWalletState state, UpdateEtherBalance action) {
  return state.copyWith(etherBalance: action.balance);
}

ProWalletState _createNewWalletSuccess(
    ProWalletState state, CreateLocalAccountSuccess action) {
  return ProWalletState();
}

ProWalletState _startProcessingTokensJobs(
    ProWalletState state, SetIsProcessingTokensJobs action) {
  return state.copyWith(isProcessingTokensJobs: action.isFetching);
}

ProWalletState _startFetchTokensLatestPrices(
    ProWalletState state, SetIsFetchTokensLatestPrices action) {
  return state.copyWith(isFetchTokensLatestPrice: action.isFetching);
}

ProWalletState _startFetchNewTokens(
    ProWalletState state, SetIsFetchNewTokens action) {
  return state.copyWith(isFetchNewTokens: action.isFetching);
}

ProWalletState _startFetchTransferEvents(
    ProWalletState state, SetIsFetchTransferEvents action) {
  return state.copyWith(isFetchTransferEvents: action.isFetching);
}

ProWalletState _startListenToTransferEventsSuccess(
    ProWalletState state, SetIsListenToTransferEvents action) {
  return state.copyWith(isListenToTransferEvents: action.isFetching);
}

ProWalletState _clearTokenList(ProWalletState state, ClearTokenList action) {
  Map<String, Token> newOne = Map<String, Token>.from(
      state.erc20Tokens!..removeWhere(clearTokensWithZero));
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _addNewToken(ProWalletState state, AddNewToken action) {
  Token token = action.token;
  Map<String, Token> newOne = Map<String, Token>.from(
      state.erc20Tokens!..removeWhere(clearTokensWithZero));
  if (newOne.containsKey(token.address)) {
    newOne[token.address] = newOne[token.address]!.copyWith(
      amount: token.amount,
      timestamp: token.timestamp,
    );
  } else if (!newOne.containsKey(token.address)) {
    newOne[token.address] = token;
  }
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _updateToken(ProWalletState state, UpdateToken action) {
  Map<String, Token> newOne = Map<String, Token>.from(state.erc20Tokens!);
  newOne[action.tokenToUpdate.address] = action.tokenToUpdate;
  return state.copyWith(erc20Tokens: newOne);
}

ProWalletState _startFetchTokensBalances(
    ProWalletState state, SetIsFetchTokensBalances action) {
  return state.copyWith(isFetchTokensBalances: action.isFetching);
}
