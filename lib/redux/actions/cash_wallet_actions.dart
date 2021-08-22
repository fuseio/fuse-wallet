import 'dart:async';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/community/business_metadata.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/community/community_metadata.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/stats.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount;

class AddCashTokens {
  final Map<String, Token> tokens;
  AddCashTokens({
    required this.tokens,
  });
}

class AddCashToken {
  final Token token;
  AddCashToken({
    required this.token,
  });
}

class UpdateTokenPrice {
  final Price price;
  final String tokenAddress;

  UpdateTokenPrice({
    required this.price,
    required this.tokenAddress,
  });
}

class SetDefaultCommunity {
  String defaultCommunity;
  SetDefaultCommunity(this.defaultCommunity);
}

class AddCommunities {
  Map<String, Community> communities;
  AddCommunities({
    required this.communities,
  });
}

class GetWalletAddressesSuccess {
  final List<String> networks;
  final String walletAddress;
  final bool backup;
  GetWalletAddressesSuccess({
    required this.backup,
    required this.networks,
    required this.walletAddress,
  });
}

class GetTokenBalanceSuccess {
  final String tokenAddress;
  final BigInt tokenBalance;
  GetTokenBalanceSuccess({
    required this.tokenBalance,
    required this.tokenAddress,
  });
}

class AlreadyJoinedCommunity {
  final String communityAddress;
  AlreadyJoinedCommunity(this.communityAddress);
}

class GetTokenPriceDiffSuccess {
  final String tokenAddress;
  final num priceDiff;
  final int priceDiffLimitInDays;
  GetTokenPriceDiffSuccess({
    required this.priceDiff,
    required this.tokenAddress,
    required this.priceDiffLimitInDays,
  });
}

class GetTokenPriceChangeSuccess {
  final String tokenAddress;
  final num priceChange;
  GetTokenPriceChangeSuccess({
    required this.priceChange,
    required this.tokenAddress,
  });
}

class GetTokenStatsSuccess {
  final String tokenAddress;
  final List<Stats> stats;
  GetTokenStatsSuccess({
    required this.stats,
    required this.tokenAddress,
  });
}

class SwitchCommunityRequested {
  final String communityAddress;
  SwitchCommunityRequested(this.communityAddress);
}

class SwitchToNewCommunity {
  final String communityAddress;
  SwitchToNewCommunity(this.communityAddress);
}

class SwitchCommunitySuccess {
  final Community community;
  SwitchCommunitySuccess({
    required this.community,
  });
}

class RefreshCommunityData {
  final Plugins? plugins;
  final String communityAddress;
  final String? bridgeType;
  final String? bridgeDirection;
  final String? webUrl;
  RefreshCommunityData({
    this.bridgeDirection,
    this.bridgeType,
    this.plugins,
    required this.communityAddress,
    this.webUrl,
  });
}

class FetchCommunityMetadataSuccess {
  final String communityAddress;
  final CommunityMetadata? metadata;
  FetchCommunityMetadataSuccess({
    required this.communityAddress,
    this.metadata,
  });
}

class SwitchCommunityFailed {
  final String communityAddress;
  SwitchCommunityFailed({
    required this.communityAddress,
  });
}

class StartFetchingBusinessList {
  StartFetchingBusinessList();
}

class FetchingBusinessListSuccess {
  FetchingBusinessListSuccess();
}

class FetchingBusinessListFailed {
  FetchingBusinessListFailed();
}

class GetBusinessListSuccess {
  final String communityAddress;
  final List<Business> businessList;
  GetBusinessListSuccess({
    required this.businessList,
    required this.communityAddress,
  });
}

class GetActionsSuccess {
  final List<WalletAction> walletActions;
  final num updateAt;
  GetActionsSuccess({
    required this.updateAt,
    required this.walletActions,
  });
}

class GetTokenWalletActionsSuccess {
  final Token token;
  final List<WalletAction> walletActions;
  final num updateAt;
  GetTokenWalletActionsSuccess({
    required this.updateAt,
    required this.walletActions,
    required this.token,
  });
}

class StartBalanceFetchingSuccess {
  StartBalanceFetchingSuccess();
}

class SetIsTransfersFetching {
  final bool isFetching;
  SetIsTransfersFetching({
    required this.isFetching,
  });
}

