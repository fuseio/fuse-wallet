import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/constans/exchangable_tokens.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/jobs/swap_token_job.dart';
import 'package:fusecash/models/pro/price.dart';
import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:fusecash/redux/state/store.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/constans.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:wallet_core/wallet_core.dart' show EtherAmount;

Future<bool> approvalCallback() async {
  return true;
}

class UpdateEtherBalabnce {
  final BigInt balance;
  UpdateEtherBalabnce({this.balance});
}

class AddProJob {
  final String tokenAddress;
  final Job job;
  AddProJob({this.job, this.tokenAddress});
}

class ReplaceProTransaction {
  final String tokenAddress;
  final Transaction transaction;
  final Transaction transactionToReplace;
  ReplaceProTransaction(
      {this.tokenAddress, this.transaction, this.transactionToReplace});
}

class ProJobDone {
  final String tokenAddress;
  final Job job;
  ProJobDone({this.tokenAddress, this.job});
}

class GetTokenTransfersEventsListSuccess {
  List<Transfer> tokenTransfers;
  String tokenAddress;
  GetTokenTransfersEventsListSuccess({this.tokenTransfers, this.tokenAddress});
}

class AddProTransaction {
  final String tokenAddress;
  final Transaction transaction;
  AddProTransaction({this.transaction, this.tokenAddress});
}

class UpadteBlockNumber {
  final num blockNumber;
  UpadteBlockNumber({this.blockNumber});
}

class UpdateToken {
  Token tokenToUpdate;
  UpdateToken({this.tokenToUpdate});
}

class StartListenToTransferEventsSuccess {
  StartListenToTransferEventsSuccess();
}

class StartProcessingTokensJobs {
  StartProcessingTokensJobs();
}

class StartProcessingSwapActions {
  StartProcessingSwapActions();
}

class StartFetchTransferEvents {
  StartFetchTransferEvents();
}

class GetTokenListSuccess {
  Map<String, Token> erc20Tokens;
  GetTokenListSuccess({this.erc20Tokens});
}

class StartFetchTokensLastestPrices {
  StartFetchTokensLastestPrices();
}

class InitWeb3ProModeSuccess {
  final wallet_core.Web3 web3;
  InitWeb3ProModeSuccess({this.web3});
}

class StartFetchTokensBalances {
  StartFetchTokensBalances();
}

ThunkAction proTransactionFailed(String tokenAddrees, Transfer transfer) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    Transfer failedTx = transfer.copyWith(status: 'FAILED');
    logger.severe('proTransactionFailed $tokenAddrees ${failedTx.jobId}');
    store.dispatch(new ReplaceProTransaction(
        tokenAddress: tokenAddrees,
        transactionToReplace: failedTx,
        transaction: transfer));
  };
}

ThunkAction sendErc20TokenSuccessCall(String txHash, String tokenAddrees, Transfer transfer) {
  return (Store store) async {
    // final logger = await AppFactory().getLogger('action');
    Transfer confirmedTx =
        transfer.copyWith(status: 'CONFIRMED', txHash: txHash);
    store.dispatch(new ReplaceProTransaction(
        tokenAddress: tokenAddrees,
        transaction: transfer,
        transactionToReplace: confirmedTx));
  };
}

ThunkAction initWeb3ProMode(
    {String privateKey,
    String communityManagerAddress,
    String transferManagerAddress,
    String dAIPointsManagerAddress}) {
  return (Store store) async {
    UserState userState = store.state.userState;
    String privateKey = userState.privateKey;
    wallet_core.Web3 web3 = new wallet_core.Web3(approvalCallback,
        networkId: int.parse(DotEnv().env['FOREIGN_NETWORK_ID']),
        transferManagerAddress:
            transferManagerAddress ?? userState.transferManagerAddress,
        daiPointsManagerAddress:
            dAIPointsManagerAddress ?? userState.daiPointsManagerAddress,
        communityManagerAddress:
            communityManagerAddress ?? userState.communityManagerAddress,
        url: DotEnv().env['FOREIGN_PROVIDER_URL']);
    await web3.setCredentials(privateKey);
    store.dispatch(new InitWeb3ProModeSuccess(web3: web3));
  };
}

