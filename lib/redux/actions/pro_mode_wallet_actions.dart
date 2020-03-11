// import 'dart:async';

import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;

class StartFetchAccountAssets {
  StartFetchAccountAssets();
}

class GetAssetsListSuccess {
  List<Transfer> tokenTransfers;
  GetAssetsListSuccess(this.tokenTransfers);
}

class StartFetchAssetsBalances {
  StartFetchAssetsBalances();
}

class GetTokenTransfersListSuccess {
  List<Transfer> tokenTransfers;
  GetTokenTransfersListSuccess(this.tokenTransfers);
}

ThunkAction getTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      ProWalletState walletState = store.state.proWalletState;
      String walletAddress = walletState.walletAddress;
      wallet_core.Web3 web3 = walletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      num lastBlockNumber = walletState.transactions.blockNumber;
      num currentBlockNumber = await web3.getBlockNumber();
      Map<String, dynamic> response = await graph.getTransfers(
          walletAddress, tokenAddress,
          fromBlockNumber: lastBlockNumber, toBlockNumber: currentBlockNumber);
      List<Transfer> transfers = List<Transfer>.from(
          response["data"].map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(new GetTokenTransfersListSuccess(transfers));
    } catch (e) {
      logger.severe('ERROR - getTokenTransfersListCall $e');
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction startFetchAssetsBalancesCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    logger.info('Start Transfers Fetching Call');
    // if (tokenAddress != null) {
    //   store.dispatch(getTokenTransfersListCall(tokenAddress));
    //   store.dispatch(getTokenBalanceCall(tokenAddress));
    // }
    // new Timer.periodic(Duration(seconds: 3), (Timer t) async {
    //   if (store.state.cashWalletState.walletAddress == '') {
    //     t.cancel();
    //     return;
    //   }
    //   String communityAddres = store.state.cashWalletState.communityAddress;
    //   Community community =
    //       store.state.cashWalletState.communities[communityAddres];
    //   String tokenAddress = community.token?.address;
    //   if (tokenAddress != null) {
    //     store.dispatch(getReceivedTokenTransfersListCall(tokenAddress));
    //   }
    // });
    // store.dispatch(new StartTransfersFetchingSuccess());
  };
}

ThunkAction getReceivedTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    // final logger = await AppFactory().getLogger('action');
    // try {
    //   String communityAddres = store.state.cashWalletState.communityAddress;
    //   Community community =
    //       store.state.cashWalletState.communities[communityAddres];
    //   String walletAddress = store.state.cashWalletState.walletAddress;
    //   num lastBlockNumber = community.transactions.blockNumber;
    //   num currentBlockNumber =
    //       await store.state.cashWalletState.web3.getBlockNumber();
    //   Map<String, dynamic> response = await graph.getReceivedTransfers(
    //       walletAddress, tokenAddress,
    //       fromBlockNumber: lastBlockNumber, toBlockNumber: currentBlockNumber);
    //   List<Transfer> transfers = List<Transfer>.from(
    //       response["data"].map((json) => Transfer.fromJson(json)).toList());
    //   if (transfers.isNotEmpty) {
    //     store.dispatch(new GetTokenTransfersListSuccess(transfers));
    //     store.dispatch(getTokenBalanceCall(tokenAddress));
    //   }
    // } catch (e) {
    //   logger.severe('ERROR - getReceivedTokenTransfersListCall $e');
    //   store.dispatch(new ErrorAction('Could not get token transfers'));
    // }
  };
}