class ResetTokenTxs {
  ResetTokenTxs();
}

class BranchCommunityToUpdate {
  final String communityAddress;
  BranchCommunityToUpdate(this.communityAddress);
}

class BranchListening {}

class BranchListeningStopped {}

class SetIsFetchingBalances {
  final bool isFetching;
  SetIsFetchingBalances({
    required this.isFetching,
  });
}

class SetShowDepositBanner {}

ThunkAction enablePushNotifications() {
  return (Store store) async {
    try {
      await getIt<FirebaseMessaging>().requestPermission(
        sound: true,
        badge: true,
        alert: true,
      );
      final String token = (await getIt<FirebaseMessaging>().getToken())!;
      log.info("Firebase messaging token $token");
      String walletAddress = store.state.userState.walletAddress;
      await api.updateFirebaseToken(walletAddress, token);
      await Segment.setContext({
        'device': {'token': token},
      });
    } catch (e, s) {
      log.error('ERROR - Enable push notifications: $e');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR - Enable push notifications',
      );
    }
  };
}

ThunkAction segmentIdentifyCall(Map<String, dynamic>? traits) {
  return (Store store) async {
    try {
      UserState userState = store.state.userState;
      String fullPhoneNumber = store.state.userState.phoneNumber;
      traits = traits ?? new Map<String, dynamic>();
      DateTime? installedAt = userState.installedAt;
      if (installedAt == null) {
        log.info('Identify - $fullPhoneNumber');
        installedAt = DateTime.now().toUtc();
        store.dispatch(new JustInstalled(installedAt));
      }
      traits?["Installed At"] = installedAt.toIso8601String();
      Segment.identify(userId: fullPhoneNumber, traits: Map.from({...?traits}));
    } catch (e, s) {
      log.error('ERROR - segment identify call: $e');
      await Sentry.captureException(e, stackTrace: s);
    }
  };
}

ThunkAction setDefaultCommunity() {
  return (Store store) async {
    final String communityAddress =
        store.state.cashWalletState.communityAddress;
    if ([null, ''].contains(communityAddress)) {
      final String branchAddress = store.state.cashWalletState.branchAddress;
      if (![null, ''].contains(branchAddress)) {
        store.dispatch(SetDefaultCommunity(branchAddress.toLowerCase()));
      } else {
        store.dispatch(
            SetDefaultCommunity(defaultCommunityAddress.toLowerCase()));
      }
    }
  };
}

ThunkAction startFetchTokensBalances() {
  return (Store store) async {
    final bool isFetchingBalances =
        store.state.cashWalletState.isFetchingBalances ?? false;
    final String walletAddress = store.state.userState.walletAddress;
    if (!isFetchingBalances) {
      // log.info('Start Fetching token balances');
      Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        String currentWalletAddress = store.state.userState.walletAddress;
        if (currentWalletAddress != walletAddress) {
          log.error('Timer stopped - startFetchTokensBalances');
          store.dispatch(SetIsFetchingBalances(isFetching: false));
          timer.cancel();
        } else {
          Map<String, Token> tokens = store.state.cashWalletState.tokens;
          store.dispatch(getFuseBalance());
          for (Token token in tokens.values) {
            if (![null, ''].contains(token.address)) {
              store.dispatch(getTokenBalanceCall(token));
            }
          }
        }
      });
      store.dispatch(SetIsFetchingBalances(isFetching: true));
    }
  };
}

ThunkAction startFetchingCall() {
  return (Store store) async {
    bool isTransfersFetchingStarted =
        store.state.cashWalletState.isTransfersFetchingStarted ?? false;
    final String walletAddress = store.state.userState.walletAddress;
    if (!isTransfersFetchingStarted) {
      // log.info('Timer start - startFetchingCall');
      store.dispatch(fetchListOfTokensByAddress());
      store.dispatch(getWalletActionsCall());
      store.dispatch(SetIsTransfersFetching(isFetching: true));
      Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer t) async {
        String currentWalletAddress = store.state.userState.walletAddress;
        if (currentWalletAddress != walletAddress) {
          log.error('Timer stopped - startFetchingCall');
          store.dispatch(SetIsTransfersFetching(isFetching: false));
          t.cancel();
          return;
        }
        store.dispatch(fetchListOfTokensByAddress());
        store.dispatch(getWalletActionsCall());
      });
    }
  };
}