ThunkAction startListenToTransferEvents() {
  return (Store store) async {
    bool isListenToTransferEvents =
        store.state.proWalletState?.isListenToTransferEvents ?? false;
    final logger = await AppFactory().getLogger('action');
    if (!isListenToTransferEvents) {
      new Timer.periodic(Duration(seconds: 1), (Timer timer) async {
        try {
          String walletAddress = store.state.userState.walletAddress;
          List transfersEvents = await graph.getTransferEvents(
              foreignNetwork: foreignNetwork, to: walletAddress);
          ProWalletState proWalletState = store.state.proWalletState;
          if (transfersEvents.isNotEmpty &&
              proWalletState.erc20Tokens.isEmpty) {
            List<String> addressesFromTransfersEvents = [
              ...transfersEvents.map((transferEvent) =>
                  transferEvent['tokenAddress'].toLowerCase())
                ..toSet()
                ..toList()
            ];
            addressesFromTransfersEvents
              ..removeWhere(
                  (address) => proWalletState.erc20Tokens.containsKey(address));
            store.dispatch(getBalancesOnForeign(
                addressesFromTransfersEvents: addressesFromTransfersEvents));
            timer.cancel();
          }
        } catch (error) {
          logger.severe(
              'Error in startListenToTransferEvents ${error.toString()}');
        }
      });
      store.dispatch(new StartListenToTransferEventsSuccess());
    }
  };
}

ThunkAction fetchTokensBalances() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    bool isFetchTokensBalances =
        store.state.proWalletState?.isFetchTokensBalances ?? false;
    if (!isFetchTokensBalances) {
      new Timer.periodic(Duration(seconds: intervalSeconds * 2),
          (Timer timer) async {
        ProWalletState proWalletState = store.state.proWalletState;
        String walletAddress = store.state.userState.walletAddress;
        for (Token token in proWalletState.erc20Tokens.values) {
          Function fetchTokenBalance = () async {
            void Function(BigInt) onDone = (BigInt balance) {
              logger.info('${token.name} balance updated');
              Token tokenToUpdate =
                  store.state.proWalletState.erc20Tokens[token.address];
              store.dispatch(UpdateToken(
                  tokenToUpdate: tokenToUpdate.copyWith(amount: balance)));
            };
            void Function(Object error, StackTrace stackTrace) onError =
                (Object error, StackTrace stackTrace) {
              logger.severe(
                  'Error in fetchTokenBalance for - ${token.name} $error');
            };
            await token.fetchTokenBalance(walletAddress,
                onDone: onDone, onError: onError);
          };
          await Future.delayed(Duration(milliseconds: 500), fetchTokenBalance);
        }
      });
      store.dispatch(StartFetchTokensBalances());
    }
  };
}

ThunkAction startFetchTokensLastestPrices() {
  return (Store store) async {
    bool isFetchTokensLastestPrice =
        store.state.proWalletState?.isFetchTokensLastestPrice ?? false;
    if (!isFetchTokensLastestPrice) {
      new Timer.periodic(Duration(minutes: 60), (Timer timer) async {
        store.dispatch(fetchTokensLatestPrice());
      });
      store.dispatch(StartFetchTokensLastestPrices());
    }
    store.dispatch(fetchTokensLatestPrice());
  };
}

ThunkAction fetchTokensLatestPrice() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    ProWalletState proWalletState = store.state.proWalletState;
    for (Token token in proWalletState.erc20Tokens.values) {
      Function fetchTokenLastestPrice = () async {
        void Function(Price) onDone = (Price priceInfo) {
          logger.info('${token.name} price updated');
          Token tokenToUpdate =
              store.state.proWalletState.erc20Tokens[token.address];
          store.dispatch(UpdateToken(
              tokenToUpdate: tokenToUpdate.copyWith(priceInfo: priceInfo)));
        };
        void Function(Object error, StackTrace stackTrace) onError =
            (Object error, StackTrace stackTrace) {
          logger.severe(
              'Error in fetchTokenLastestPrice for - ${token.name} $error');
        };
        await token.fetchTokenLastestPrice(onDone: onDone, onError: onError);
      };
      await Future.delayed(Duration(milliseconds: 500), fetchTokenLastestPrice);
    }
  };
}

