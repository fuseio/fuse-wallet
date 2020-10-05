import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/redux/reducers/pro_mode_reducer.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, AddCashTokens>(_addCashTokens),
  TypedReducer<CashWalletState, AddCashToken>(_addCashToken),
  TypedReducer<CashWalletState, SetDefaultCommunity>(_setDefaultCommunity),
  TypedReducer<CashWalletState, InitWeb3Success>(_initWeb3Success),
  TypedReducer<CashWalletState, GetTokenBalanceSuccess>(
      _getTokenBalanceSuccess),
  TypedReducer<CashWalletState, FetchCommunityMetadataSuccess>(
      _fetchCommunityMetadataSuccess),
  TypedReducer<CashWalletState, AlreadyJoinedCommunity>(
      _alreadyJoinedCommunity),
  TypedReducer<CashWalletState, ResetTokenTxs>(_resetTokensTxs),
  TypedReducer<CashWalletState, RefreshCommunityData>(_refreshCommunityData),
  TypedReducer<CashWalletState, SwitchCommunitySuccess>(
      _switchCommunitySuccess),
  TypedReducer<CashWalletState, SwitchCommunityFailed>(_switchCommunityFailed),
  TypedReducer<CashWalletState, GetBusinessListSuccess>(
      _getBusinessListSuccess),
  TypedReducer<CashWalletState, GetTokenTransfersListSuccess>(
      _getTokenTransfersListSuccess),
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
  TypedReducer<CashWalletState, InviteSendSuccess>(_inviteSendSuccess),
  TypedReducer<CashWalletState, CreateLocalAccountSuccess>(
      _createNewWalletSuccess),
  TypedReducer<CashWalletState, ReplaceTransaction>(_replaceTransfer),
  TypedReducer<CashWalletState, AddTransaction>(_addTransaction),
  TypedReducer<CashWalletState, StartFetchingBusinessList>(
      _startFetchingBusinessList),
  TypedReducer<CashWalletState, FetchingBusinessListSuccess>(
      _fetchingBusinessListSuccess),
  TypedReducer<CashWalletState, FetchingBusinessListFailed>(
      _fetchingBusinessListFailed),
  TypedReducer<CashWalletState, AddJob>(_addJob),
  TypedReducer<CashWalletState, JobDone>(_jobDone),
  TypedReducer<CashWalletState, UpdateJob>(_updateJob),
  TypedReducer<CashWalletState, SetIsJobProcessing>(_jobProcessingStarted)
]);

CashWalletState _addCashTokens(CashWalletState state, AddCashTokens action) {
  Map<String, Token> newOne =
      Map<String, Token>.from(state.tokens..removeWhere(clearTokensWithZero));
  for (String tokenAddress in action.tokens.keys) {
    if (newOne.containsKey(tokenAddress)) {
      newOne[tokenAddress] = newOne[tokenAddress]
          .copyWith(amount: action.tokens[tokenAddress].amount);
    } else {
      newOne[tokenAddress] = action.tokens[tokenAddress].copyWith();
    }
  }
  return state.copyWith(tokens: newOne);
}

CashWalletState _addCashToken(CashWalletState state, AddCashToken action) {
  Token token = action.token;
  Map<String, Token> newOne =
      Map<String, Token>.from(state.tokens..removeWhere(clearTokensWithZero));
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
  for (String communityAddress in newOne.keys) {
    newOne[communityAddress] =
        newOne[communityAddress].copyWith(transactions: Transactions.initial());
  }
  return state.copyWith(tokens: newOne);
}

CashWalletState _refreshCommunityData(
    CashWalletState state, RefreshCommunityData action) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community current = state.communities[communityAddress];
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[communityAddress] =
      current?.copyWith(plugins: action.plugins, webUrl: action.webUrl);
  return state.copyWith(communities: newOne);
}

CashWalletState _fetchCommunityMetadataSuccess(
    CashWalletState state, FetchCommunityMetadataSuccess action) {
  Community current = state.communities[action.communityAddress] ??
      Community.initial().copyWith(address: action.communityAddress);
  Community newCommunity = current?.copyWith(metadata: action.metadata);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[action.communityAddress] = newCommunity;
  return state.copyWith(communities: newOne);
}

CashWalletState _setDefaultCommunity(
    CashWalletState state, SetDefaultCommunity action) {
  Community current = new Community.initial();
  Community defaultCom = current.copyWith(address: action.defaultCommunity);
  Map<String, Community> newOne =
      Map<String, Community>.from(state.communities);
  newOne[action.defaultCommunity] = defaultCom;
  return state.copyWith(
      communityAddress: action.defaultCommunity,
      communities: newOne,
      branchAddress: '',
      isBranchDataReceived: false);
}

CashWalletState _initWeb3Success(
    CashWalletState state, InitWeb3Success action) {
  return state.copyWith(web3: action.web3);
}

CashWalletState _getTokenBalanceSuccess(
    CashWalletState state, GetTokenBalanceSuccess action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[action.tokenAddress];
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current.copyWith(amount: action.tokenBalance);
  return state.copyWith(tokens: newOne);
}