ThunkAction createAccountWalletCall(String accountAddress) {
  return (Store store) async {
    try {
      Map<String, dynamic> response = await api.createWallet(
        communityAddress: defaultCommunityAddress,
      );
      if (!response.containsKey('job')) {
        log.info('Wallet already exists');
        store.dispatch(generateWalletSuccessCall(response));
        store.dispatch(switchCommunityCall(
          defaultCommunityAddress,
        ));
      } else {
        CashWalletState cashWalletState = store.state.cashWalletState;
        Community? community =
            cashWalletState.communities[defaultCommunityAddress.toLowerCase()];
        if (!cashWalletState.tokens.containsKey(community?.homeTokenAddress)) {
          final response = await api.getWallet();
          store.dispatch(generateWalletSuccessCall(response));
          store.dispatch(
            switchCommunityCall(
              defaultCommunityAddress,
            ),
          );
        }
      }
    } catch (e, s) {
      log.error('ERROR - createAccountWalletCall $e');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'Error in Create Account Wallet Call',
      );
    }
  };
}

ThunkAction generateWalletSuccessCall(dynamic walletData) {
  return (Store store) async {
    String? walletAddress = walletData["walletAddress"];
    log.info('walletAddress walletAddress $walletAddress');
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(setupWalletCall(walletData));
      store.dispatch(saveUserInDB(walletAddress));
      await AppTrackingTransparency.requestTrackingAuthorization();
      store.dispatch(enablePushNotifications());
      store.dispatch(identifyCall());
    }
  };
}

ThunkAction getTokenBalanceCall(Token token) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      void Function(BigInt) onDone = (BigInt balance) {
        store.dispatch(
          GetTokenBalanceSuccess(
            tokenBalance: balance,
            tokenAddress: token.address,
          ),
        );
        store.dispatch(
          segmentIdentifyCall(
            Map<String, dynamic>.from({
              '${token.symbol}_balance': token.getBalance(true),
            }),
          ),
        );
      };
      void Function(Object error, StackTrace stackTrace) onError = (
        Object e,
        StackTrace s,
      ) {
        log.error('Error - fetch token balance ${token.name} ${e.toString()}');
      };
      await token.fetchBalance(
        walletAddress,
        onDone: onDone,
        onError: onError,
      );
    } catch (e, s) {
      log.error('ERROR - getTokenBalanceCall ${e.toString()} ${s.toString()}');
    }
  };
}

ThunkAction inviteAndSendCall(
  Token token,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String? receiverName,
}) {
  return (Store store) async {
    try {
      String senderName = store.state.userState.displayName;
      final response = await api.invite(
        contactPhoneNumber,
        communityAddress: defaultCommunityAddress,
        name: senderName,
        amount: tokensAmount.toString(),
        symbol: token.symbol,
      );
      final String receiverAddress = response['job']['data']["walletAddress"];
      store.dispatch(
        sendTokenCall(
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
    } catch (e, s) {
      log.error('ERROR - inviteAndSendCall $e');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to invite user & send',
      );
    }
  };
}

ThunkAction fetchListOfTokensByAddress() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      List<Token> tokensList = await fuseExplorerApi.getListOfTokensByAddress(
        walletAddress,
      );
      CashWalletState cashWalletState = store.state.cashWalletState;
      Map<String, Token> newTokens = Map<String, Token>.from(tokensList.fold(
        {},
        (previousValue, element) {
          if (!cashWalletState.tokens.containsKey(element.address) &&
              num.parse(element.getBalance(true)).compareTo(0) == 1) {
            log.info('New token added ${element.name}');
            previousValue[element.address] = element;
          }
          return previousValue;
        },
      ));
      if (newTokens.isNotEmpty) {
        // log.info('newTokens newTokens ${newTokens.length}');
        store.dispatch(AddCashTokens(tokens: newTokens));
        Future.delayed(Duration(seconds: Variables.INTERVAL_SECONDS), () {
          store.dispatch(updateTokensPrices());
        });
      }
    } catch (e) {
      log.error('ERROR - fetchListOfTokensByAddress $e');
    }
  };
}