ThunkAction getAddressBalances() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      BigInt etherBalance =
          store.state.proWalletState.etherBalance ?? BigInt.zero;
      dynamic response = await tokenAPI.getAddressBalances(walletAddress);
      if (response['balance'] != null) {
        if (etherBalance.compareTo(response['balance']) != 0) {
          store.dispatch(UpdateEtherBalabnce(balance: response['balance']));
        }
      }
      List tokensList = List.from(response['tokens']);
      if (tokensList.isNotEmpty) {
        ProWalletState proWalletState = store.state.proWalletState;
        List filterNewToken = tokensList.where((token) {
          String tokenAddress = token['address'].toLowerCase();
          double formatedValue =
              (token['amount'] / BigInt.from(pow(10, token['decimals'])));
          if (proWalletState.erc20Tokens.containsKey(tokenAddress)) {
            return false;
          } else if (num.parse(formatedValue.toString()).compareTo(0) == 1) {
            return true;
          }
          return false;
        }).toList();
        Iterable<MapEntry<String, Token>> entries = filterNewToken.map((token) {
          String tokenAddress = token['address'].toLowerCase();
          Price priceInfo =
              token['price'] != null ? Price.fromJson(token['price']) : null;
          Token newToken =
              proWalletState.erc20Tokens[tokenAddress] ?? new Token.initial();
          return new MapEntry(
              tokenAddress,
              newToken.copyWith(
                address: tokenAddress,
                name: token['name'],
                amount: token['amount'],
                decimals: token['decimals'],
                symbol: token['symbol'],
                timestamp: token['timestamp'],
                priceInfo: priceInfo,
              ));
        });
        if (entries.isNotEmpty) {
          Map<String, Token> erc20RTokens = new Map<String, Token>();
          erc20RTokens.addEntries(entries);
          store.dispatch(new GetTokenListSuccess(erc20Tokens: erc20RTokens));
        } else {
          store.dispatch(
              new GetTokenListSuccess(erc20Tokens: Map<String, Token>()));
        }
        store.dispatch(startFetchTransferEventsCall());
        store.dispatch(startProcessingTokensJobsCall());
      }
    } catch (error) {
      logger.severe('Error in Get Address Balances ${error.toString()}');
    }
  };
}

ThunkAction getBalancesOnForeign({List<String> addressesFromTransfersEvents}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      Map walletData = await api.getWallet();
      ProWalletState proWalletState = store.state.proWalletState;
      List<String> tokenAddresses = [];
      if (addressesFromTransfersEvents != null) {
        tokenAddresses..addAll(addressesFromTransfersEvents);
      }
      if (walletData['balancesOnForeign'] != null) {
        Map<String, dynamic> balancesOnForeign =
            Map.from(walletData['balancesOnForeign']);
        balancesOnForeign
          ..removeWhere((key, value) =>
              proWalletState.erc20Tokens.containsKey(key.toLowerCase()));
        tokenAddresses..addAll(balancesOnForeign.keys);
      }
      if (tokenAddresses.isNotEmpty) {
        wallet_core.Web3 web3 = proWalletState.web3;
        if (web3 == null) {
          throw "Web3 is empty";
        }
        Future<Iterable<MapEntry<String, Token>>> entries =
            Future.wait(tokenAddresses.map((tokenAddress) async {
          if (exchangableTokens
              .containsKey(checksumEthereumAddress(tokenAddress))) {
            Token newToken =
                exchangableTokens[checksumEthereumAddress(tokenAddress)];
            return new MapEntry(tokenAddress.toLowerCase(),
                newToken.copyWith(address: tokenAddress.toLowerCase()));
          } else {
            try {
              dynamic tokenDetails = await web3.getTokenDetails(tokenAddress);
              return new MapEntry(
                  tokenAddress.toLowerCase(),
                  Token.initial().copyWith(
                    address: tokenAddress.toLowerCase(),
                    name: tokenDetails['name'],
                    decimals: tokenDetails['decimals'],
                    symbol: tokenDetails['symbol'],
                    timestamp: 0,
                  ));
            } catch (e) {
              return MapEntry<String, Token>('', Token.initial());
            }
          }
        }));
        Iterable<MapEntry<String, Token>> result = await entries;
        if (result.isNotEmpty) {
          Map<String, Token> erc20RTokens = new Map<String, Token>();
          erc20RTokens..addEntries(result);
          erc20RTokens..removeWhere((key, value) => key == '');
          store.dispatch(new GetTokenListSuccess(erc20Tokens: erc20RTokens));
          store.dispatch(fetchTokensBalances());
        }
      }
    } catch (error) {
      logger.severe('Error in getBalancesOnForeign ${error.toString()}');
    }
  };
}

ThunkAction getEtherBalabnce() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      BigInt etherBalance =
          store.state.proWalletState.etherBalance ?? BigInt.zero;
      wallet_core.Web3 web3 = store.state.proWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      EtherAmount balance = await web3.getBalance();
      if (etherBalance.compareTo(balance.getInWei) != 0) {
        store.dispatch(UpdateEtherBalabnce(balance: balance.getInWei));
      }
    } catch (error) {
      logger.severe('Error in Get Ether Balabnce ${error.toString()}');
    }
  };
}

