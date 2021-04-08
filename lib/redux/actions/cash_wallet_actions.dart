import 'dart:async';
import 'dart:io';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
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
  AddCashTokens({this.tokens});
}

class AddCashToken {
  final Token token;
  AddCashToken({this.token});
}

class UpdateTokenPrice {
  final Price price;
  final String tokenAddress;

  UpdateTokenPrice({
    this.price,
    this.tokenAddress,
  });
}

class SetDefaultCommunity {
  String defaultCommunity;
  SetDefaultCommunity(this.defaultCommunity);
}

class AddCommunities {
  Map<String, Community> communities;
  AddCommunities({this.communities});
}

class GetWalletAddressesSuccess {
  final List<String> networks;
  final String walletAddress;
  final bool backup;
  GetWalletAddressesSuccess({
    this.backup,
    this.networks,
    this.walletAddress,
  });
}

class GetTokenBalanceSuccess {
  final String tokenAddress;
  final BigInt tokenBalance;
  GetTokenBalanceSuccess({this.tokenBalance, this.tokenAddress});
}

class AlreadyJoinedCommunity {
  final String communityAddress;
  AlreadyJoinedCommunity(this.communityAddress);
}

class JoinCommunity {
  final Map community;
  JoinCommunity({this.community});
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
    this.community,
  });
}

class RefreshCommunityData {
  final Plugins plugins;
  final String communityAddress;
  final String bridgeType;
  final String bridgeDirection;
  final String webUrl;
  RefreshCommunityData({
    this.bridgeDirection,
    this.bridgeType,
    this.plugins,
    this.communityAddress,
    this.webUrl,
  });
}

class FetchCommunityMetadataSuccess {
  final String communityAddress;
  final CommunityMetadata metadata;
  FetchCommunityMetadataSuccess({this.communityAddress, this.metadata});
}

class SwitchCommunityFailed {
  final String communityAddress;
  SwitchCommunityFailed({this.communityAddress});
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
  GetBusinessListSuccess({this.businessList, this.communityAddress});
}

// class GetTokenTransfersListSuccess {
//   final String tokenAddress;
//   final List<Transaction> tokenTransfers;
//   GetTokenTransfersListSuccess({this.tokenAddress, this.tokenTransfers});
// }

class GetActionsSuccess {
  final List<WalletAction> walletActions;
  final num updateAt;
  GetActionsSuccess({this.updateAt, this.walletActions});
}

class GetTokenWalletActionsSuccess {
  final Token token;
  final List<WalletAction> walletActions;
  final num updateAt;
  GetTokenWalletActionsSuccess({
    this.updateAt,
    this.walletActions,
    this.token,
  });
}

class StartBalanceFetchingSuccess {
  StartBalanceFetchingSuccess();
}

class SetIsTransfersFetching {
  final bool isFetching;
  SetIsTransfersFetching({this.isFetching});
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

// class InviteSendSuccess {
//   final String tokenAddress;
//   final Transaction invite;
//   InviteSendSuccess({this.invite, this.tokenAddress});
// }

// class ReplaceTransaction {
//   final String tokenAddress;
//   final Transaction transaction;
//   final Transaction transactionToReplace;
//   ReplaceTransaction(
//       {this.transaction, this.transactionToReplace, this.tokenAddress});
// }

// class AddTransaction {
//   final String tokenAddress;
//   final Transaction transaction;
//   AddTransaction({this.transaction, this.tokenAddress});
// }

// class SetIsJobProcessing {
//   final bool isFetching;
//   SetIsJobProcessing({this.isFetching});
// }

class SetIsFetchingBalances {
  final bool isFetching;
  SetIsFetchingBalances({this.isFetching});
}

ThunkAction enablePushNotifications() {
  return (Store store) async {
    try {
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      void iosPermission() {
        var firebaseMessaging2 = firebaseMessaging;
        firebaseMessaging2.requestNotificationPermissions(
            IosNotificationSettings(sound: true, badge: true, alert: true));
        firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
          log.info("Settings registered: $settings");
        });
      }

      if (Platform.isIOS) iosPermission();
      String token = await firebaseMessaging.getToken();
      log.info("Firebase messaging token $token");

      String walletAddress = store.state.userState.walletAddress;
      await api.updateFirebaseToken(walletAddress, token);
      await Segment.setContext({
        'device': {'token': token},
      });

      void switchOnPush(message) {
        final dynamic data = message['data'] ?? message;
        final String communityAddress = data['communityAddress'];
        if (communityAddress != null && communityAddress.isNotEmpty) {
          store.dispatch(switchCommunityCall(communityAddress));
        }
      }

      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          switchOnPush(message);
        },
        onResume: (Map<String, dynamic> message) async {
          switchOnPush(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          switchOnPush(message);
        },
      );
    } catch (e) {
      log.error('ERROR - Enable push notifications: $e');
    }
  };
}