ThunkAction sendTokenToForeignMultiBridge(
  Token token,
  String receiverAddress,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String? receiverName,
  String? transferNote,
}) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      String tokenAddress = token.address;
      dynamic response;
      num feeAmount = 20;
      log.info(
          'Multi bridge - Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
      if (fuseWeb3 == null) {
        throw 'web3 is empty';
      }
      List transferData = await fuseWeb3!.transferTokenToForeign(
          walletAddress,
          receiverAddress,
          checksumEthereumAddress(tokenAddress),
          tokensAmount,
          token.decimals,
          network: 'fuse');
      Map<String, dynamic> feeTransferData =
          await fuseWeb3!.transferTokenOffChain(
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
      log.error('ERROR - sendTokenToForeignMultiBridge $e');
      sendFailureCallback();
    }
  };
}

ThunkAction sendNativeTokenCall(
  String receiverAddress,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      dynamic response = await api.transfer(
        fuseWeb3!,
        walletAddress,
        receiverAddress,
        num.parse(toBigInt(tokensAmount, 18).toString()),
        transactionBody: {
          "from": walletAddress,
          "to": receiverAddress,
          "value": toBigInt(tokensAmount, 18).toString(),
          "asset": 'FUSE',
          "status": 'pending',
          'type': 'SEND',
          'tokenName': 'FUSE',
          'tokenDecimal': 18,
        },
      );

      dynamic jobId = response['job']['_id'];
      log.info('sendNativeTokenCall');
      log.info('Job $jobId for sending native token sent to the relay service');

      sendSuccessCallback();
    } catch (e, s) {
      log.error('ERROR - sendNativeTokenCall ${e.toString()}');
      sendFailureCallback();
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to send native token',
      );
    }
  };
}

ThunkAction sendTokenCall(
  Token token,
  String receiverAddress,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String? receiverName,
  String? transferNote,
}) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      if (token.isNative) {
        store.dispatch(sendNativeTokenCall(
          receiverAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      } else {
        if (fuseWeb3 == null) {
          throw 'web3 is empty';
        }

        log.info(
            'Sending ${token.name} $tokensAmount from $walletAddress to $receiverAddress');
        dynamic response = await api.tokenTransfer(
          fuseWeb3!,
          walletAddress,
          token.address,
          receiverAddress,
          tokensAmount,
        );

        dynamic jobId = response['job']['_id'];
        log.info('Job $jobId for sending token sent to the relay service');

        sendSuccessCallback();
      }
    } catch (e, s) {
      log.error('ERROR - sendTokenCall ${e.toString()}');
      sendFailureCallback();
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to send token',
      );
    }
  };
}

ThunkAction joinCommunityCall(
  Community community,
  Token token,
) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      bool isMember = await graph.isCommunityMember(
        walletAddress,
        community.address,
      );
      log.info('isCommunityMember - $isMember');
      if (isMember) {
        store.dispatch(AlreadyJoinedCommunity(community.address));
      } else {
        await api.joinCommunity(
          fuseWeb3!,
          walletAddress,
          community.address,
          tokenAddress: token.address,
          originNetwork: token.originNetwork,
          communityName: community.name,
        );
      }
    } catch (e, s) {
      log.error('ERROR - joinCommunityCall ${e.toString()} ${s.toString()} ');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to join community',
      );
    }
  };
}

ThunkAction fetchCommunityMetadataCall(
  String communityAddress,
  String communityURI,
  bool isRopsten,
) {
  return (Store store) async {
    try {
      String hash = communityURI.startsWith('ipfs://')
          ? communityURI.split('://').last
          : communityURI.split('/').last;
      dynamic metadata = await api.fetchMetadata(
        hash,
        isRopsten: isRopsten || communityURI.contains('ropsten'),
      );
      if (metadata != null) {
        CommunityMetadata communityMetadata =
            CommunityMetadata.fromJson(metadata)
              ..copyWith(
                isDefaultImage: metadata['isDefault'] ?? false,
              );
        store.dispatch(
          FetchCommunityMetadataSuccess(
            metadata: communityMetadata,
            communityAddress: communityAddress.toLowerCase(),
          ),
        );
      }
    } catch (e, s) {
      log.error('ERROR - fetchCommunityMetadataCall $e');
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint:
            'ERROR while trying to fetch community metadata for $communityAddress',
      );
    }
  };
}

