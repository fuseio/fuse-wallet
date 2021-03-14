import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/images.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount;
import 'package:fusecash/utils/log/log.dart';

class UpdateEtherBalance {
  final BigInt balance;
  UpdateEtherBalance({this.balance});
}

class GetTokenTransfersEventsListSuccess {
  List<Transfer> tokenTransfers;
  String tokenAddress;
  GetTokenTransfersEventsListSuccess({this.tokenTransfers, this.tokenAddress});
}

class ReplaceProTransaction {
  final String tokenAddress;
  final Transaction transaction;
  final Transaction transactionToReplace;
  ReplaceProTransaction(
      {this.tokenAddress, this.transaction, this.transactionToReplace});
}

class AddProTransaction {
  final String tokenAddress;
  final Transaction transaction;
  AddProTransaction({this.transaction, this.tokenAddress});
}

class UpdateToken {
  Token tokenToUpdate;
  UpdateToken({this.tokenToUpdate});
}

class AddNewToken {
  Token token;
  AddNewToken({this.token});
}

class SetIsListenToTransferEvents {
  final bool isFetching;
  SetIsListenToTransferEvents({this.isFetching});
}

class SetIsProcessingTokensJobs {
  final bool isFetching;
  SetIsProcessingTokensJobs({this.isFetching});
}

class SetIsFetchTransferEvents {
  final bool isFetching;
  SetIsFetchTransferEvents({this.isFetching});
}

class ClearTokenList {
  ClearTokenList();
}

class SetIsFetchTokensLatestPrices {
  final bool isFetching;
  SetIsFetchTokensLatestPrices({this.isFetching});
}

class SetIsFetchNewTokens {
  final bool isFetching;
  SetIsFetchNewTokens({this.isFetching});
}

class SetIsFetchTokensBalances {
  final bool isFetching;
  SetIsFetchTokensBalances({this.isFetching});
}

// ThunkAction proTransactionFailed(String tokenAddress, transfer) {
//   return (Store store) async {
//     Transfer failedTx = transfer.copyWith(status: 'FAILED');
//     store.dispatch(new ReplaceProTransaction(
//         tokenAddress: tokenAddress,
//         transactionToReplace: failedTx,
//         transaction: transfer));
//   };
// }

// ThunkAction sendErc20TokenSuccessCall(txHash, String tokenAddress, transfer) {
//   return (Store store) async {
//     Transfer confirmedTx = transfer.copyWith(
//         status: 'CONFIRMED',
//         txHash: txHash,
//         timestamp: DateTime.now().millisecondsSinceEpoch);
//     store.dispatch(new ReplaceProTransaction(
//         tokenAddress: tokenAddress,
//         transaction: transfer,
//         transactionToReplace: confirmedTx));
//   };
// }

ThunkAction startListenToTransferEvents() {
  return (Store store) async {
    bool isListenToTransferEvents =
        store.state.proWalletState?.isListenToTransferEvents ?? false;

    if (!isListenToTransferEvents) {
      log.info('Timer start - startListenToTransferEvents');
      new Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        if (store.state.userState.walletAddress == '') {
          log.error('Timer stopped - startListenToTransferEvents');
          timer.cancel();
          return;
        }
        try {
          String walletAddress = store.state.userState.walletAddress;
          List transfersEvents = await ethereumExplorerApi
              .getTransferEventsByAccountAddress(walletAddress);
          ProWalletState proWalletState = store.state.proWalletState;
          if (transfersEvents.isNotEmpty) {
            List<String> tokenAddresses = [
              ...transfersEvents.map((transferEvent) =>
                  transferEvent['tokenAddress'].toLowerCase())
                ..toSet()
                ..toList()
            ];
            tokenAddresses
              ..removeWhere(
                  (address) => proWalletState.erc20Tokens.containsKey(address));
            log.info('tokenAddresses ${tokenAddresses.length}');
            if (tokenAddresses.isNotEmpty) {
              store.dispatch(addTokens(contractAddresses: tokenAddresses));
              store.dispatch(startFetchBalancesOnForeign());
            }
            timer.cancel();
          }
        } catch (error) {
          log.error('Error in startListenToTransferEvents ${error.toString()}');
        }
      });
      store.dispatch(new SetIsListenToTransferEvents(isFetching: true));
    }
  };
}