ThunkAction segmentTrackCall(eventName, {Map<String, dynamic> properties}) {
  return (Store store) async {
    try {
      log.info('Track - $eventName');
      Segment.track(eventName: eventName, properties: properties);
    } catch (e, s) {
      log.error('ERROR - segment track call: $e');
      await Sentry.captureException(e, stackTrace: s);
    }
  };
}

ThunkAction segmentAliasCall(String userId) {
  return (Store store) async {
    try {
      log.info('Alias - $userId');
      Segment.alias(alias: userId);
    } catch (e, s) {
      log.error('ERROR - segment alias call: $e');
      await Sentry.captureException(e, stackTrace: s);
    }
  };
}

ThunkAction segmentIdentifyCall(Map<String, dynamic> traits) {
  return (Store store) async {
    try {
      UserState userState = store.state.userState;
      String fullPhoneNumber = store.state.userState.phoneNumber;
      log.info('Identify - $fullPhoneNumber');
      traits = traits ?? new Map<String, dynamic>();
      DateTime installedAt = userState.installedAt;
      if (installedAt == null) {
        installedAt = DateTime.now().toUtc();
        store.dispatch(new JustInstalled(installedAt));
      }
      traits["Installed At"] = installedAt.toIso8601String();
      Segment.identify(userId: fullPhoneNumber, traits: traits);
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
      log.info('Start Fetching token balances');
      Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
          (Timer timer) async {
        String currentWalletAddress = store.state.userState.walletAddress;
        if (currentWalletAddress != walletAddress) {
          log.error('Timer stopped - startFetchTokensBalances');
          store.dispatch(SetIsFetchingBalances(isFetching: false));
          timer.cancel();
          return false;
        }
        Map<String, Token> tokens = store.state.cashWalletState.tokens;
        store.dispatch(getFuseBalance());
        for (Token token in tokens.values) {
          if (![null, ''].contains(token.address)) {
            store.dispatch(getTokenBalanceCall(token));
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
      log.info('Timer start - startFetchingCall');
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
        Community community =
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
      await Sentry.captureException(e, stackTrace: s);
    }
  };
}

ThunkAction generateWalletSuccessCall(dynamic walletData) {
  return (Store store) async {
    String walletAddress = walletData["walletAddress"];
    log.info('walletAddress walletAddress $walletAddress');
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(setupWalletCall(walletData));
      store.dispatch(saveUserInDB(walletAddress));
      store.dispatch(enablePushNotifications());
      store.dispatch(segmentTrackCall('Wallet: Wallet Generated'));
      store.dispatch(segmentIdentifyCall(
        Map<String, dynamic>.from({
          "Wallet Generated": true,
          "App name": 'Fuse',
          "Phone Number": store.state.userState.phoneNumber,
          "Wallet Address": store.state.userState.walletAddress,
          "Account Address": store.state.userState.accountAddress,
          "Display Name": store.state.userState.displayName
        }),
      ));
    }
  };
}

ThunkAction getTokenBalanceCall(Token token) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      void Function(BigInt) onDone = (BigInt balance) {
        log.info('${token.name} balance updated');
        store.dispatch(
          GetTokenBalanceSuccess(
            tokenBalance: balance,
            tokenAddress: token.address,
          ),
        );
        store.dispatch(
          segmentIdentifyCall(
            Map<String, dynamic>.from({
              '${token?.name} Balance':
                  formatValue(balance, token.decimals, withPrecision: true),
              "DisplayBalance":
                  formatValue(balance, token.decimals, withPrecision: true)
            }),
          ),
        );
      };
      void Function(Object error, StackTrace stackTrace) onError = (
        Object e,
        StackTrace s,
      ) async {
        log.error('Error - fetch token balance ${token.name} $e');
      };
      await token.fetchTokenBalance(
        walletAddress,
        onDone: onDone,
        onError: onError,
      );
    } catch (e) {
      log.error('ERROR - getTokenBalanceCall $e');
    }
  };
}