ThunkAction startFetchTransferEventsCall() {
  return (Store store) async {
    bool isFetchTransferEvents =
        store.state.proWalletState?.isFetchTransferEvents ?? false;
    if (!isFetchTransferEvents) {
      new Timer.periodic(Duration(seconds: intervalSeconds),
          (Timer timer) async {
        ProWalletState proWalletState = store.state.proWalletState;
        List<String> tokenAddresses =
            List<String>.from(proWalletState.erc20Tokens.keys);
        for (String tokenAddress in tokenAddresses) {
          store.dispatch(getTokenTransferEventsByAccountAddress(tokenAddress));
        }
      });
      store.dispatch(StartFetchTransferEvents());
    }
  };
}

ThunkAction getTokenTransferEventsByAccountAddress(String tokenAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      Token token = store.state.proWalletState.erc20Tokens[tokenAddress];
      String walletAddress = store.state.userState.walletAddress;
      List<dynamic> tokensTransferEvents = await api.getWalletTransactions(
          walletAddress.toLowerCase(),
          tokenAddress: token.address.toLowerCase());
      if (tokensTransferEvents.isNotEmpty) {
        List<Transfer> transfers = List<Transfer>.from(tokensTransferEvents
            .map((json) => Transfer.fromJson(json))
            .toList());
        for (Transfer transfer in transfers) {
          if (transfer.status != null && transfer.status != 'DROPPED') {
            store.dispatch(AddProTransaction(
                tokenAddress: tokenAddress, transaction: transfer));
          }
        }
      }
    } catch (e) {
      logger.severe(
          'ERROR in getTokenTransferEventsByAccountAddress ${e.toString()}');
      store.dispatch(new ErrorAction(e.toString()));
    }
  };
}

ThunkAction sendErc20TokenCall(
    Token token,
    String receiverAddress,
    num tokensAmount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    {String receiverName,
    String transferNote}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      UserState userState = store.state.userState;
      String walletAddress = userState.walletAddress;
      wallet_core.Web3 web3 = store.state.proWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      Community community =
          store.state.cashWalletState.communities[defaultCommunityAddress];
      logger.info(
          'Sending $tokensAmount tokens of ${token.address} from wallet $walletAddress to $receiverAddress');
      Map<String, dynamic> approveTokenData = await web3.approveTokenOffChain(
          walletAddress, token.address, tokensAmount,
          network: foreignNetwork);
      Map<String, dynamic> transferTokenData = await web3.transferTokenOffChain(
          walletAddress, token.address, receiverAddress, tokensAmount,
          network: foreignNetwork);
      num feeAmount = community.plugins.foreignTransfers.calcFee(tokensAmount);
      Map<String, dynamic> feeTrasnferData = await web3.transferTokenOffChain(
          walletAddress,
          token.address,
          community.plugins.foreignTransfers.receiverAddress,
          feeAmount,
          network: foreignNetwork);
      dynamic approveTrasfer = await api
          .multiRelay([approveTokenData, transferTokenData, feeTrasnferData]);
      sendSuccessCallback();
      dynamic approveJobId = approveTrasfer['job']['_id'];
      logger.info(
          'Job $approveJobId for sending token sent to the relay service');

      Transfer transfer = new Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: token.address,
          value: toBigInt(feeAmount + tokensAmount, token.decimals),
          type: 'SEND',
          note: transferNote,
          receiverName: receiverName,
          status: 'PENDING',
          jobId: approveJobId);
      store.dispatch(new AddProTransaction(
          transaction: transfer, tokenAddress: token.address));
      approveTrasfer['job']['arguments'] = {
        'receiverAddress': receiverAddress,
        'tokensAmount': tokensAmount,
        'network': foreignNetwork,
        'jobType': 'approveToken',
        'tokenAddress': token.address,
        'transfer': transfer
      };

      Job job = JobFactory.create(approveTrasfer['job']);
      store.dispatch(AddProJob(job: job, tokenAddress: token.address));
    } catch (e) {
      logger.severe('ERROR - sendErc20TokenCall $e');
      store.dispatch(new ErrorAction(e.toString()));
      sendFailureCallback();
    }
  };
}

