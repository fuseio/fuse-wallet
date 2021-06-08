import 'package:ethereum_address/ethereum_address.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/redux/reducers/pro_mode_reducer.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, GetTokenPriceDiffSuccess>(
      _getTokenPriceDiffSuccess),
  TypedReducer<CashWalletState, GetTokenStatsSuccess>(_getTokenStatsSuccess),
  TypedReducer<CashWalletState, GetTokenPriceChangeSuccess>(
      _getTokenPriceChangeSuccess),
  TypedReducer<CashWalletState, UpdateTokenPrice>(_updateTokenPrice),
  TypedReducer<CashWalletState, GetActionsSuccess>(_getActionsSuccess),
  TypedReducer<CashWalletState, GetTokenWalletActionsSuccess>(
      _getTokenWalletActionsSuccess),
  TypedReducer<CashWalletState, AddCashTokens>(_addCashTokens),
  TypedReducer<CashWalletState, AddCashToken>(_addCashToken),
  TypedReducer<CashWalletState, SetDefaultCommunity>(_setDefaultCommunity),
  TypedReducer<CashWalletState, GetTokenBalanceSuccess>(
      _getTokenBalanceSuccess),
  TypedReducer<CashWalletState, FetchCommunityMetadataSuccess>(
      _fetchCommunityMetadataSuccess),
  TypedReducer<CashWalletState, ResetTokenTxs>(_resetTokensTxs),
  TypedReducer<CashWalletState, RefreshCommunityData>(_refreshCommunityData),
  TypedReducer<CashWalletState, SwitchCommunitySuccess>(
      _switchCommunitySuccess),
  TypedReducer<CashWalletState, SwitchCommunityFailed>(_switchCommunityFailed),
  TypedReducer<CashWalletState, GetBusinessListSuccess>(
      _getBusinessListSuccess),
  TypedReducer<CashWalletState, SwitchCommunityRequested>(
      _switchCommunityRequest),
  TypedReducer<CashWalletState, SwitchToNewCommunity>(_switchToNewCommunity),
  TypedReducer<CashWalletState, BranchListening>(_branchListening),
  TypedReducer<CashWalletState, BranchListeningStopped>(
      _branchListeningStopped),
  TypedReducer<CashWalletState, BranchCommunityToUpdate>(
      _branchCommunityToUpdate),
  TypedReducer<CashWalletState, SetIsTransfersFetching>(
      _setIsTransfersFetching),
  TypedReducer<CashWalletState, CreateLocalAccountSuccess>(
      _createNewWalletSuccess),
  TypedReducer<CashWalletState, StartFetchingBusinessList>(
      _startFetchingBusinessList),
  TypedReducer<CashWalletState, FetchingBusinessListSuccess>(
      _fetchingBusinessListSuccess),
  TypedReducer<CashWalletState, FetchingBusinessListFailed>(
      _fetchingBusinessListFailed),
  TypedReducer<CashWalletState, SetIsFetchingBalances>(_setIsFetchingBalances),
  TypedReducer<CashWalletState, SetShowDepositBanner>(_setShowDepositBanner)
]);

CashWalletState _getTokenPriceDiffSuccess(
    CashWalletState state, GetTokenPriceDiffSuccess action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress];
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(
    priceDiff: action.priceDiff,
    priceDiffLimitInDays: action.priceDiffLimitInDays,
  );
  return state.copyWith(tokens: newOne);
}

CashWalletState _updateTokenPrice(
  CashWalletState state,
  UpdateTokenPrice action,
) {
  Token? token = state.tokens[action.tokenAddress];
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[token?.address] = token!.copyWith(priceInfo: action.price);
  return state.copyWith(tokens: newOne);
}

CashWalletState _getTokenWalletActionsSuccess(
  CashWalletState state,
  GetTokenWalletActionsSuccess action,
) {
  Token token = state.tokens[action.token.address];
  List<WalletAction> walletActions = token.walletActions.list ?? [];
  for (WalletAction walletAction in action.walletActions) {
    int savedIndex = walletActions?.indexWhere(
      (action) => action.id == walletAction.id,
    );
    if (savedIndex != -1) {
      walletActions[savedIndex] = walletAction;
    } else {
      walletActions?.add(walletAction);
    }
  }

  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[token.address] = token.copyWith(
    walletActions: WalletActions().copyWith(
      list: walletActions,
      updatedAt: action.updateAt + 1,
    ),
  );
  return state.copyWith(
    tokens: newOne,
  );
}

CashWalletState _getActionsSuccess(
  CashWalletState state,
  GetActionsSuccess action,
) {
  List<WalletAction> list = state?.walletActions?.list ?? [];
  for (WalletAction walletAction in action.walletActions) {
    int savedIndex = list?.indexWhere(
      (action) => action.id == walletAction.id,
    );
    if (savedIndex != -1) {
      list[savedIndex] = walletAction.copyWith();
    } else {
      list?.add(walletAction);
    }
  }
  return state.copyWith(
    walletActions: WalletActions().copyWith(
      list: list,
      updatedAt: action.updateAt + 1,
    ),
  );
}