ThunkAction fetchTokensBalances() {
  return (Store store) async {
    bool isFetchTokensBalances =
        store.state.proWalletState?.isFetchTokensBalances ?? false;
    if (!isFetchTokensBalances) {
      log.info('Timer start - fetchTokensBalances');
      new Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        if (store.state.userState.walletAddress == '') {
          timer.cancel();
          log.error('Timer stopped - fetchTokensBalances');
          store.dispatch(SetIsFetchTokensBalances(isFetching: false));
          return;
        }
        ProWalletState proWalletState = store.state.proWalletState;
        String walletAddress = store.state.userState.walletAddress;
        for (Token token in proWalletState.erc20Tokens.values) {
          Function fetchTokenBalance = () async {
            void Function(BigInt) onDone = (BigInt balance) {
              log.info('${token.name} balance updated');
              Token tokenToUpdate =
                  store.state.proWalletState.erc20Tokens[token.address];
              store.dispatch(UpdateToken(
                  tokenToUpdate: tokenToUpdate.copyWith(
                      amount: balance,
                      timestamp: DateTime.now().millisecondsSinceEpoch)));
              store.dispatch(updateTotalBalance());
              Future.delayed(Duration(seconds: Variables.INTERVAL_SECONDS), () {
                store.dispatch(fetchTokensLatestPrice());
              });
              store.dispatch(ClearTokenList());
            };
            void Function(Object error, StackTrace stackTrace) onError =
                (Object error, StackTrace stackTrace) {
              log.error(
                  'Error in fetchTokenBalance for - ${token.name} $error');
            };
            await token.fetchTokenBalance(walletAddress,
                onDone: onDone, onError: onError);
          };
          await Future.delayed(Duration(milliseconds: 1000), fetchTokenBalance);
        }
      });
      store.dispatch(SetIsFetchTokensBalances(isFetching: true));
    }
  };
}

ThunkAction startFetchTokensLatestPrices() {
  return (Store store) async {
    bool isFetchTokensLatestPrice =
        store.state.proWalletState?.isFetchTokensLatestPrice ?? false;

    log.info('Timer start - startFetchTokensLatestPrices');
    if (!isFetchTokensLatestPrice) {
      new Timer.periodic(Duration(minutes: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        if (store.state.userState.walletAddress == '') {
          store.dispatch(SetIsFetchTokensLatestPrices(isFetching: false));
          log.error('Timer stopped - startFetchTokensLatestPrices');
          timer.cancel();
          return;
        }
        store.dispatch(fetchTokensLatestPrice());
      });
      store.dispatch(SetIsFetchTokensLatestPrices(isFetching: true));
    }
    store.dispatch(fetchTokensLatestPrice());
  };
}

ThunkAction fetchTokensLatestPrice() {
  return (Store store) async {
    ProWalletState proWalletState = store.state.proWalletState;
    for (Token token in proWalletState.erc20Tokens.values) {
      Function fetchTokenLatestPrice = () async {
        void Function(Price) onDone = (Price priceInfo) {
          log.info('${token.name} price updated');
          Token tokenToUpdate =
              store.state.proWalletState.erc20Tokens[token.address];
          store.dispatch(UpdateToken(
              tokenToUpdate: tokenToUpdate.copyWith(priceInfo: priceInfo)));
          store.dispatch(updateTotalBalance());
          store.dispatch(ClearTokenList());
        };
        void Function(Object error, StackTrace stackTrace) onError =
            (Object error, StackTrace stackTrace) {
          log.error(
              'Error in fetchTokenLatestPrice for - ${token.name} $error');
        };
        log.info('fetching price of token ${token.name} ${token.address}');
        await token.fetchTokenLatestPrice(onDone: onDone, onError: onError);
      };
      await Future.delayed(Duration(milliseconds: 500), fetchTokenLatestPrice);
    }
  };
}

