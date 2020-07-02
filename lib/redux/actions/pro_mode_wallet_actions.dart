import 'dart:async';
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peepl/models/community.dart';
import 'package:peepl/models/pro/pro_wallet_state.dart';
import 'package:peepl/models/pro/token.dart';
import 'package:peepl/models/transactions/transfer.dart';
import 'package:peepl/models/user_state.dart';
import 'package:peepl/models/jobs/base.dart';
import 'package:peepl/redux/actions/error_actions.dart';
import 'package:peepl/redux/state/store.dart';
import 'package:peepl/services.dart';
import 'package:peepl/utils/addresses.dart';
import 'package:peepl/utils/constans.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;

Future<bool> approvalCallback() async {
  return true;
}

class AddProJob {
  final String tokenAddress;
  final Job job;
  AddProJob({this.job, this.tokenAddress});
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

class StartFetchTransferEvents {
  StartFetchTransferEvents();
}

class GetTokenListSuccess {
  Map<String, Token> erc20Tokens;
  GetTokenListSuccess({this.erc20Tokens});
}

class InitWeb3ProModeSuccess {
  final wallet_core.Web3 web3;
  InitWeb3ProModeSuccess({this.web3});
}

class StartFetchTokensBalances {
  StartFetchTokensBalances();
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
    new Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) async {
      String walletAddress = store.state.userState.walletAddress;
      dynamic response = await graph.getTransferEvents(
          foreignNetwork: foreignNetwork, to: walletAddress);
      List transfersEvents = List.from(response);
      if (transfersEvents.isNotEmpty) {
        store.dispatch(getAddressBalances());
        timer.cancel();
      }
    });
    store.dispatch(new StartListenToTransferEventsSuccess());
  };
}

ThunkAction fetchTokensBalances() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    bool isFetchTokensBalances = store.state.proWalletState?.isFetchTokensBalances ?? false;
    if (!isFetchTokensBalances) {
      UserState userState = store.state.userState;
      new Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) async {
        ProWalletState proWalletState = store.state.proWalletState;
        for (Token token in proWalletState.erc20Tokens.values) {
          void Function(BigInt) onDone = (BigInt balance) {
            logger.info('${token.name} balance updated');
            Token tokenToUpdate = store.state.proWalletState.erc20Tokens[token.address];
            store.dispatch(UpdateToken(
              tokenToUpdate: tokenToUpdate.copyWith(amount: balance,
              timestamp: DateTime.now().millisecondsSinceEpoch)));
          };
          void Function(Object error, StackTrace stackTrace) onError = (Object error, StackTrace stackTrace) {
            logger.severe('Error in fetchTokenBalance for - ${token.name}');
            logger.severe(error);
          };
          await token.fetchTokenBalance(userState.walletAddress, onDone: onDone, onError: onError);
        }
      });
      store.dispatch(StartFetchTokensBalances());
    }
  };
}

ThunkAction getAddressBalances() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      dynamic response = await tokenAPI.getAddressBalances(walletAddress);
      List tokensList = List.from(response['tokens']);
      if (tokensList.isNotEmpty) {
        logger.info('found ${tokensList.length} tokens');
        ProWalletState proWalletState = store.state.proWalletState;
        List filterNewToken = tokensList.where((token) {
          String tokenAddress = (token['address'] as String).toLowerCase();
          if (proWalletState.erc20Tokens.containsKey(tokenAddress)) {
            return token['timestamp'] > proWalletState.erc20Tokens[tokenAddress].timestamp;
          }
          return true;
        }).toList();
        logger.info('new token ${filterNewToken.length} tokens');
        Iterable<MapEntry<String, Token>> entries = filterNewToken.map((token) {
          String tokenAddress = token['address'].toLowerCase();
          Token newToken = proWalletState.erc20Tokens[tokenAddress] ?? new Token.initial();
          return new MapEntry(
              tokenAddress,
              newToken.copyWith(
                address: tokenAddress,
                name: token['name'],
                amount: token['amount'],
                decimals: token['decimals'],
                symbol: token['symbol'],
                timestamp: token['timestamp'],
              ));
        });
        if (entries.isNotEmpty) {
          Map<String, Token> erc20RTokens = new Map<String, Token>();
          erc20RTokens.addEntries(entries);
          store.dispatch(new GetTokenListSuccess(erc20Tokens: erc20RTokens));
        }
        store.dispatch(startFetchTransferEventsCall());
        store.dispatch(startProcessingTokensJobsCall());
      }
    } catch (error) {
      logger.severe('Error in Get Address Balances');
    }
  };
}