Future<Map<String, dynamic>> getCommunityData(
  communityAddress,
  walletAddress,
) async {
  Map<String, dynamic>? communityData = await api.getCommunityData(
    communityAddress,
    isRopsten: true,
    walletAddress: walletAddress,
  );
  if (communityData == null) {
    communityData = await api.getCommunityData(
      communityAddress,
      walletAddress: walletAddress,
    );
    return Map.from(
      {
        ...?communityData,
        'isRopsten': false,
        'originNetwork': 'mainnet',
      },
    );
  }
  return Map.from(
    {
      ...communityData,
      'isRopsten': true,
      'originNetwork': 'ropsten',
    },
  );
}

Future<Token> fetchToken(
  Community community,
  bool isRopsten,
  String originNetwork,
) async {
  if (community.homeTokenAddress != '') {
    if (fuseWeb3 == null) {
      throw 'web3 is empty';
    }
    dynamic tokenDetails = await fuseWeb3!.getTokenDetails(
      community.homeTokenAddress!,
    );
    final int decimals = tokenDetails['decimals'].toInt();
    Token? tokenInfo = new Token.fromJson({
      'name': formatTokenName(tokenDetails['name']),
      'symbol': tokenDetails['symbol'],
      'decimals': decimals,
      'amount': '0',
      'address': community.homeTokenAddress!.toLowerCase(),
    });
    return tokenInfo.copyWith(
      originNetwork: originNetwork,
      communityAddress: community.address.toLowerCase(),
    );
  } else {
    dynamic tokenInfo = await graph.getHomeBridgedToken(
      community.foreignTokenAddress!,
      isRopsten,
    );
    final token = Token.fromJson(tokenInfo).copyWith(
      originNetwork: originNetwork,
      address: tokenInfo['address'].toLowerCase(),
      timestamp: 0,
      amount: BigInt.zero,
      communityAddress: community.address.toLowerCase(),
      name: formatTokenName(tokenInfo['name']),
    );
    return token;
  }
}

ThunkAction switchToNewCommunityCall(String communityAddress) {
  return (Store store) async {
    try {
      log.info('Swithcing to new community $communityAddress');
      String walletAddress = checksumEthereumAddress(
        store.state.userState.walletAddress,
      );
      Map<String, dynamic> communityData = await getCommunityData(
        checksumEthereumAddress(communityAddress),
        walletAddress,
      );
      Community newCommunity = Community.fromJson(communityData).copyWith(
        address: communityAddress,
      );
      bool isRopsten = communityData['isRopsten'];
      String originNetwork = communityData['originNetwork'];
      Token communityToken = await fetchToken(
        newCommunity,
        isRopsten,
        originNetwork,
      );
      store.dispatch(AddCashToken(token: communityToken));
      store.dispatch(SwitchCommunitySuccess(
        community: newCommunity.copyWith(
          homeTokenAddress: communityToken.address,
        ),
      ));
      store.dispatch(
        fetchCommunityMetadataCall(
          communityAddress,
          communityData['communityURI'],
          isRopsten,
        ),
      );
      store.dispatch(
        getBusinessListCall(
          communityAddress: communityAddress,
          isRopsten: isRopsten,
        ),
      );
      if (communityAddress.toLowerCase() !=
          defaultCommunityAddress.toLowerCase()) {
        store.dispatch(
          joinCommunityCall(
            newCommunity,
            communityToken,
          ),
        );
      }
      store.dispatch(getTokenPriceCall(communityToken));
    } catch (e, s) {
      log.error('ERROR - switchToNewCommunityCall $e');
      store.dispatch(SwitchCommunityFailed(communityAddress: communityAddress));
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to switch to community $communityAddress',
      );
    }
  };
}