ThunkAction startFetchBalancesOnForeign() {
  return (Store store) async {
    bool isFetchNewTokens =
        store.state.proWalletState?.isFetchNewTokens ?? false;
    if (!isFetchNewTokens) {
      log.info('Timer start - startFetchBalancesOnForeign');
      new Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        if (store.state.userState.walletAddress == '') {
          store.dispatch(SetIsFetchNewTokens(isFetching: false));
          log.error('Timer stopped - startFetchBalancesOnForeign');
          timer.cancel();
          return;
        }
        Map walletData = await api.getWallet();
        ProWalletState proWalletState = store.state.proWalletState;
        List<String> tokenAddresses = [];
        if (walletData['balancesOnForeign'] != null) {
          Map<String, dynamic> balancesOnForeign =
              Map.from(walletData['balancesOnForeign']);
          balancesOnForeign
            ..removeWhere((key, value) =>
                proWalletState.erc20Tokens.containsKey(key.toLowerCase()));
          tokenAddresses..addAll(balancesOnForeign.keys);
        }
        if (tokenAddresses.isNotEmpty) {
          store.dispatch(addTokens(contractAddresses: tokenAddresses));
        }
      });
      store.dispatch(SetIsFetchNewTokens(isFetching: true));
    }
  };
}

ThunkAction addTokens({List<String> contractAddresses = const []}) {
  return (Store store) async {
    try {
      List<String> tokenAddresses = []..addAll(contractAddresses);
      for (String address in tokenAddresses) {
        store.dispatch(fetchTokenByAddress(address));
      }
    } catch (error) {
      log.error('Error in getBalancesOnForeign ${error.toString()}');
    }
  };
}

ThunkAction fetchTokenByAddress(String tokenAddress) {
  return (Store store) async {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    Community community = communities.firstWhere(
        (Community element) =>
            tokenAddress?.toLowerCase() ==
            element?.foreignTokenAddress?.toLowerCase(),
        orElse: () => null);
    if (community != null) {
      Token token =
          store.state.cashWalletState.tokens[community?.homeTokenAddress];
      Token newToken = Token(
        address: tokenAddress,
        name: token.name,
        symbol: token.symbol,
        decimals: token.decimals,
        timestamp: 0,
        amount: BigInt.zero,
        originNetwork: null,
        imageUrl: ImageUrl.getLink(
          community.metadata.imageUri,
        ),
      );
      log.info('ADDED - new token $tokenAddress');
      store.dispatch(AddNewToken(
          token: newToken.copyWith(address: tokenAddress.toLowerCase())));
    } else {
      try {
        dynamic tokenDetails = await ethereumWeb3.getTokenDetails(tokenAddress);
        final int decimals = tokenDetails['decimals'].toInt();
        Token newToken = Token(
          address: tokenAddress.toLowerCase(),
          name: tokenDetails['name'],
          decimals: decimals,
          symbol: tokenDetails['symbol'],
        );
        log.info('ADDED - new token $tokenAddress');
        store.dispatch(AddNewToken(
            token: newToken.copyWith(address: tokenAddress.toLowerCase())));
      } catch (e) {
        log.error('Error while get Token Details for $tokenAddress $e');
      }
    }
  };
}

ThunkAction getEtherBalance() {
  return (Store store) async {
    try {
      BigInt etherBalance =
          store.state.proWalletState.etherBalance ?? BigInt.zero;
      String walletAddress = store.state.userState.walletAddress;
      EtherAmount balance = await ethereumWeb3.getBalance(
        address: walletAddress,
      );
      if (etherBalance.compareTo(balance.getInWei) != 0) {
        store.dispatch(UpdateEtherBalance(balance: balance.getInWei));
      }
    } catch (error) {
      log.error('Error in Get Ether Balance ${error.toString()}');
    }
  };
}

ThunkAction startFetchTransferEventsCall() {
  return (Store store) async {
    bool isFetchTransferEvents =
        store.state.proWalletState?.isFetchTransferEvents ?? false;

    if (!isFetchTransferEvents) {
      log.info('Timer start - startFetchTransferEventsCall');
      new Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        if (store.state.userState.walletAddress == '') {
          store.dispatch(SetIsFetchTransferEvents(isFetching: false));
          log.error('Timer stopped - startFetchTransferEventsCall');
          timer.cancel();
          return;
        }
        ProWalletState proWalletState = store.state.proWalletState;
        List<String> tokenAddresses =
            List<String>.from(proWalletState.erc20Tokens.keys);
        for (String tokenAddress in tokenAddresses) {
          store.dispatch(getTokenTransferEventsByAccountAddress(tokenAddress));
        }
      });
      store.dispatch(SetIsFetchTransferEvents(isFetching: true));
    }
  };
}