ThunkAction startFetchTransferEventsCall() {
  return (Store store) async {
    bool isFetchTransferEvents = store.state.proWalletState?.isFetchTransferEvents ?? false;
    if (!isFetchTransferEvents) {
      new Timer.periodic(Duration(seconds: (intervalSeconds * 2)), (Timer timer) async {
        ProWalletState proWalletState = store.state.proWalletState;
        List<String> tokenAddresses = List<String>.from(proWalletState.erc20Tokens.keys);
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
      dynamic response = await tokenAPI.getTokenTransferEventsByAccountAddress(
          tokenAddress, walletAddress,
          startblock: token.transactions?.blockNumber ?? 0);
      logger.info(
          'Transfer Events of account $walletAddress and tokenAddress $tokenAddress');
      List<dynamic> tokensTransferEvents = List<dynamic>.from(response);
      if (tokensTransferEvents.isNotEmpty) {
        int combiner(int max, dynamic transferEvent) =>
            (int.parse(transferEvent['blockNumber'].toString()) > max
                ? int.parse(transferEvent['blockNumber'].toString())
                : max) +
            1;
        int maxBlockNumber = tokensTransferEvents.fold<int>(0, combiner);
        List<Transfer> tokenTransfersList = tokensTransferEvents
            .map((transferEvent) => Transfer(
                  blockNumber:
                      int.parse(transferEvent['blockNumber'].toString()),
                  txHash: transferEvent['hash'],
                  to: transferEvent['to'],
                  from: transferEvent["from"],
                  status: "CONFIRMED",
                  timestamp: int.parse(transferEvent['timeStamp'].toString()),
                  value: BigInt.from(num.parse(transferEvent['value'])),
                  tokenAddress: token.address,
                  type: transferEvent["from"].toString().toLowerCase() ==
                          walletAddress.toLowerCase()
                      ? 'SEND'
                      : 'RECEIVE',
                ))
            .toList();
        Token tokenToUpdate = token.copyWith(
            transactions: token.transactions.copyWith(
                blockNumber: maxBlockNumber,
                list: token.transactions.list..addAll(tokenTransfersList)));
        store.dispatch(UpdateToken(tokenToUpdate: tokenToUpdate));
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
      Community community = store.state.cashWalletState.communities[defaultCommunityAddress];
      logger.info('Sending $tokensAmount tokens of ${token.address} from wallet $walletAddress to $receiverAddress');
      Map<String, dynamic> approveTokenData = await web3.approveTokenOffChain(
        walletAddress, token.address, tokensAmount, network: foreignNetwork);
      Map<String, dynamic> transferTokenData = await web3.transferTokenOffChain(
        walletAddress, token.address, receiverAddress, tokensAmount, network: foreignNetwork);
      num feeAmount = community.plugins.foreignTransfers.calcFee(tokensAmount);
      Map<String, dynamic> feeTrasnferData = await web3.transferTokenOffChain(
        walletAddress,
        token.address,
        community.plugins.foreignTransfers.receiverAddress,
        feeAmount,
        network: foreignNetwork);
      dynamic approveTrasfer = await api.multiRelay([approveTokenData, transferTokenData, feeTrasnferData]);
      sendSuccessCallback();
      dynamic approveJobId = approveTrasfer['job']['_id'];
      logger.info('Job $approveJobId for sending token sent to the relay service');
      approveTrasfer['job']['arguments'] = {
        'receiverAddress': receiverAddress,
        'tokensAmount': tokensAmount,
        'network': foreignNetwork,
        'jobType': 'approveToken',
        'tokenAddress': token.address,
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
        Community community = store.state.cashWalletState.communities[defaultCommunityAddress];
        logger.info(
            'Sending $tokensAmount tokens of ${token.address} from wallet $walletAddress to $walletAddress on fuse');
        Map<String, dynamic> data = await web3.trasferDaiToDAIpOffChain(walletAddress, tokensAmount, token.decimals, network: foreignNetwork);
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
      // store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction startProcessingTokensJobsCall() {
  return (Store store) async {
    bool isProcessingTokensJobs = store.state.proWalletState?.isProcessingTokensJobs ?? false;
    if (!isProcessingTokensJobs) {
      new Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) async {
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
    List<String> tokenAddresses = List<String>.from(proWalletState.erc20Tokens.keys);
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
