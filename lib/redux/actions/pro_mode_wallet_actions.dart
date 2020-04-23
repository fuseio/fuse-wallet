import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:local_champions/models/pro/token.dart';
import 'package:local_champions/models/transactions/transfer.dart';
import 'package:local_champions/redux/state/store.dart';
import 'package:local_champions/services.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;

Future<bool> approvalCallback() async {
  return true;
}

class StartFetchAccountAssets {
  StartFetchAccountAssets();
}

class UpadteBlockNumber {
  final num blockNumber;
  UpadteBlockNumber({this.blockNumber});
}

class AddToken {
  Token token;
  AddToken({this.token});
}

class UpdateToken {
  Token token;
  Token tokenToUpdate;
  UpdateToken({this.token, this.tokenToUpdate});
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

class InitWeb3ProModeSuccess {
  final wallet_core.Web3 web3;
  InitWeb3ProModeSuccess({this.web3});
}

ThunkAction initWeb3ProMode() {
  return (Store store) async {

    wallet_core.Web3 web3 = new wallet_core.Web3(approvalCallback,
      networkId: int.parse(DotEnv().env['FOREIGN_NETWORK_ID']),
      url: DotEnv().env['FOREIGN_PROVIDER_URL']
    );
    String privateKey = store.state.userState.privateKey;
    await web3.setCredentials(privateKey);
    store.dispatch(new InitWeb3ProModeSuccess(web3: web3));
  };
}

ThunkAction startListenToTransferEvents() {
  return (Store store) async {
    new Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      store.dispatch(getAccountTokens());
    });
    store.dispatch(new StartListenToTransferEventsSuccess());
  };
}

ThunkAction getAccountTokens() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      dynamic response = await graph.getAccountTokens(walletAddress);
      List<dynamic> accounts = List<dynamic>.from(response);
      if (accounts.isNotEmpty) {
        Map<String, dynamic> accountsBalances = Map<String, dynamic>.from(accounts[0]);
        List<dynamic> balances = List<dynamic>.from(accountsBalances['balances']);
        await Future.forEach(balances, (dynamic balanceInfo) async {
          dynamic tokenDetails = balanceInfo['token'];
          num amount = num.parse(balanceInfo['amount']);
          Token token = new Token(
            symbol: tokenDetails['symbol'],
            address: tokenDetails['address'],
            name: tokenDetails['name'],
            imageUrl: tokenDetails['imageUrl'],
            decimals: tokenDetails['decimals'],
            amount: amount,
          );
          store.dispatch(AddToken(token: token));
        });
      }
    } catch (error) {
      logger.severe(error);
      // await AppFactory().reportError(error, stackTrace);
    }
  };
}