ThunkAction inviteAndSendCall(
  Token token,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String receiverName,
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
    } catch (e) {
      log.error('ERROR - inviteAndSendCall $e');
    }
  };
}

ThunkAction fetchListOfTokensByAddress() {
  return (Store store) async {
    String walletAddress = store.state.userState.walletAddress;
    List<Token> tokensList = await fuseExplorerApi.getListOfTokensByAddress(
      walletAddress,
    );
    CashWalletState cashWalletState = store.state.cashWalletState;
    Map<String, Token> newTokens = Map<String, Token>.from(tokensList.fold(
      {},
      (previousValue, element) {
        if (!cashWalletState.tokens.containsKey(element.address) &&
            num.parse(formatValue(element.amount, element.decimals,
                        withPrecision: true))
                    .compareTo(0) ==
                1) {
          log.info('newToken newToken ${element.name}');
          previousValue[element.address] = element;
        }
        return previousValue;
      },
    ));
    if (newTokens.isNotEmpty) {
      log.info('newTokens newTokens ${newTokens.length}');
      store.dispatch(AddCashTokens(tokens: newTokens));
      newTokens.forEach((key, value) {
        store.dispatch(getTokenPriceCall(value));
      });
    }
  };
}

ThunkAction sendTokenToForeignMultiBridge(
    Token token,
    String receiverAddress,
    num tokensAmount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    {String receiverName,
    String transferNote}) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      String tokenAddress = token?.address;
      dynamic response;
      num feeAmount = 20;
      log.info(
          'Multi bridge - Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
      List transferData = await fuseWeb3.transferTokenToForeign(
          walletAddress,
          receiverAddress,
          checksumEthereumAddress(tokenAddress),
          tokensAmount,
          token.decimals,
          network: 'fuse');
      Map<String, dynamic> feeTransferData =
          await fuseWeb3.transferTokenOffChain(
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
        fuseWeb3,
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
    } catch (e) {
      log.error('ERROR - sendNativeTokenCall ${e.toString()}');
      sendFailureCallback();
    }
  };
}

ThunkAction sendTokenCall(
  Token token,
  String receiverAddress,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String receiverName,
  String transferNote,
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
        Map<String, Community> communities =
            store.state.cashWalletState.communities;
        String tokenAddress = token?.address;
        Community community = communities.values.firstWhere(
            (element) =>
                element?.homeTokenAddress?.toLowerCase() ==
                tokenAddress?.toLowerCase(),
            orElse: () => null);

        dynamic response;
        if (![null, ''].contains(token?.communityAddress) &&
            receiverAddress?.toLowerCase() ==
                community?.homeBridgeAddress?.toLowerCase()) {
          num feeAmount = 20;
          log.info(
              'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
          Map<String, dynamic> transferData =
              await fuseWeb3.transferTokenOffChain(
            walletAddress,
            tokenAddress,
            receiverAddress,
            tokensAmount,
          );
          Map<String, dynamic> feeTransferData =
              await fuseWeb3.transferTokenOffChain(
            walletAddress,
            tokenAddress,
            Addresses.FEE_ADDRESS,
            feeAmount,
          );
          response = await api.multiRelay([transferData, feeTransferData]);
        } else {
          log.info(
              'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
          response = await api.tokenTransfer(
            fuseWeb3,
            walletAddress,
            tokenAddress,
            receiverAddress,
            tokensAmount,
          );
        }

        dynamic jobId = response['job']['_id'];
        log.info('Job $jobId for sending token sent to the relay service');

        sendSuccessCallback();
      }
    } catch (e) {
      log.error('ERROR - sendTokenCall ${e.toString()}');
      sendFailureCallback();
    }
  };
}