ThunkAction getTokenTransferEventsByAccountAddress(String tokenAddress) {
  return (Store store) async {
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
      log.error(
          'ERROR in getTokenTransferEventsByAccountAddress ${e.toString()}');
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
    String transferNote,
    Transfer inviteTransfer}) {
  return (Store store) async {
    try {
      UserState userState = store.state.userState;
      String walletAddress = userState.walletAddress;
      log.info(
          'Sending $tokensAmount tokens of ${token.address} from wallet $walletAddress to $receiverAddress');
      num feeAmount = fees[token.symbol] ?? 1;
      Map<String, dynamic> approveTokenData =
          await ethereumWeb3.approveTokenOffChain(
        walletAddress,
        token.address,
        tokensAmount,
        network: foreignNetwork,
      );
      Map<String, dynamic> transferTokenData =
          await ethereumWeb3.transferTokenOffChain(
        walletAddress,
        token.address,
        receiverAddress,
        tokensAmount,
        network: foreignNetwork,
      );
      Map<String, dynamic> feeTransferData =
          await ethereumWeb3.transferTokenOffChain(
        walletAddress,
        token.address,
        Addresses.FEE_ADDRESS,
        feeAmount,
        network: foreignNetwork,
      );
      dynamic approveTransfer = await api
          .multiRelay([approveTokenData, transferTokenData, feeTransferData]);
      sendSuccessCallback();
      dynamic approveJobId = approveTransfer['job']['_id'];
      log.info('Job $approveJobId for sending token sent to the relay service');
    } catch (e) {
      log.error('ERROR - sendErc20TokenCall $e');
      sendFailureCallback();
    }
  };
}

ThunkAction sendTokenToHomeMultiBridge(
    Token token,
    String receiverAddress,
    num tokensAmount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    {String receiverName,
    String transferNote}) {
  return (Store store) async {
    try {
      UserState userState = store.state.userState;
      String walletAddress = userState.walletAddress;
      String tokenAddress = token?.address;
      dynamic response;
      num feeAmount = 20;
      log.info(
          'Multi bridge - Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
      List transferData = await ethereumWeb3.transferTokenToHome(walletAddress,
          receiverAddress, tokenAddress, tokensAmount, token.decimals,
          network: token.originNetwork);
      Map<String, dynamic> feeTransferData =
          await ethereumWeb3.transferTokenOffChain(
        walletAddress,
        tokenAddress,
        Addresses.FEE_ADDRESS,
        feeAmount,
      );
      response = await api.multiRelay([...transferData, feeTransferData]);

      dynamic jobId = response['job']['_id'];
      log.info('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();
    } catch (e) {
      log.error('ERROR - sendTokenCall $e');
      sendFailureCallback();
    }
  };
}

ThunkAction inviteAndSendCall(
  Token token,
  String name,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String receiverName = '',
}) {
  return (Store store) async {
    try {
      String senderName = store.state.userState.displayName;
      dynamic response = await api.invite(
        contactPhoneNumber,
        communityAddress: defaultCommunityAddress,
        name: senderName,
        amount: tokensAmount.toString(),
        symbol: token.symbol,
      );
      final String receiverAddress = response['job']['data']["walletAddress"];
      store.dispatch(
        sendErc20TokenCall(
          token,
          receiverAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
        ),
      );
      sendSuccessCallback();
      store.dispatch(loadContacts());
    } catch (e) {
      log.error('ERROR - inviteAndSendCall $e');
    }
  };
}

ThunkAction sendErc20TokenToContactCall(
    Token token,
    String name,
    String contactPhoneNumber,
    num tokensAmount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    {String receiverName,
    String transferNote}) {
  return (Store store) async {
    try {
      log.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      log.info("wallet $wallet");
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      if (walletAddress == null || walletAddress.isEmpty) {
        log.info("inviting contact $contactPhoneNumber");
        store.dispatch(inviteAndSendCall(token, name, contactPhoneNumber,
            tokensAmount, sendSuccessCallback, sendFailureCallback,
            receiverName: receiverName));
        return;
      }
      log.info("sending to contact walletAddress $walletAddress");
      store.dispatch(sendErc20TokenCall(token, walletAddress, tokensAmount,
          sendSuccessCallback, sendFailureCallback,
          receiverName: receiverName, transferNote: transferNote));
    } catch (e) {
      log.error('ERROR - sendTokenToContactCall $e');
    }
  };
}