CashWalletState _addCashTokens(CashWalletState state, AddCashTokens action) {
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne.removeWhere(clearTokensWithZero);
  for (String tokenAddress in action.tokens.keys) {
    if (newOne.containsKey(tokenAddress)) {
      newOne[tokenAddress] = newOne[tokenAddress]
          .copyWith(amount: action.tokens[tokenAddress].amount);
    } else {
      newOne[tokenAddress] = action.tokens[tokenAddress];
    }
  }
  return state.copyWith(tokens: newOne);
}

CashWalletState _addCashToken(CashWalletState state, AddCashToken action) {
  Token token = action.token;
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne.removeWhere(clearTokensWithZero);
  if (!newOne.containsKey(token.address)) {
    newOne[token.address] = token;
  } else {
    newOne[token.address] = newOne[token.address]
        .copyWith(name: token.name, communityAddress: token.communityAddress);
  }
  return state.copyWith(tokens: newOne);
}

CashWalletState _resetTokensTxs(CashWalletState state, ResetTokenTxs action) {
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  Map<String, Token> tokens = Map<String, Token>();
  final List<String> tokenAddresses = List<String>.from(
      newOne.keys.map((e) => e.toLowerCase()).toSet().toList());
  for (String tokenAddress in tokenAddresses) {
    final Token token =
        newOne.containsKey(checksumEthereumAddress(tokenAddress))
            ? newOne[checksumEthereumAddress(tokenAddress)]
            : newOne[tokenAddress];
    tokens[tokenAddress] = token.copyWith(
      walletActions: token.walletActions.copyWith(
        updatedAt: 0,
      ),
    );
  }
  return state.copyWith(
    tokens: tokens,
    walletActions: state.walletActions.copyWith(
      updatedAt: 0,
    ),
  );
}

CashWalletState _refreshCommunityData(
    CashWalletState state, RefreshCommunityData action) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community current = state.communities[communityAddress];
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = current?.copyWith(
    plugins: action.plugins,
    webUrl: action.webUrl,
  );
  return state.copyWith(communities: newOne);
}

CashWalletState _fetchCommunityMetadataSuccess(
    CashWalletState state, FetchCommunityMetadataSuccess action) {
  Community current = state.communities[action.communityAddress] ??
      Community(address: action.communityAddress);
  Community newCommunity = current?.copyWith(metadata: action.metadata);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[action.communityAddress] = newCommunity;
  return state.copyWith(communities: newOne);
}

CashWalletState _setDefaultCommunity(
    CashWalletState state, SetDefaultCommunity action) {
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[action.defaultCommunity] = Community(address: action.defaultCommunity);
  return state.copyWith(
    communityAddress: action.defaultCommunity,
    communities: newOne,
    branchAddress: '',
    walletActions: WalletActions.initial(),
    isBranchDataReceived: false,
  );
}

CashWalletState _getTokenBalanceSuccess(
    CashWalletState state, GetTokenBalanceSuccess action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress];
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(amount: action.tokenBalance);
  return state.copyWith(tokens: newOne);
}

CashWalletState _getTokenPriceChangeSuccess(
    CashWalletState state, GetTokenPriceChangeSuccess action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress];
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(priceChange: action.priceChange);
  return state.copyWith(tokens: newOne);
}

CashWalletState _getTokenStatsSuccess(
    CashWalletState state, GetTokenStatsSuccess action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress];
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(stats: action.stats);
  return state.copyWith(tokens: newOne);
}

CashWalletState _switchCommunitySuccess(
    CashWalletState state, SwitchCommunitySuccess action) {
  String communityAddress = action.community.address.toLowerCase();
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = action.community;
  return state.copyWith(
    isCommunityLoading: false,
    isCommunityFetched: true,
    communities: newOne,
    communityAddress: communityAddress,
  );
}

CashWalletState _switchCommunityFailed(
    CashWalletState state, SwitchCommunityFailed action) {
  Map<String, Community> newOne = Map<String, Community>.from(
      state.communities..remove(action.communityAddress.toLowerCase()));
  return state.copyWith(isCommunityLoading: false, communities: newOne);
}

CashWalletState _startFetchingBusinessList(
    CashWalletState state, StartFetchingBusinessList action) {
  return state.copyWith(isCommunityBusinessesFetched: true);
}

CashWalletState _getBusinessListSuccess(
    CashWalletState state, GetBusinessListSuccess action) {
  final String communityAddress = action.communityAddress;
  Community current = state.communities[communityAddress] ??
      Community(address: communityAddress);
  Community newCommunity = current?.copyWith(businesses: action?.businessList);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = newCommunity;
  return state.copyWith(communities: newOne);
}

CashWalletState _fetchingBusinessListSuccess(
    CashWalletState state, FetchingBusinessListSuccess action) {
  return state.copyWith(isCommunityBusinessesFetched: false);
}

CashWalletState _fetchingBusinessListFailed(
    CashWalletState state, FetchingBusinessListFailed action) {
  return state.copyWith(isCommunityBusinessesFetched: false);
}

