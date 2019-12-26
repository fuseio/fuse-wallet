import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, SetDefaultCommunity>(_setDefaultCommunity),
  TypedReducer<CashWalletState, InitWeb3Success>(_initWeb3Success),
  TypedReducer<CashWalletState, GetWalletAddressSuccess>(
      _getWalletAddressSuccess),
  TypedReducer<CashWalletState, CreateAccountWalletRequest>(
      _createAccountWalletRequest),
  TypedReducer<CashWalletState, CreateAccountWalletSuccess>(
      _createAccountWalletSuccess),
  TypedReducer<CashWalletState, GetTokenBalanceSuccess>(
      _getTokenBalanceSuccess),
  TypedReducer<CashWalletState, SendTokenSuccess>(_sendTokenSuccess),
  TypedReducer<CashWalletState, JoinCommunitySuccess>(_joinCommunitySuccess),
  TypedReducer<CashWalletState, AlreadyJoinedCommunity>(
      _alreadyJoinedCommunity),
  TypedReducer<CashWalletState, SwitchCommunitySuccess>(
      _switchCommunitySuccess),
  TypedReducer<CashWalletState, SwitchCommunityFailed>(_switchCommunityFailed),
  TypedReducer<CashWalletState, GetJoinBonusSuccess>(_getJoinBonusSuccess),
  TypedReducer<CashWalletState, GetBusinessListSuccess>(
      _getBusinessListSuccess),
  TypedReducer<CashWalletState, GetTokenTransfersListSuccess>(
      _getTokenTransfersListSuccess),
  TypedReducer<CashWalletState, LogoutRequestSuccess>(_logoutSuccess),
  TypedReducer<CashWalletState, SwitchCommunityRequested>(
      _switchCommunityRequest),
  TypedReducer<CashWalletState, BranchListening>(_branchListening),
  TypedReducer<CashWalletState, BranchCommunityUpdate>(_branchCommunityUpdate),
  TypedReducer<CashWalletState, BranchCommunityToUpdate>(
      _branchCommunityToUpdate),
  TypedReducer<CashWalletState, StartBalanceFetchingSuccess>(
      _startBalanceFetchingSuccess),
  TypedReducer<CashWalletState, StartTransfersFetchingSuccess>(
      _startTransfersFetchingSuccess),
  TypedReducer<CashWalletState, TransferSendRequested>(_transferSendRequested),
  TypedReducer<CashWalletState, TransferSendSuccess>(_transferSendSuccess),
  TypedReducer<CashWalletState, TransferJobSuccess>(_transferJobSuccess),
  TypedReducer<CashWalletState, AddSendToInvites>(_addSendToInvites),
  TypedReducer<CashWalletState, RemoveSendToInvites>(_removeSendToInvites),
  TypedReducer<CashWalletState, BusinessesLoadedAction>(
      _businessesLoadedAction),
  TypedReducer<CashWalletState, CreateLocalAccountSuccess>(
      _createNewWalletSuccess),
]);

CashWalletState _setDefaultCommunity(
    CashWalletState state, SetDefaultCommunity action) {
  return state.copyWith(communityAddress: action.defaultCommunity);
}

CashWalletState _initWeb3Success(
    CashWalletState state, InitWeb3Success action) {
  return state.copyWith(web3: action.web3);
}

CashWalletState _getWalletAddressSuccess(
    CashWalletState state, GetWalletAddressSuccess action) {
  return state.copyWith(
      walletAddress: action.walletAddress, walletStatus: 'created');
}

CashWalletState _createAccountWalletRequest(
    CashWalletState state, CreateAccountWalletRequest action) {
  return state.copyWith(walletStatus: 'requested');
}

CashWalletState _createAccountWalletSuccess(
    CashWalletState state, CreateAccountWalletSuccess action) {
  return state.copyWith(walletStatus: 'deploying');
}

CashWalletState _getTokenBalanceSuccess(
    CashWalletState state, GetTokenBalanceSuccess action) {
  if (state.walletAddress != '') {
    return state.copyWith(tokenBalance: action.tokenBalance);
  } else {
    return state;
  }
}

CashWalletState _sendTokenSuccess(
    CashWalletState state, SendTokenSuccess action) {
  print('send token - ${action.txHash} sent');
  return state;
}

CashWalletState _joinCommunitySuccess(
    CashWalletState state, JoinCommunitySuccess action) {
  print('join community ${action.communityAddress} - ${action.txHash} sent');
  return state.copyWith(
      communityAddress: action.communityAddress,
      communityName: action.communityName,
      token: action.token);
}

CashWalletState _alreadyJoinedCommunity(
    CashWalletState state, AlreadyJoinedCommunity action) {
  return state.copyWith(
      communityAddress: action.communityAddress,
      communityName: action.communityName,
      token: action.token);
}

CashWalletState _switchCommunitySuccess(
    CashWalletState state, SwitchCommunitySuccess action) {
  return state.copyWith(
      communityAddress: action.communityAddress,
      communityName: action.communityName,
      token: action.token,
      isCommunityLoading: false,
      isCommunityFetched: true);
}