ThunkAction joinCommunityCall({
  Community community,
  Token token,
}) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      dynamic communityData = await graph.getCommunityByAddress(
        community.address,
      );
      String entitiesListAddress = communityData["entitiesList"]["address"];
      bool isMember = await graph.isCommunityMember(
        walletAddress,
        entitiesListAddress,
      );
      log.info('isCommunityMember - $isMember');
      if (isMember) {
        store.dispatch(AlreadyJoinedCommunity(community.address));
      } else {
        await api.joinCommunity(
          fuseWeb3,
          walletAddress,
          community.address,
          tokenAddress: token.address,
          originNetwork: token.originNetwork,
          communityName: community.name,
        );
      }
    } catch (e) {
      log.error('ERROR - joinCommunityCall ${e.toString()}');
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
      CommunityMetadata communityMetadata = CommunityMetadata();
      if (communityURI != null) {
        String hash = communityURI.startsWith('ipfs://')
            ? communityURI.split('://').last
            : communityURI.split('/').last;
        dynamic metadata = await api.fetchMetadata(
          hash,
          isRopsten: isRopsten,
        );
        communityMetadata = communityMetadata.copyWith(
          image: metadata['image'],
          coverPhoto: metadata['coverPhoto'],
          imageUri: metadata['imageUri'] ?? null,
          coverPhotoUri: metadata['coverPhotoUri'] ?? null,
          isDefaultImage: metadata['isDefault'] ?? false,
        );
      }
      store.dispatch(FetchCommunityMetadataSuccess(
          metadata: communityMetadata,
          communityAddress: communityAddress.toLowerCase()));
    } catch (e, s) {
      log.error('ERROR - fetchCommunityMetadataCall $e');
      await Sentry.captureException(e, stackTrace: s);
    }
  };
}

Future<Map<String, dynamic>> getCommunityData(
  communityAddress,
  walletAddress,
) async {
  Map<String, dynamic> communityData = await api.getCommunityData(
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
        ...communityData,
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
  if (community.homeTokenAddress != null &&
      community.homeTokenAddress.isNotEmpty) {
    Token tokenInfo = await fuseExplorerApi.getTokenInfo(
      community.homeTokenAddress,
    );
    return tokenInfo.copyWith(
      originNetwork: originNetwork,
      communityAddress: community.address.toLowerCase(),
    );
  } else {
    dynamic tokenInfo = await graph.getHomeBridgedToken(
      community.foreignTokenAddress,
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
        segmentTrackCall(
          "Wallet: Switch Community",
          properties: Map<String, dynamic>.from({
            "Community Name": newCommunity.name,
            "Community Address": communityAddress,
            "Token Address": communityToken.address,
            "Token Symbol": communityToken.symbol,
            "Origin Network": originNetwork
          }),
        ),
      );
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
      store.dispatch(
        joinCommunityCall(
          token: communityToken,
          community: newCommunity,
        ),
      );
    } catch (e, s) {
      log.error('ERROR - switchToNewCommunityCall $e');
      store.dispatch(SwitchCommunityFailed(communityAddress: communityAddress));
      await Sentry.captureException(e, stackTrace: s);
    }
  };
}

ThunkAction switchToExistingCommunityCall(String communityAddress) {
  return (Store store) async {
    try {
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
      store.dispatch(
        getBusinessListCall(
          communityAddress: communityAddress,
          isRopsten: isRopsten,
        ),
      );
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
      await Sentry.captureException(e, stackTrace: s);
      store.dispatch(SwitchCommunityFailed(
          communityAddress: communityAddress.toLowerCase()));
    }
  };
}