// CashWalletState _getTokenTransfersListSuccess(
//     CashWalletState state, GetTokenTransfersListSuccess action) {
//   return state;
// final String tokenAddress = action.tokenAddress;
// if (action.tokenTransfers.isEmpty) {
//   return state;
// } else {
//   dynamic maxBlockNumber = action.tokenTransfers.fold<int>(
//           0,
//           (max, e) =>
//               (e.blockNumber ?? 0) > max ? (e.blockNumber ?? 0) : max) +
//       1;
//   Token currentToken = state.tokens[tokenAddress].copyWith();
//   for (Transaction tx in action.tokenTransfers.reversed) {
//     int savedIndex = currentToken?.transactions?.list?.indexWhere(
//       (t) => t.txHash == tx.txHash,
//     );
//     if (savedIndex != -1) {
//       currentToken?.transactions?.list[savedIndex] = tx.copyWith();
//     } else {
//       currentToken?.transactions?.list?.add(tx);
//     }
//   }
//   Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
//   newOne[tokenAddress] = currentToken
//     ..transactions.copyWith(blockNumber: maxBlockNumber);
//   return state.copyWith(tokens: newOne);
// }
// }

CashWalletState _switchCommunityRequest(
    CashWalletState state, SwitchCommunityRequested action) {
  return state.copyWith(
      isCommunityLoading: true,
      communityAddress: action.communityAddress.toLowerCase(),
      branchAddress: "",
      isBranchDataReceived: false);
}

CashWalletState _switchToNewCommunity(
    CashWalletState state, SwitchToNewCommunity action) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community newCommunity = Community(address: communityAddress);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] = newCommunity;
  return state.copyWith(
      branchAddress: "",
      isCommunityLoading: true,
      communities: newOne,
      isBranchDataReceived: false);
}

CashWalletState _branchCommunityToUpdate(
    CashWalletState state, BranchCommunityToUpdate action) {
  return state.copyWith(
      branchAddress: action.communityAddress, isBranchDataReceived: true);
}

CashWalletState _branchListening(
    CashWalletState state, BranchListening action) {
  return state.copyWith(isListeningToBranch: true);
}

CashWalletState _branchListeningStopped(
    CashWalletState state, BranchListeningStopped action) {
  return state.copyWith(isListeningToBranch: false);
}

CashWalletState _setIsTransfersFetching(
    CashWalletState state, SetIsTransfersFetching action) {
  return state.copyWith(isTransfersFetchingStarted: action.isFetching);
}

// CashWalletState _addTransaction(CashWalletState state, AddTransaction action) {
//   final String tokenAddress = action.tokenAddress;
//   Token current = state.tokens[tokenAddress] ?? Token(address: tokenAddress);

//   Transaction saved = current?.transactions?.list?.firstWhere(
//       (tx) => tx.jobId != null && tx.jobId == action.transaction.jobId,
//       );
//   Transactions transactions;
//   if (saved == null) {
//     transactions = current?.transactions?.copyWith(
//         list: (current?.transactions?.list ?? [])..add(action.transaction));
//   } else {
//     if (action.transaction.isPending()) {
//       return state;
//     }
//     int index = (current?.transactions?.list ?? [])?.indexOf(saved);
//     transactions = current.transactions.copyWith();
//     transactions.list[index] = action.transaction;
//   }
//   Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
//   newOne[tokenAddress] = current?.copyWith(transactions: transactions);
//   return state.copyWith(tokens: newOne);
// }

// CashWalletState _inviteSendSuccess(
//     CashWalletState state, InviteSendSuccess action) {
//   Token current = state.tokens[action.tokenAddress];
//   dynamic invites = Map.from(current.transactions.invites);
//   invites[action.invite.jobId] = action.invite;
//   Token newCommunity = current.copyWith(
//       transactions: current.transactions.copyWith(
//           invites: invites,
//           list: List.from(current.transactions.list)..add(action.invite)));
//   Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
//   newOne[action.tokenAddress] = newCommunity;
//   return state.copyWith(tokens: newOne);
// }

CashWalletState _createNewWalletSuccess(
    CashWalletState state, CreateLocalAccountSuccess action) {
  return CashWalletState(
    isBranchDataReceived: state.isBranchDataReceived,
    branchAddress: state.branchAddress,
  );
}

// CashWalletState _replaceTransfer(
//     CashWalletState state, ReplaceTransaction action) {
//   final String tokenAddress = action.tokenAddress;
//   Token current = state.tokens[tokenAddress];
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
//   Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
//   newOne[tokenAddress] = newToken;
//   return state.copyWith(tokens: newOne);
// }

// CashWalletState _jobProcessingStarted(
//     CashWalletState state, SetIsJobProcessing action) {
//   return state.copyWith(isJobProcessingStarted: action.isFetching);
// }

CashWalletState _setIsFetchingBalances(
    CashWalletState state, SetIsFetchingBalances action) {
  return state.copyWith(isFetchingBalances: action.isFetching);
}

CashWalletState _setShowDepositBanner(
    CashWalletState state, SetShowDepositBanner action) {
  return state.copyWith(
    isDepositBanner: false,
  );
}