ThunkAction sendDaiToDaiPointsCall(num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback,
    {String transferNote, Transfer inviteTransfer}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      if (store.state.proWalletState.erc20Tokens.containsKey(daiTokenAddress)) {
        UserState userState = store.state.userState;
        String walletAddress = userState.walletAddress;
        Token token = store.state.proWalletState.erc20Tokens[daiTokenAddress];
        wallet_core.Web3 web3 = store.state.proWalletState.web3;
        Community community =
            store.state.cashWalletState.communities[defaultCommunityAddress];
        logger.info(
            'Sending $tokensAmount tokens of ${token.address} from wallet $walletAddress to $walletAddress on fuse');
        Map<String, dynamic> data = await web3.trasferDaiToDAIpOffChain(
            walletAddress, tokensAmount, token.decimals,
            network: foreignNetwork);
        Map<String, dynamic> feeTrasnferData = await web3.transferTokenOffChain(
            walletAddress,
            token.address,
            community.plugins.bridgeToForeign.receiverAddress,
            community.plugins.bridgeToForeign.calcFee(tokensAmount),
            network: foreignNetwork);
        dynamic response = await api.multiRelay([data, feeTrasnferData]);
        dynamic jobId = response['job']['_id'];
        logger.info('Job $jobId for sending token sent to the relay service');
        sendSuccessCallback();
      } else {
        sendFailureCallback();
      }
    } catch (e) {
      logger.severe('ERROR - sendDaiToDaiPointsCall $e');
      sendFailureCallback();
    }
  };
}

ThunkAction startProcessingTokensJobsCall() {
  return (Store store) async {
    bool isProcessingTokensJobs =
        store.state.proWalletState?.isProcessingTokensJobs ?? false;
    if (!isProcessingTokensJobs) {
      new Timer.periodic(Duration(seconds: intervalSeconds),
          (Timer timer) async {
        store.dispatch(processingTokenJobsCall(timer));
      });
      store.dispatch(new StartProcessingTokensJobs());
    }
  };
}

ThunkAction processingTokenJobsCall(Timer timer) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('Job');
    String walletAddress = store.state.userState.walletAddress;
    ProWalletState proWalletState = store.state.proWalletState;
    List<String> tokenAddresses =
        List<String>.from(proWalletState.erc20Tokens.keys);
    for (String tokenAddress in tokenAddresses) {
      List<Job> jobs = proWalletState.erc20Tokens[tokenAddress]?.jobs ?? [];
      for (Job job in jobs) {
        if (job.status != 'DONE' && job.status != 'FAILED') {
          String currentWalletAddress = store.state.userState.walletAddress;
          bool isJobProcessValid() {
            if (currentWalletAddress != walletAddress) {
              timer.cancel();
              return false;
            }
            if (job.status == 'DONE') {
              return false;
            }
            return true;
          }

          try {
            await job.perform(store, isJobProcessValid);
          } catch (e) {
            logger.severe('failed perform ${job.name}');
          }
        }
      }
    }
  };
}

ThunkAction swapHandler(
    Token fromToken,
    Token toToken,
    String tokenAddress,
    num tokensAmount,
    num tokensAmountIn,
    String swapContractAddress,
    String swapData,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('Job');
    UserState userState = store.state.userState;
    String walletAddress = userState.walletAddress;
    wallet_core.Web3 web3 = store.state.proWalletState.web3;
    if (web3 == null) {
      throw "Web3 is empty";
    }
    try {
      dynamic response = await api.totleSwap(
          web3,
          walletAddress,
          tokenAddress,
          tokensAmount,
          DotEnv().env['TOTLE_APPROVAL_CONTRACT_ADDRESS'],
          swapContractAddress,
          swapData,
          network: 'mainnet');
      sendSuccessCallback();
      String swapJobId = response['job']['_id'];
      logger.info('Job $swapJobId for swap');
      Transfer transfer = new Transfer(
          from: walletAddress,
          to: walletAddress,
          tokenAddress: fromToken.address,
          value: toBigInt(tokensAmount, fromToken.decimals),
          type: 'SEND',
          note: '',
          receiverName: '',
          status: 'PENDING',
          jobId: swapJobId);

      Transfer transferIn = new Transfer(
          from: walletAddress,
          to: walletAddress,
          tokenAddress: toToken.address,
          value: toBigInt(tokensAmountIn, toToken.decimals),
          type: 'RECEIVE',
          status: 'PENDING',
          jobId: swapJobId);
      store.dispatch(new AddProTransaction(
          transaction: transfer, tokenAddress: fromToken.address));

      response['job']['arguments'] = {
        'name': 'swapToken',
        'tokenAddress': fromToken.address,
        'transfer': transfer.copyWith(),
        'fromToken': fromToken.copyWith(),
        'toToken': toToken.copyWith(),
        'transferIn': transferIn.copyWith()
      };
      response['job']['jobType'] = 'swapToken';
      SwapTokenJob swapTokenJob = JobFactory.create(response['job']);
      store.dispatch(
          AddProJob(job: swapTokenJob, tokenAddress: fromToken.address));
    } catch (e) {
      logger.severe('ERROR - api.totleSwap $e');
      store.dispatch(new ErrorAction(e.toString()));
      sendFailureCallback();
    }
  };
}
