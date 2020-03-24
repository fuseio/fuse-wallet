import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/screens/cash_home/prize.dart';
import 'package:fusecash/services.dart';
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
        url: DotEnv().env['FOREIGN_PROVIDER_URL']);
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

// Get a list of "ERC20 - Token Transfer Events" by Address
ThunkAction getTokenTransfersEvents() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      // String apiKey = DotEnv().env['ETHERSCAN_API_KEY'];
      // String walletAddress = store.state.userState.walletAddress;
      // dynamic response = await client.get('http://api.etherscan.io/api?module=account&action=tokentx&address=$walletAddress&startblock=0&endblock=999999999&page=1&offset=100&sort=desc&apikey=$apiKey');
      // List<dynamic> tokensTransferEvents = List<dynamic>.from(response['result']);
      // List<String> tokensAddresses = tokensTransferEvents
      //     .map((dynamic transferEvents) => (transferEvents['contractAddress'] as String).toLowerCase())
      //     .toList()
      //     .toSet()
      //     .toList();

      // List<Token> tokens = store.state.proWalletState.tokens;
      // List<String> tokensAddresses = tokens.map((token) => token.address.toLowerCase());
      // await Future.forEach(tokensAddresses, (String tokenAddress) async {
        // dynamic response = await client.get('https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=$tokenAddress&address=$walletAddress&page=1&offset=100&sort=desc&apikey=$apiKey');
        // List<dynamic> transferEventsOfToken = List<dynamic>.from(response['result']);
        // Token tokenToUpdate = tokens.firstWhere((token) => token.address.toLowerCase() == tokenAddress);
        // Token newToken = tokenToUpdate.copyWith();
        
        // dynamic a = transferEventsOfToken.map((transferEvent) {
        //   if (newToken.transactions.list.any((Transaction element) => element.txHash.toLowerCase() != transferEvent['0x6a03e900c0d78d2e29cf8e7fa6453dea53e8902146c05f1987a2ae2f2bd7de24'])) {
            
        //   }
        // });
        // Transactions transactions = newToken.transactions;


        // store.dispatch(UpdateToken());
      // });
      // await Future.forEach(uniqueContracts, (dynamic transferEvents) {
      //   String tokenAddress = transferEvents['contractAddress'];
      //   dynamic amountResponse = client.get('https://api.etherscan.io/api?module=account&action=tokenbalance&contractaddress=$tokenAddress&address=$walletAddress&tag=latest&apikey=$apiKey');
      //   BigInt amount = BigInt.from(num.parse(amountResponse['result']));
      //   tokens.add(Token(
      //     decimals: transferEvents['decimals'],
      //     imageUrl: transferEvents['imageUrl'],
      //     name: transferEvents['name'],
      //     address: transferEvents['address'],
      //     amount: amount,
      //     symbol: transferEvents['symbol'],
      //   ));
      // });
    } catch (e) {
      logger.severe(e);
    }
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
        String apiKey = DotEnv().env['ETHERSCAN_API_KEY'];
        Map<String, dynamic> accountsBalances = Map<String, dynamic>.from(accounts[0]);
        List<dynamic> balances = List<dynamic>.from(accountsBalances['balances']);
        await Future.forEach(balances, (dynamic balanceInfo) async {
          dynamic tokenDetails = balanceInfo['token'];
          String tokenAddress = tokenDetails['address'];
          num amount = num.parse(balanceInfo['amount']);
          Transactions transactions = Transactions.initial();
          dynamic response = await client.get('https://api.etherscan.io/api?module=account&action=tokentx&contractaddress=$tokenAddress&address=$walletAddress&page=1&offset=100&sort=desc&apikey=$apiKey');
          dynamic jsonData = responseHandler(response);
          List<dynamic> transferEventsOfTokens = List<dynamic>.from(jsonData['result']);
          List<Transfer> transactionsList = new List();
          if (transferEventsOfTokens.isNotEmpty) {
            transactionsList = transferEventsOfTokens.map((transferEventsOfToken) {
              int blockNumber = int.parse(transferEventsOfToken['blockNumber']);
              int timestamp = int.parse(transferEventsOfToken['timeStamp']);
              BigInt value = BigInt.from(num.parse(transferEventsOfToken['value']));
              String txHash = transferEventsOfToken['hash'];
              String from = transferEventsOfToken['from'];
              String to = transferEventsOfToken['to'];
              String type = to.toLowerCase() == walletAddress.toLowerCase() ? 'RECEIVE' : 'SEND';
              return Transfer(
                blockNumber: blockNumber,
                timestamp: timestamp,
                txHash: txHash,
                type: type,
                from: from,
                to: to,
                status: 'CONFIRMED', // confirmations > 1 ?  : 'PENDING',
                value: value,
              );
            }).toList();
          }
          Token token = new Token(
            symbol: tokenDetails['symbol'],
            address: tokenAddress,
            name: tokenDetails['name'],
            imageUrl: tokenDetails['imageUrl'],
            decimals: tokenDetails['decimals'],
            amount: amount,
            transactions: transactions.copyWith(list: transactionsList),
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
