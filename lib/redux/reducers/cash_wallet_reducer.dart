import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:redux/redux.dart';

final cashWalletReducers = combineReducers<CashWalletState>([
  TypedReducer<CashWalletState, SetDefaultCommunity>(_setDefaultCommunity),
  TypedReducer<CashWalletState, InitWeb3Success>(_initWeb3Success),
  TypedReducer<CashWalletState, GetWalletAddressesSuccess>(
      _getWalletAddressesSuccess),
  TypedReducer<CashWalletState, CreateAccountWalletRequest>(
      _createAccountWalletRequest),
  TypedReducer<CashWalletState, CreateAccountWalletSuccess>(_createAccountWalletSuccess),
  TypedReducer<CashWalletState, GetTokenBalanceSuccess>(
      _getTokenBalanceSuccess),
  TypedReducer<CashWalletState, SendTokenSuccess>(_sendTokenSuccess),
  TypedReducer<CashWalletState, JoinCommunitySuccess>(_joinCommunitySuccess),
  TypedReducer<CashWalletState, FetchCommunityMetadataSuccess>(_fetchCommunityMetadataSuccess),
  TypedReducer<CashWalletState, AlreadyJoinedCommunity>(
      _alreadyJoinedCommunity),
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
  TypedReducer<CashWalletState, BranchListeningStopped>(_branchListeningStopped),
  TypedReducer<CashWalletState, BranchDataReceived>(_branchDataReceived),
  TypedReducer<CashWalletState, BranchCommunityUpdate>(_branchCommunityUpdate),
  TypedReducer<CashWalletState, BranchCommunityToUpdate>(
      _branchCommunityToUpdate),
  TypedReducer<CashWalletState, StartBalanceFetchingSuccess>(
      _startBalanceFetchingSuccess),
  TypedReducer<CashWalletState, StartTransfersFetchingSuccess>(
      _startTransfersFetchingSuccess),
  TypedReducer<CashWalletState, TransferSendSuccess>(_transferSendSuccess),
  TypedReducer<CashWalletState, InviteSendSuccess>(_inviteSendSuccess),
  TypedReducer<CashWalletState, TransferJobSuccess>(_transferJobSuccess),
  TypedReducer<CashWalletState, AddSendToInvites>(_addSendToInvites),
  TypedReducer<CashWalletState, RemoveSendToInvites>(_removeSendToInvites),
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
    TypedReducer<CashWalletState, JobProcessingStarted>(_jobProcessingStarted)
  ]);

  CashWalletState _fetchCommunityMetadataSuccess(
    CashWalletState state, FetchCommunityMetadataSuccess action) {
    String communityAddress = state.communityAddress;
    Community current = state.communities[communityAddress];
    Community newCommunity = current.copyWith(metadata: action.metadata);
    Map<String, Community> newOne = Map<String, Community>.from(state.communities);
    newOne[communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }

  CashWalletState _setDefaultCommunity(
      CashWalletState state, SetDefaultCommunity action) {
    String defaultCommunityAddress = action.defaultCommunity.toLowerCase();
    Community current = new Community.initial();
    Community defaultCom = current.copyWith(address: defaultCommunityAddress);
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[defaultCommunityAddress] = defaultCom;
    return state.copyWith(
        communityAddress: defaultCommunityAddress, communities: newOne);
  }
  
  CashWalletState _initWeb3Success(
      CashWalletState state, InitWeb3Success action) {
    return state.copyWith(web3: action.web3);
  }
  
  CashWalletState _getWalletAddressesSuccess(
      CashWalletState state, GetWalletAddressesSuccess action) {
    return state.copyWith(
        walletAddress: action.walletAddress,
        transferManagerAddress: action.transferManagerAddress,
        communityManagerAddress: action.communityManagerAddress,
        walletStatus: 'created');
  }
  
  CashWalletState _createAccountWalletRequest(
      CashWalletState state, CreateAccountWalletRequest action) {
    return state.copyWith(walletStatus: 'requested');
  }
  
  CashWalletState _createAccountWalletSuccess(CashWalletState state, CreateAccountWalletSuccess action) {
    return state.copyWith(walletStatus: 'deploying');
  }
  
  CashWalletState _getTokenBalanceSuccess(
      CashWalletState state, GetTokenBalanceSuccess action) {
    if (state.walletAddress != '') {
      Community current = state.communities[state.communityAddress];
      Community newCommunity =
          current.copyWith(tokenBalance: action.tokenBalance);
      Map<String, Community> newOne =
          Map<String, Community>.from(state.communities);
      newOne[state.communityAddress] = newCommunity;
      return state.copyWith(communities: newOne);
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
    String communityAddress = action.communityAddress.toLowerCase();
    print('join community ${action.communityAddress} - ${action.txHash} sent');
    Community current = state.communities[communityAddress];
    Community newCommunity = current.copyWith(isMember: true);
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }
  
  CashWalletState _alreadyJoinedCommunity(
      CashWalletState state, AlreadyJoinedCommunity action) {
    String communityAddress = action.communityAddress.toLowerCase();
    Community current = state.communities[communityAddress];
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
    String communityAddress = action.communityAddress.toLowerCase();
    Community current = state.communities[communityAddress];
    Community newCommunity = current.copyWith(
      plugins: action.plugins,
      token: action.token,
      name: action.communityName,
      isClosed: action.isClosed,
      homeBridgeAddress: action.homeBridgeAddress,
      foreignBridgeAddress: action.foreignBridgeAddress
    );
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[communityAddress] = newCommunity;
    return state.copyWith(
      isCommunityLoading: false,
      isCommunityFetched: true,
      communities: newOne,
    );
  }
  
  CashWalletState _switchCommunityFailed(
      CashWalletState state, SwitchCommunityFailed action) {
    return state.copyWith(isCommunityLoading: false);
  }
  
  CashWalletState _startFetchingBusinessList(
      CashWalletState state, StartFetchingBusinessList action) {
    return state.copyWith(isCommunityBusinessesFetched: true);
  }
  
  CashWalletState _getBusinessListSuccess(
      CashWalletState state, GetBusinessListSuccess action) {
    Community current = state.communities[state.communityAddress];
    Community newCommunity = current.copyWith(businesses: action.businessList);
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
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
    print('Found ${action.tokenTransfers.length} token transfers');
    bool isLoading = state.isCommunityLoading ?? false;
    if (isLoading) return state;
    if (state.walletAddress != '' && action.tokenTransfers.length > 0) {
      dynamic maxBlockNumber = action.tokenTransfers.fold<int>(
              0, (max, e) => e.blockNumber > max ? e.blockNumber : max) +
          1;
      Community current = state.communities[state.communityAddress];
      for (Transfer tx in action.tokenTransfers.reversed) {
        Transfer saved = current.transactions.list
            .firstWhere((t) => t.txHash == tx.txHash, orElse: () => null);
        if (saved != null) {
          if (saved.isPending()) {
            saved.status = 'CONFIRMED';
          }
        } else {
          current.transactions.list.add(tx);
        }
      }
      Community newCommunity = current.copyWith(
          transactions: current.transactions.copyWith(
              list: current.transactions.list, blockNumber: maxBlockNumber));
      Map<String, Community> newOne =
          Map<String, Community>.from(state.communities);
      newOne[state.communityAddress] = newCommunity;
      return state.copyWith(communities: newOne);
    } else {
      return state;
    }
  }

  CashWalletState _switchCommunityRequest(
      CashWalletState state, SwitchCommunityRequested action) {
    return state.copyWith(
        isCommunityLoading: true,
        communityAddress: action.communityAddress.toLowerCase(),
        branchAddress: "");
  }

  CashWalletState _switchToNewCommunity(
      CashWalletState state, SwitchToNewCommunity action) {
    String communityAddress = action.communityAddress.toLowerCase();
    Community newCommunity = new Community.initial().copyWith(address: communityAddress);
    Map<String, Community> newOne = Map<String, Community>.from(state.communities);
    newOne[communityAddress] = newCommunity;
    return state.copyWith(
        branchAddress: "",
        isCommunityLoading: true,
        communityAddress: communityAddress,
        communities: newOne);
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

  CashWalletState _branchListeningStopped(
      CashWalletState state, BranchListeningStopped action) {
    return state.copyWith(isListeningToBranch: false);
  }
  
  CashWalletState _branchDataReceived(
      CashWalletState state, BranchDataReceived action) {
    return state.copyWith(isBranchDataReceived: true);
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
    Community current = state.communities[state.communityAddress];
    Community newCommunity = current.copyWith(
        transactions: current.transactions
            .copyWith(list: current.transactions.list..add(action.transfer)));
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }
  
  CashWalletState _addTransaction(CashWalletState state, AddTransaction action) {
    Community current = state.communities[state.communityAddress];

    Transaction saved = current.transactions.list.firstWhere((tx) => tx.jobId != null && tx.jobId == action.transaction.jobId, orElse: () => null);
    Transactions transactions;
    if (saved == null) {
      transactions = current.transactions.copyWith(list: current.transactions.list..add(action.transaction));
    } else {
      if (action.transaction.isPending()) {
        return state;
      }
      int index = current.transactions.list.indexOf(saved);
      transactions = current.transactions.copyWith();
      transactions.list[index] = action.transaction;
    }
    Community newCommunity = current.copyWith(
          transactions: transactions
    );
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }

  CashWalletState _inviteSendSuccess(
      CashWalletState state, InviteSendSuccess action) {
    Community current = state.communities[state.communityAddress];
    dynamic invites = Map.from(current.transactions.invites);
    invites[action.invite.jobId] = action.invite;
    Community newCommunity = current.copyWith(
        transactions: current.transactions.copyWith(
            invites: invites,
            list: List.from(current.transactions.list)..add(action.invite)));
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }
  
  CashWalletState _transferJobSuccess(
      CashWalletState state, TransferJobSuccess action) {
    Community current = state.communities[state.communityAddress];
    Transfer transfer = current.transactions.list
        .firstWhere((transfer) => transfer.jobId == action.job.id);
    if (transfer.txHash == action.job.data["txHash"]) {
      print('txhash already exists $transfer.txHash');
      return state;
    }
  
    dynamic json = transfer.toJson();
    json['txHash'] = action.job.data["txHash"];
    print('txHash to delete ${transfer.jobId}');
    Transfer newTransfer = Transfer.fromJson(json);
  
    List<Transaction> nList = List.from(current.transactions.list);
  
    // remove Transfer with txHash if it was received before the job
    nList.removeWhere((transfer) => transfer.txHash == action.job.data["txHash"]);
  
    nList
      ..add(newTransfer)
      ..remove(transfer);
    Community newCommunity = current.copyWith(
        transactions: current.transactions.copyWith(list: nList));
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
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
  
  CashWalletState _createNewWalletSuccess(
      CashWalletState state, CreateLocalAccountSuccess action) {
    return CashWalletState.initial().copyWith(isBranchDataReceived: state.isBranchDataReceived);
  }
  
  CashWalletState _replaceTransfer(CashWalletState state, ReplaceTransaction action) {
    Community current = state.communities[state.communityAddress];
    List<Transaction> oldTxs = List<Transaction>.from(current.transactions.list.where((tx) =>
      (tx.jobId != null && tx.jobId == action.transaction.jobId) ||
      (tx.txHash != null && tx.txHash == action.transaction.txHash) ||
      (tx.jobId != null && tx.jobId == action.transactionToReplace.jobId) ||
      (tx.txHash != null && tx.txHash == action.transactionToReplace.txHash)
    ));
    if (oldTxs.isEmpty) {
      return state;
    }
    int index = current.transactions.list.indexOf(oldTxs[0]);
    current.transactions.list[index] = action.transactionToReplace;
    oldTxs.removeAt(0);
    current.transactions.list.removeWhere((tx) => oldTxs.contains(tx));
    Community newCommunity = current.copyWith(
        transactions:
            current.transactions.copyWith(list: current.transactions.list));
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }
  
  CashWalletState _addJob(CashWalletState state, AddJob action) {
    Community current = state.communities[state.communityAddress];
    Community newCommunity =
        current.copyWith(jobs: List<Job>.from(current.jobs)..add(action.job));
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }
  
  CashWalletState _jobDone(CashWalletState state, JobDone action) {
    Community current = state.communities[state.communityAddress];
    Community newCommunity =
        current.copyWith(jobs: List<Job>.from(current.jobs)..remove(action.job));
    Map<String, Community> newOne =
        Map<String, Community>.from(state.communities);
    newOne[state.communityAddress] = newCommunity;
    return state.copyWith(communities: newOne);
  }
  
  CashWalletState _jobProcessingStarted(
      CashWalletState state, JobProcessingStarted action) {
    return state.copyWith(isJobProcessingStarted: true);
  }
