import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;

class StartFetchAccountAssets {
  StartFetchAccountAssets();
}

class StartListenToTransferEventsSuccess {
  StartListenToTransferEventsSuccess();
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

ThunkAction startListenToTransferEvents(String tokenAddress) {
  return (Store store) async {
     new Timer.periodic(Duration(seconds: 3), (Timer t) async {
      store.dispatch(getTransfersEventsOnForeign());
    });
    store.dispatch(new StartListenToTransferEventsSuccess());
  };
}

ThunkAction getTransfersEventsOnForeign() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      final String daiToken = '0x6B175474E89094C44Da98b954EedeAC495271d0F';
      String walletAddress = store.state.userState.walletAddress;
      String foreignNetwork = DotEnv().env['MODE'] == 'production' ? 'mainnet' : 'ropsten';
      dynamic transfersEvents = graph.getTransfersEventsOnForeign(
        foreignNetwork: foreignNetwork,
        to: walletAddress,
        tokenAddress: daiToken
      );
      List<dynamic> trasnfers = List.from(transfersEvents);
      if (trasnfers != null && trasnfers.isNotEmpty) {
        print('transfersEvents transfersEvents transfersEvents transfersEvents');
        print(transfersEvents);
        // List<Transfer> transfers = List<Transfer>.from(response.map((json) => Transfer.fromJson(json)).toList());
        // store.dispatch(new GetTokenTransfersListSuccess(transfers));
        dynamic walletData = await api.getWallet();
        String communityManager = walletData['communityManager'];
        String transferManager = walletData['transferManager'];
        List<String> networks = List<String>.from(walletData['networks']);
        store.dispatch(new GetWalletAddressesSuccess(walletAddress: walletAddress, communityManagerAddress: communityManager, transferManagerAddress: transferManager, networks: networks));
        bool isForeignDeployed = networks.contains(foreignNetwork);
        if (!isForeignDeployed) {
          await api.createWalletOnForeign();
        }
      }
    } catch (error, stackTrace) {
      logger.severe(error);
      await AppFactory().reportError(error, stackTrace);
    }
  };
}

ThunkAction getTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      ProWalletState walletState = store.state.proWalletState;
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