ThunkAction switchToExistingCommunityCall(String communityAddress) {
  return (Store store) async {
    try {
      log.info('Swithcing to existing community $communityAddress');
      String walletAddress =
          checksumEthereumAddress(store.state.userState.walletAddress);
      Map<String, dynamic> communityData = await getCommunityData(
        checksumEthereumAddress(communityAddress),
        walletAddress,
      );
      Community newCommunity = Community.fromJson(communityData).copyWith(
        address: communityAddress.toLowerCase(),
      );
      bool isRopsten = communityData['isRopsten'];
      String originNetwork = communityData['originNetwork'];
      Token communityToken = await fetchToken(
        newCommunity,
        isRopsten,
        originNetwork,
      );
      store.dispatch(AddCashToken(token: communityToken));
      store.dispatch(SwitchCommunitySuccess(
        community: newCommunity.copyWith(
          homeTokenAddress: communityToken.address,
        ),
      ));
      if (communityAddress.toLowerCase() !=
          defaultCommunityAddress.toLowerCase()) {
        store.dispatch(
          getBusinessListCall(
            communityAddress: communityAddress,
            isRopsten: isRopsten,
          ),
        );
      }
      store.dispatch(
        fetchCommunityMetadataCall(
          communityAddress,
          communityData['communityURI'],
          isRopsten,
        ),
      );
      store.dispatch(getTokenPriceCall(communityToken));
    } catch (e, s) {
      log.error('ERROR - switchToExistingCommunityCall $e');
      store.dispatch(SwitchCommunityFailed(
        communityAddress: communityAddress.toLowerCase(),
      ));
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to switch to community $communityAddress',
      );
    }
  };
}

ThunkAction refetchCommunityData() {
  return (Store store) async {
    String communityAddress = store.state.cashWalletState.communityAddress;
    log.info('refetchCommunityData refetchCommunityData $communityAddress');
    String walletAddress = store.state.userState.walletAddress;
    Community? current =
        store.state.cashWalletState.communities[communityAddress.toLowerCase()];
    if (current != null && current.name != '') {
      Map<String, dynamic> communityData = await getCommunityData(
        checksumEthereumAddress(communityAddress),
        checksumEthereumAddress(walletAddress),
      );
      bool isRopsten = communityData['isRopsten'];
      final String? bridgeDirection = communityData['bridgeDirection'];
      final String? bridgeType = communityData['bridgeType'];
      store.dispatch(
        RefreshCommunityData(
          bridgeType: bridgeType,
          bridgeDirection: bridgeDirection,
          communityAddress: communityAddress,
          plugins: PluginsConverter().fromJson(communityData['plugins']),
          webUrl: communityData['webUrl'],
        ),
      );
      store.dispatch(
        fetchCommunityMetadataCall(
          communityAddress.toLowerCase(),
          communityData['communityURI'],
          isRopsten,
        ),
      );
    } else {
      store.dispatch(switchCommunityCall(communityAddress));
    }
  };
}

ThunkAction switchCommunityCall(String communityAddress) {
  return (Store store) async {
    log.info('switchCommunityCall switchCommunityCall $communityAddress');
    try {
      bool isLoading = store.state.cashWalletState.isCommunityLoading ?? false;
      if (isLoading) return;
      Community? current = store
          .state.cashWalletState.communities[communityAddress.toLowerCase()];
      if (current?.name != '' && current?.isMember == true) {
        store.dispatch(SwitchCommunityRequested(communityAddress));
        store.dispatch(switchToExistingCommunityCall(communityAddress));
      } else {
        store.dispatch(SwitchToNewCommunity(communityAddress));
        store.dispatch(switchToNewCommunityCall(communityAddress));
      }
    } catch (e, s) {
      log.info('ERROR - switchCommunityCall $e');
      store.dispatch(
        SwitchCommunityFailed(communityAddress: communityAddress.toLowerCase()),
      );
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: 'ERROR while trying to switch to community $communityAddress',
      );
    }
  };
}