ThunkAction refetchCommunityData() {
  return (Store store) async {
    String communityAddress = store.state.cashWalletState.communityAddress;
    log.info('refetchCommunityData refetchCommunityData $communityAddress');
    String walletAddress = store.state.userState.walletAddress;
    Community current =
        store.state.cashWalletState.communities[communityAddress.toLowerCase()];
    if (current != null && current.name != null) {
      Map<String, dynamic> communityData = await getCommunityData(
        checksumEthereumAddress(communityAddress),
        checksumEthereumAddress(walletAddress),
      );
      bool isRopsten = communityData['isRopsten'];
      final String bridgeDirection = communityData['bridgeDirection'] ?? null;
      final String bridgeType = communityData['bridgeType'] ?? null;
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
      Community current = store
          .state.cashWalletState.communities[communityAddress.toLowerCase()];
      if (current != null &&
          current.name != null &&
          current.isMember != null &&
          current.isMember) {
        store.dispatch(SwitchCommunityRequested(communityAddress));
        store.dispatch(switchToExistingCommunityCall(communityAddress));
      } else {
        store.dispatch(SwitchToNewCommunity(communityAddress));
        store.dispatch(switchToNewCommunityCall(communityAddress));
      }
    } catch (e, s) {
      log.info('ERROR - switchCommunityCall $e');
      await Sentry.captureException(e, stackTrace: s);
      store.dispatch(SwitchCommunityFailed(
          communityAddress: communityAddress.toLowerCase()));
    }
  };
}

ThunkAction getBusinessListCall({String communityAddress, bool isRopsten}) {
  return (Store store) async {
    try {
      if (communityAddress == null) {
        communityAddress = store.state.cashWalletState.communityAddress;
      }
      store.dispatch(StartFetchingBusinessList());
      Community community =
          store.state.cashWalletState.communities[communityAddress];
      Token token =
          store.state.cashWalletState.tokens[community?.homeTokenAddress];
      bool isOriginRopsten = isRopsten ??
          (token?.originNetwork != null
              ? token?.originNetwork == 'ropsten'
              : false);
      dynamic communityEntities =
          await graph.getCommunityBusinesses(communityAddress);
      if (communityEntities != null) {
        List<dynamic> entities = List.from(communityEntities);
        Future<List<Business>> businesses = Future.wait(
          entities.map(
            (dynamic entity) async {
              try {
                dynamic metadata = await api.getEntityMetadata(
                    communityAddress, entity['address'],
                    isRopsten: isOriginRopsten);
                return Business(
                  account: entity['address'],
                  name: metadata['name'] ?? '',
                  metadata: BusinessMetadata.fromJson(
                    metadata ?? {},
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
            businessList: result, communityAddress: communityAddress));
        store.dispatch(FetchingBusinessListSuccess());
      }
    } catch (e) {
      log.error('ERROR - getBusinessListCall $e');
      store.dispatch(FetchingBusinessListFailed());
    }
  };
}

ThunkAction getWalletActionsCall() {
  return (Store store) async {
    String walletAddress = store.state.userState.walletAddress;
    WalletActions walletActions = store.state.cashWalletState.walletActions;
    Map<String, dynamic> response = await api.getActionsByWalletAddress(
      walletAddress,
      updatedAt: walletActions?.updatedAt ?? 0,
    );
    Iterable<dynamic> docs = response['docs'] ?? [];
    List<WalletAction> actions = WalletActionFactory.actionsFromJson(docs);
    if (actions.isNotEmpty) {
      store.dispatch(GetActionsSuccess(
        walletActions: actions,
        updateAt: actions.last.timestamp,
      ));
      store.dispatch(updateTotalBalance());
    }
  };
}

ThunkAction getTokenPriceCall(Token token) {
  return (Store store) async {
    void Function(Price) onDone = (Price priceInfo) {
      log.info('Fetch token price for ${token.toString()}');
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
    log.info('fetching price of token ${token.name} ${token.address}');
    await token.fetchTokenLatestPrice(
      onDone: onDone,
      onError: onError,
    );
    store.dispatch(updateTotalBalance());
  };
}

ThunkAction getTokenWalletActionsCall(Token token) {
  return (Store store) async {
    String walletAddress = store.state.userState.walletAddress;
    Map<String, dynamic> response = await api.getActionsByWalletAddress(
      walletAddress,
      updatedAt: token.walletActions?.updatedAt ?? 0,
      tokenAddress: token?.address,
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
  };
}

ThunkAction sendTokenToContactCall(
  Token token,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String receiverName,
  String transferNote,
}) {
  return (Store store) async {
    try {
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      log.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
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
        fuseWeb3,
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
    } catch (error) {
      log.error('Error in Get swapHandler ${error.toString()}');
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
      EtherAmount balance = await fuseWeb3.getBalance(
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