CashWalletState _switchCommunityFailed(
    CashWalletState state, SwitchCommunityFailed action) {
  return state.copyWith(isCommunityLoading: false);
}

CashWalletState _getJoinBonusSuccess(
    CashWalletState state, GetJoinBonusSuccess action) {
  // TODO
}

CashWalletState _getBusinessListSuccess(
    CashWalletState state, GetBusinessListSuccess action) {
  // TODO
}

CashWalletState _getTokenTransfersListSuccess(
    CashWalletState state, GetTokenTransfersListSuccess action) {
  print('Found ${action.tokenTransfers.length} token transfers');
  if (state.walletAddress != '' && action.tokenTransfers.length > 0) {
    dynamic maxBlockNumber = action.tokenTransfers.fold<int>(
            0, (max, e) => e.blockNumber > max ? e.blockNumber : max) +
        1;

    for (Transaction tx in action.tokenTransfers.reversed) {
      Transaction saved = state.transactions.list
          .firstWhere((t) => t.txHash == tx.txHash, orElse: () => null);
      if (saved != null) {
        if (saved.isPending()) {
          saved.status = 'CONFIRMED';
        }
      } else {
        state.transactions.list.add(tx);
      }
    }

    return state.copyWith(
        transactions: state.transactions.copyWith(
            list: state.transactions.list, blockNumber: maxBlockNumber));
  } else {
    return state;
  }
}

CashWalletState _logoutSuccess(
    CashWalletState state, LogoutRequestSuccess action) {
  return state;
  // return CashWalletState.initial();
}

CashWalletState _switchCommunityRequest(
    CashWalletState state, SwitchCommunityRequested action) {
  if (state.communityAddress != action.communityAddress) {
    return state.copyWith(
        isCommunityLoading: true,
        token: null,
        transactions: new Transactions(list: new List<Transaction>()),
        tokenBalance: BigInt.from(0));
  } else {
    return state.copyWith(
      isCommunityLoading: true,
    );
  }
}

CashWalletState _branchCommunityUpdate(
    CashWalletState state, BranchCommunityUpdate action) {
  return state.copyWith(
      isCommunityLoading: false,
      isCommunityFetched: false,
      branchAddress: "",
      communityAddress: state.branchAddress);
}

CashWalletState _branchCommunityToUpdate(
    CashWalletState state, BranchCommunityToUpdate action) {
  return state.copyWith(branchAddress: action.communityAddress);
}

CashWalletState _branchListening(
    CashWalletState state, BranchListening action) {
  return state.copyWith(isListeningToBranch: true);
}

CashWalletState _startBalanceFetchingSuccess(
    CashWalletState state, StartBalanceFetchingSuccess action) {
  return state.copyWith(isBalanceFetchingStarted: true);
}

CashWalletState _startTransfersFetchingSuccess(
    CashWalletState state, StartTransfersFetchingSuccess action) {
  return state.copyWith(isTransfersFetchingStarted: true);
}

CashWalletState _transferSendSuccess(
    CashWalletState state, TransferSendSuccess action) {
  return state.copyWith(
      transactions: state.transactions
          .copyWith(list: state.transactions.list..add(action.transfer)));
}

CashWalletState _transferSendRequested(
    CashWalletState state, TransferSendRequested action) {
  return state.copyWith(
      transactions: state.transactions.copyWith(
          list: List.from(state.transactions.list)..add(action.transfer)));
}

CashWalletState _transferJobSuccess(
    CashWalletState state, TransferJobSuccess action) {
  Transfer transfer = state.transactions.list
      .firstWhere((transfer) => transfer.jobId == action.job.id);
  if (transfer.txHash == action.job.data["txHash"]) {
    print('txhash already exists $transfer.txHash');
    return state;
  }

  dynamic json = transfer.toJson();
  json['txHash'] = action.job.data["txHash"];
  print('txHash to delete ${transfer.jobId}');
  Transfer newTransfer = Transfer.fromJson(json);

  List<Transaction> nList = List.from(state.transactions.list);

  // remove Transfer with txHash if it was received before the job
  nList.removeWhere((transfer) => transfer.txHash == action.job.data["txHash"]);

  nList
    ..add(newTransfer)
    ..remove(transfer);

  return state.copyWith(transactions: state.transactions.copyWith(list: nList));
}

CashWalletState _addSendToInvites(
    CashWalletState state, AddSendToInvites action) {
  Map<String, num> sendToInvites = state.sendToInvites;
  sendToInvites[action.jobId] = action.amount;
  return state.copyWith(sendToInvites: sendToInvites);
}

CashWalletState _removeSendToInvites(
    CashWalletState state, RemoveSendToInvites action) {
  Map<String, num> sendToInvites = state.sendToInvites;
  sendToInvites.remove(action.jobId);
  return state.copyWith(sendToInvites: sendToInvites);
}

CashWalletState _businessesLoadedAction(
    CashWalletState state, BusinessesLoadedAction action) {
  return state.copyWith(businesses: action.businessList);
}

CashWalletState _createNewWalletSuccess(
    CashWalletState state, CreateLocalAccountSuccess action) {
  return CashWalletState.initial();
}