ThunkAction getBusinessListCall({String? communityAddress, bool? isRopsten}) {
  return (Store store) async {
    try {
      if (communityAddress == null) {
        communityAddress = store.state.cashWalletState.communityAddress;
      }
      store.dispatch(StartFetchingBusinessList());
      Community community =
          store.state.cashWalletState.communities[communityAddress];
      Token token =
          store.state.cashWalletState.tokens[community.homeTokenAddress];
      bool isOriginRopsten = isRopsten ??
          (token.originNetwork != null
              ? token.originNetwork == 'ropsten'
              : false);
      dynamic communityEntities =
          await graph.getCommunityBusinesses(communityAddress!);
      if (communityEntities != null) {
        List<dynamic> entities = List.from(communityEntities);
        Future<List<Business>> businesses = Future.wait(
          entities.map(
            (dynamic entity) async {
              try {
                dynamic metadata = await api.getEntityMetadata(
                  communityAddress!,
                  entity['address'],
                  isRopsten: isOriginRopsten,
                );
                return Business(
                  account: entity['address'],
                  name: metadata['name'],
                  metadata: BusinessMetadata.fromJson(
                    metadata,
                  ),
                );
              } catch (e) {
                return Business(
                  account: entity['address'],
                  name: formatAddress(entity['address']),
                  metadata: BusinessMetadata().copyWith(
                    address: entity['address'],
                  ),
                );
              }
            },
          ),
        );
        List<Business> result = await businesses;
        result..toList();
        store.dispatch(GetBusinessListSuccess(
          businessList: result,
          communityAddress: communityAddress!,
        ));
        store.dispatch(FetchingBusinessListSuccess());
      }
    } catch (e, s) {
      log.error('ERROR - getBusinessListCall $e');
      store.dispatch(FetchingBusinessListFailed());
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint:
            'ERROR while trying to fetch community businesses $communityAddress',
      );
    }
  };
}

ThunkAction getWalletActionsCall() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      WalletActions walletActions = store.state.cashWalletState.walletActions;
      Map<String, dynamic> response = await api.getActionsByWalletAddress(
        walletAddress,
        updatedAt: walletActions.updatedAt.toInt(),
      );
      Iterable<dynamic> docs = response['docs'] ?? [];
      List<WalletAction> actions = WalletActionFactory.actionsFromJson(docs);
      if (actions.isNotEmpty) {
        store.dispatch(GetActionsSuccess(
          walletActions: actions,
          updateAt: actions.last.timestamp,
        ));
      }
    } catch (e, s) {
      log.error('ERROR - getWalletActionsCall ${e.toString()} ${s.toString()}');
    }
  };
}

ThunkAction updateTokensPrices() {
  return (Store store) async {
    Map<String, Token> tokens = store.state.cashWalletState.tokens;
    for (Token token in tokens.values) {
      store.dispatch(getTokenPriceCall(token));
      store.dispatch(getTokenPriceChangeCall(token));
      // store.dispatch(getTokenStatsCall(token));
    }
  };
}

ThunkAction getTokenPriceCall(Token token) {
  return (Store store) async {
    try {
      void Function(Price) onDone = (Price priceInfo) {
        store.dispatch(
          UpdateTokenPrice(
            price: priceInfo,
            tokenAddress: token.address,
          ),
        );
      };
      void Function(Object error, StackTrace stackTrace) onError =
          (Object error, StackTrace stackTrace) {
        log.error('Fetch token price error for - ${token.name} - $error ');
      };
      await token.fetchLatestPrice(
        onDone: onDone,
        onError: onError,
      );
    } catch (e) {
      log.error('Error getTokenPriceCall for ${token.name}');
    }
  };
}

ThunkAction getTokenPriceDiffCall(String tokenAddress, String limit) {
  return (Store store) async {
    try {
      final num priceDiff = await fuseSwapService.priceDiff(
        tokenAddress,
        limit,
      );
      store.dispatch(GetTokenPriceDiffSuccess(
        priceDiff: priceDiff,
        tokenAddress: tokenAddress,
        priceDiffLimitInDays: int.parse(limit),
      ));
    } catch (e) {}
  };
}

ThunkAction getTokenPriceChangeCall(Token token) {
  return (Store store) async {
    try {
      void Function(num) onDone = (num priceChange) {
        store.dispatch(
          GetTokenPriceChangeSuccess(
            priceChange: priceChange,
            tokenAddress: token.address,
          ),
        );
      };
      void Function(Object error, StackTrace stackTrace) onError =
          (Object error, StackTrace stackTrace) {
        log.error('Error getTokenPriceChangeCall - ${token.name} - $error ');
      };
      // log.info('Fetching token price change ${token.name}');
      await token.fetchPriceChange(
        onDone: onDone,
        onError: onError,
      );
    } catch (e) {
      log.error('Error getTokenPriceChangeCall for ${token.name}');
    }
  };
}