CashWalletState _alreadyJoinedCommunity(
    CashWalletState state, AlreadyJoinedCommunity action) {
  String communityAddress = action.communityAddress.toLowerCase();
  Community current = state.communities[communityAddress] ??
      Community.initial().copyWith(address: communityAddress);
  if (state.communities.containsKey(communityAddress) && !current.isMember) {
    Community newCommunity = current?.copyWith(isMember: true);
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  } else {
    return state;
  }
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
      communityAddress: communityAddress);
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
      Community.initial().copyWith(address: action.communityAddress);
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

CashWalletState _getTokenTransfersListSuccess(
    CashWalletState state, GetTokenTransfersListSuccess action) {
  final String tokenAddress = action.tokenAddress;
  if (action.tokenTransfers.length > 0) {
    dynamic maxBlockNumber = action.tokenTransfers.fold<int>(
            0, (max, e) => e.blockNumber > max ? e.blockNumber : max) +
        1;
    Token currentToken = state.tokens[tokenAddress];
    for (Transfer tx in action.tokenTransfers.reversed) {
      Transfer saved = currentToken.transactions?.list
          ?.firstWhere((t) => t.txHash == tx.txHash, orElse: () => null);
      if (saved != null) {
        int index = currentToken.transactions.list.indexOf(saved);
        currentToken.transactions.list[index] = tx.copyWith();
      } else {
        currentToken.transactions.list.add(tx);
      }
    }
    Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
    newOne[tokenAddress] = currentToken.copyWith(
        transactions: currentToken.transactions.copyWith(
            list: currentToken.transactions.list, blockNumber: maxBlockNumber));
    return state.copyWith(tokens: newOne);
  } else {
    return state;
  }
}

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
  Community newCommunity =
      new Community.initial().copyWith(address: communityAddress);
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

CashWalletState _addTransaction(CashWalletState state, AddTransaction action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[tokenAddress] ??
      Token.initial().copyWith(address: tokenAddress);

  Transaction saved = current?.transactions?.list?.firstWhere(
      (tx) => tx.jobId != null && tx.jobId == action.transaction.jobId,
      orElse: () => null);
  Transactions transactions;
  if (saved == null) {
    transactions = current?.transactions?.copyWith(
        list: (current?.transactions?.list ?? [])..add(action.transaction));
  } else {
    if (action.transaction.isPending()) {
      return state;
    }
    int index = (current?.transactions?.list ?? [])?.indexOf(saved);
    transactions = current.transactions.copyWith();
    transactions.list[index] = action.transaction;
  }
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = current?.copyWith(transactions: transactions);
  return state.copyWith(tokens: newOne);
}

CashWalletState _inviteSendSuccess(
    CashWalletState state, InviteSendSuccess action) {
  Token current = state.tokens[action.tokenAddress];
  dynamic invites = Map.from(current.transactions.invites);
  invites[action.invite.jobId] = action.invite;
  Token newCommunity = current.copyWith(
      transactions: current.transactions.copyWith(
          invites: invites,
          list: List.from(current.transactions.list)..add(action.invite)));
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[action.tokenAddress] = newCommunity;
  return state.copyWith(tokens: newOne);
}

CashWalletState _createNewWalletSuccess(
    CashWalletState state, CreateLocalAccountSuccess action) {
  return CashWalletState.initial().copyWith(
      isBranchDataReceived: state.isBranchDataReceived,
      branchAddress: state.branchAddress);
}

CashWalletState _replaceTransfer(
    CashWalletState state, ReplaceTransaction action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[tokenAddress];
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
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = newToken;
  return state.copyWith(tokens: newOne);
}

CashWalletState _addJob(CashWalletState state, AddJob action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[tokenAddress];
  Token newToken = current.copyWith(
      jobs: List<Job>.from(current?.jobs ?? [])..add(action.job));
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = newToken;
  return state.copyWith(tokens: newOne);
}

CashWalletState _jobDone(CashWalletState state, JobDone action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[tokenAddress];
  Token newCommunity = current.copyWith(
      jobs: List<Job>.from(current.jobs ?? [])..remove(action.job));
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = newCommunity;
  return state.copyWith(tokens: newOne);
}

CashWalletState _updateJob(CashWalletState state, UpdateJob action) {
  final String tokenAddress = action.tokenAddress;
  Token current = state.tokens[tokenAddress];
  Job job = current.jobs.firstWhere((element) => action.job.id == element.id);
  int index = current.jobs.indexOf(job);
  current.jobs[index] = action.job;
  Token newToken = current.copyWith(jobs: List<Job>.from(current.jobs ?? []));
  Map<String, Token> newOne = Map<String, Token>.from(state.tokens);
  newOne[tokenAddress] = newToken;
  return state.copyWith(tokens: newOne);
}

CashWalletState _jobProcessingStarted(
    CashWalletState state, SetIsJobProcessing action) {
  return state.copyWith(isJobProcessingStarted: action.isFetching);
}