ThunkAction getTokenStatsCall(
  Token token, {
  String limit = '30',
}) {
  return (Store store) async {
    try {
      void Function(List<Stats>) onDone = (List<Stats> stats) {
        store.dispatch(
          GetTokenStatsSuccess(
            stats: stats,
            tokenAddress: token.address,
          ),
        );
      };
      void Function(Object error, StackTrace stackTrace) onError = (
        Object error,
        StackTrace stackTrace,
      ) {
        log.error('Error getTokenStatsCall - ${token.name} - $error ');
      };
      await token.fetchStats(
        onDone: onDone,
        onError: onError,
        limit: limit,
      );
    } catch (e) {
      log.error('Error getTokenStatsCall for ${token.name}');
    }
  };
}

ThunkAction getTokenWalletActionsCall(Token token) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      Map<String, dynamic> response = await api.getActionsByWalletAddress(
        walletAddress,
        updatedAt: token.walletActions!.updatedAt.toInt(),
        tokenAddress: token.address,
      );
      Iterable<dynamic> docs = response['docs'] ?? [];
      List<WalletAction> actions = WalletActionFactory.actionsFromJson(docs);
      if (actions.isNotEmpty) {
        store.dispatch(GetTokenWalletActionsSuccess(
          walletActions: actions,
          updateAt: actions.last.timestamp,
          token: token,
        ));
      }
    } catch (e) {
      log.error('Error getTokenWalletActionsCall for ${token.name}');
    }
  };
}

ThunkAction sendTokenToContactCall(
  Token token,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String? receiverName,
  String? transferNote,
}) {
  return (Store store) async {
    try {
      Map? wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      log.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      String? walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(
          token,
          contactPhoneNumber,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
        ));
      } else {
        store.dispatch(sendTokenCall(
          token,
          walletAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName,
          transferNote: transferNote,
        ));
      }
    } catch (e) {
      log.error('ERROR - sendTokenToContactCall $e');
    }
  };
}

ThunkAction swapHandler(
  SwapRequestBody swapRequestBody,
  SwapCallParameters swapCallParameters,
  TradeInfo tradeInfo,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      String swapData = swapCallParameters.rawTxn['data'].replaceFirst(
        '0x',
        '',
      );
      Map<String, dynamic> response = await api.approveTokenAndCallContract(
        fuseWeb3!,
        swapRequestBody.recipient,
        swapRequestBody.currencyIn,
        swapCallParameters.rawTxn['to'],
        num.parse(swapRequestBody.amountIn),
        swapData,
        network: 'fuse',
        transactionBody: Map.from(
          {
            "to": swapRequestBody.recipient,
            "status": 'pending',
            "isSwap": true,
            "tradeInfo": tradeInfo.toJson(),
          },
        ),
        txMetadata: {
          "currencyOut": swapRequestBody.currencyOut,
        },
      );
      sendSuccessCallback();
      String swapJobId = response['job']['_id'];
      log.info('Job $swapJobId for swap');
    } catch (error, stackTrace) {
      log.error(
          'Error in Get swapHandler ${error.toString()} ${stackTrace.toString()}');
      sendFailureCallback();
    }
  };
}

ThunkAction getFuseBalance() {
  return (Store store) async {
    try {
      BigInt fuseBalance =
          store.state.cashWalletState.tokens[fuseToken.address]?.amount ??
              BigInt.zero;
      String walletAddress = store.state.userState.walletAddress;
      if (fuseWeb3 == null) {
        throw 'web3 is empty';
      }
      EtherAmount balance = await fuseWeb3!.getBalance(
        address: walletAddress,
      );
      if (balance.getInWei.compareTo(fuseBalance) != 0) {
        store.dispatch(
          AddCashToken(
            token: fuseToken.copyWith(
              amount: balance.getInWei,
            ),
          ),
        );
        store.dispatch(getTokenPriceCall(fuseToken));
      }
    } catch (error) {
      log.error('Error in Get Fuse Balance ${error.toString()}');
    }
  };
}

ThunkAction refresh() {
  return (Store store) async {
    store.dispatch(ResetTokenTxs());
    store.dispatch(fetchListOfTokensByAddress());
    store.dispatch(startFetchingCall());
    store.dispatch(startFetchTokensBalances());
    store.dispatch(updateTokensPrices());
  };
}
