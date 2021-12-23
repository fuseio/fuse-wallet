import 'dart:async';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supervecina/common/di/di.dart';
import 'package:supervecina/constants/variables.dart';
import 'package:supervecina/models/actions/actions.dart';
import 'package:supervecina/models/actions/wallet_action.dart';
import 'package:supervecina/models/community/business.dart';
import 'package:supervecina/models/cash_wallet_state.dart';
import 'package:supervecina/models/community/community.dart';
import 'package:supervecina/models/community/community_metadata.dart';
import 'package:supervecina/models/plugins/plugins.dart';
import 'package:supervecina/models/swap/swap.dart';
import 'package:supervecina/models/tokens/price.dart';
import 'package:supervecina/models/tokens/stats.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/models/user_state.dart';
import 'package:supervecina/models/wallet/wallet_modules.dart';
import 'package:supervecina/redux/actions/user_actions.dart';
import 'package:supervecina/utils/addresses.dart';
import 'package:supervecina/utils/constants.dart';
import 'package:supervecina/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supervecina/services.dart';
import 'package:supervecina/utils/log/log.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, Web3;

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

class GetWalletDataSuccess {
  final List<String> networks;
  final String walletAddress;
  final bool backup;
  final WalletModules walletModules;

  GetWalletDataSuccess({
    required this.backup,
    required this.networks,
    required this.walletAddress,
    required this.walletModules,
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
  final int nextPage;
  GetActionsSuccess({
    required this.nextPage,
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

class SetIsFetchingBalances {
  final bool isFetching;
  SetIsFetchingBalances({
    required this.isFetching,
  });
}

class SetShowDepositBanner {}

ThunkAction enablePushNotifications(String walletAddress) {
  return (Store store) async {
    try {
      await FirebaseMessaging.instance.requestPermission(
        sound: true,
        badge: true,
        alert: true,
      );
      final String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        log.info("Firebase messaging token $token");
        await walletApi.updateFirebaseToken(walletAddress, token);
      }
    } catch (e) {
      log.error('ERROR - Enable push notifications: $e');
    }
  };
}

ThunkAction segmentIdentifyCall(Map<String, dynamic>? traits) {
  return (Store store) async {
    try {
      UserState userState = store.state.userState;
      String fullPhoneNumber = store.state.userState.phoneNumber;
      traits = traits ?? {};
      DateTime? installedAt = userState.installedAt;
      if (installedAt == null) {
        log.info('Identify - $fullPhoneNumber');
        installedAt = DateTime.now().toUtc();
        store.dispatch(JustInstalled(installedAt));
      }
      traits?["Installed At"] = installedAt.toIso8601String();
    } catch (e, s) {
      log.error('ERROR - segment identify call: $e');
      await Sentry.captureException(e, stackTrace: s);
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
      Timer.periodic(Duration(seconds: Variables.intervalSeconds),
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
      store.dispatch(SetIsTransfersFetching(isFetching: true));
      Timer.periodic(
        Duration(seconds: Variables.intervalSeconds),
        (Timer t) async {
          String currentWalletAddress = store.state.userState.walletAddress;
          if (currentWalletAddress != walletAddress) {
            log.error('Timer stopped - startFetchingCall');
            store.dispatch(SetIsTransfersFetching(isFetching: false));
            t.cancel();
            return;
          }
          store.dispatch(fetchTokenlist());
          CashWalletState cashWalletState = store.state.cashWalletState;
          final WalletActions? walletActions = cashWalletState.walletActions;
          if (walletActions != null && walletActions.list.isNotEmpty) {
            Map<String, dynamic> res =
                await walletApi.getActionsByWalletAddress(
              walletAddress,
              updatedAt: walletActions.list.last.timestamp + 1,
            );
            Iterable<dynamic> docs = res['docs'] ?? [];
            if (docs.isNotEmpty) {
              store.dispatch(getWalletActionsCall(pageIndex: 1));
            }
          } else {
            store.dispatch(getWalletActionsCall(pageIndex: 1));
          }
        },
      );
    }
  };
}

ThunkAction createAccountWalletCall() {
  return (Store store) async {
    try {
      Map<String, dynamic> response = await walletApi.createWallet(
        communityAddress: defaultCommunityAddress,
      );
      if (!response.containsKey('job')) {
        log.info('Wallet already exists');
        final Map<String, dynamic> data = Map<String, dynamic>.from({
          ...response,
        });
        store.dispatch(generateWalletSuccessCall(data));
        store.dispatch(switchCommunityCall(
          defaultCommunityAddress,
          walletAddress: response['walletAddress'],
        ));
      } else {
        final Map jobData = response['job']['data'];
        final String walletAddress = jobData['walletAddress'];
        Map<String, dynamic> walletData = Map<String, dynamic>.from({
          ...jobData,
          'networks': ['fuse'],
        });
        store.dispatch(generateWalletSuccessCall(walletData));
        store.dispatch(
          switchCommunityCall(
            defaultCommunityAddress,
            walletAddress: walletAddress,
          ),
        );
      }
    } catch (e, s) {
      log.error(
        'ERROR - createAccountWalletCal',
        error: e,
        stackTrace: s,
      );
      await Sentry.captureException(
        Exception('Error in Create Wallet: ${e.toString()}'),
        stackTrace: s,
        hint: 'Error in Create Wallet',
      );
    }
  };
}

ThunkAction generateWalletSuccessCall(Map<String, dynamic> walletData) {
  return (Store store) async {
    String? walletAddress = walletData["walletAddress"];
    log.info('walletAddress walletAddress $walletAddress');
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(enablePushNotifications(walletAddress));
      store.dispatch(setupWalletCall(walletData));
      store.dispatch(saveUserProfile(walletAddress));
      store.dispatch(identifyCall(wallet: walletAddress));
    }
  };
}

ThunkAction getTokenBalanceCall(Token token) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      void onDone(BigInt balance) {
        store.dispatch(
          GetTokenBalanceSuccess(
            tokenBalance: balance,
            tokenAddress: token.address,
          ),
        );
      }

      void onError(
        Object e,
        StackTrace s,
      ) {
        log.error(
          'Error - fetch token balance ${token.name}',
          error: e,
          stackTrace: s,
        );
      }

      await token.fetchBalance(
        walletAddress,
        onDone: onDone,
        onError: onError,
      );
    } catch (e, s) {
      log.error(
        'Error - fetch token balance ${token.name}',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction inviteAndSendCall(
  Token token,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      String senderName = store.state.userState.displayName;
      final response = await walletApi.invite(
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
        ),
      );
      sendSuccessCallback();
      store.dispatch(loadContacts());
    } catch (e, s) {
      log.error(
        'ERROR - inviteAndSendCall',
        error: e,
        stackTrace: s,
      );
      await Sentry.captureException(
        Exception('Invite user & send token: ${e.toString()}'),
        stackTrace: s,
        hint: 'ERROR while trying to invite user & send',
      );
    }
  };
}

ThunkAction fetchTokenlist() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      List<Token> tokensList = await fuseExplorerApi.fetchTokenlist(
        walletAddress,
      );
      CashWalletState cashWalletState = store.state.cashWalletState;
      Map<String, Token> newTokens = Map<String, Token>.from(
        tokensList.fold(
          {},
          (previousValue, element) {
            if (!cashWalletState.tokens.containsKey(element.address) &&
                num.parse(element.getBalance(true)).compareTo(0) == 1) {
              log.info('New token added ${element.name}');
              previousValue[element.address] = element;
            }
            return previousValue;
          },
        ),
      );
      if (newTokens.isNotEmpty) {
        store.dispatch(AddCashTokens(tokens: newTokens));
        // Future.delayed(Duration(seconds: Variables.intervalSeconds), () {
        //   store.dispatch(updateTokensPrices());
        // });
      }
    } catch (e, s) {
      log.error(
        'ERROR - fetchTokenlist',
        error: e,
        stackTrace: s,
      );
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
      dynamic response = await walletApi.transfer(
        getIt<Web3>(instanceName: 'fuseWeb3'),
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
      log.error(
        'ERROR - sendNativeTokenCall',
        error: e,
        stackTrace: s,
      );
      sendFailureCallback();
      await Sentry.captureException(
        Exception('Send native (FUSE) token: ${e.toString()}'),
        stackTrace: s,
        hint: 'Send native (FUSE) token',
      );
    }
  };
}

ThunkAction sendTokenCall(
  Token token,
  String receiverAddress,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
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
        log.info(
            'Sending ${token.name} $tokensAmount from $walletAddress to $receiverAddress');
        dynamic response = await walletApi.tokenTransfer(
          getIt<Web3>(instanceName: 'fuseWeb3'),
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
      log.error(
        'ERROR - sendTokenCall',
        error: e,
        stackTrace: s,
      );
      sendFailureCallback();
      await Sentry.captureException(
        Exception('Send token: ${e.toString()}'),
        stackTrace: s,
        hint: 'Send token',
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
      dynamic communityData =
          await graph.getCommunityByAddress(community.address);
      bool isMember = await graph.isCommunityMember(
        walletAddress,
        communityData['entitiesList']['address'],
      );
      if (isMember) {
        store.dispatch(AlreadyJoinedCommunity(community.address));
      } else {
        await walletApi.joinCommunity(
          getIt<Web3>(instanceName: 'fuseWeb3'),
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
) {
  return (Store store) async {
    try {
      CommunityMetadata communityMetadata = CommunityMetadata();
      String hash = communityURI.startsWith('ipfs://')
          ? communityURI.split('://').last
          : communityURI.split('/').last;
      dynamic metadata = await api.fetchMetadata(
        hash,
        isRopsten: false,
      );
      communityMetadata = communityMetadata.copyWith(
        image: metadata['image'],
        coverPhoto: metadata['coverPhoto'],
        imageUri: metadata['imageUri'],
        coverPhotoUri: metadata['coverPhotoUri'],
        isDefaultImage: metadata['isDefault'] ?? false,
      );
      store.dispatch(
        FetchCommunityMetadataSuccess(
          metadata: communityMetadata,
          communityAddress: communityAddress.toLowerCase(),
        ),
      );
    } catch (e, s) {
      log.error(
        'ERROR - fetchCommunityMetadataCall',
        error: e,
        stackTrace: s,
      );
      await Sentry.captureException(
        Exception(
            'ERROR while trying to fetch community metadata: ${e.toString()}'),
        stackTrace: s,
        hint: 'ERROR while trying to fetch community metadata',
      );
    }
  };
}

Future<Token> fetchToken(
  Community community,
) async {
  if (community.homeTokenAddress != '') {
    dynamic tokenDetails =
        await getIt<Web3>(instanceName: 'fuseWeb3').getTokenDetails(
      community.homeTokenAddress!,
    );
    final int decimals = tokenDetails['decimals'].toInt();
    Token? tokenInfo = Token.fromJson({
      'name': formatTokenName(tokenDetails['name']),
      'symbol': tokenDetails['symbol'],
      'decimals': decimals,
      'amount': '0',
      'address': community.homeTokenAddress!.toLowerCase(),
    });
    return tokenInfo.copyWith(
      originNetwork: 'mainnet',
      communityAddress: community.address.toLowerCase(),
    );
  } else {
    dynamic tokenInfo = await graph.getHomeBridgedToken(
      community.foreignTokenAddress!,
      false,
    );
    final token = Token.fromJson(tokenInfo).copyWith(
      originNetwork: 'mainnet',
      address: tokenInfo['address'].toLowerCase(),
      timestamp: 0,
      amount: BigInt.zero,
      communityAddress: community.address.toLowerCase(),
      name: formatTokenName(tokenInfo['name']),
    );
    return token;
  }
}

ThunkAction switchToNewCommunityCall(
  String communityAddress, {
  String? walletAddress,
}) {
  return (Store store) async {
    try {
      log.info('Swithcing to community $communityAddress');
      String address = checksumEthereumAddress(
        store.state.userState.walletAddress,
      );
      Map<String, dynamic> communityData = await api.getCommunityData(
        checksumEthereumAddress(communityAddress),
        walletAddress: address,
      );
      Community newCommunity = Community.fromJson(communityData).copyWith(
        address: communityAddress,
      );
      Token communityToken = await fetchToken(
        newCommunity,
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
        ),
      );
      store.dispatch(
        getBusinessListCall(
          communityAddress: communityAddress,
        ),
      );
      store.dispatch(
        joinCommunityCall(
          newCommunity,
          communityToken,
        ),
      );
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
      Map<String, dynamic> communityData = await api.getCommunityData(
        checksumEthereumAddress(communityAddress),
        walletAddress: walletAddress,
      );
      Community newCommunity = Community.fromJson(communityData).copyWith(
        address: communityAddress.toLowerCase(),
      );
      Token communityToken = await fetchToken(
        newCommunity,
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
        ),
      );
      store.dispatch(
        fetchCommunityMetadataCall(
          communityAddress,
          communityData['communityURI'],
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
    String walletAddress = store.state.userState.walletAddress;
    Community? current =
        store.state.cashWalletState.communities[communityAddress.toLowerCase()];
    if (current != null && current.name.isNotEmpty) {
      Map<String, dynamic> communityData = await api.getCommunityData(
        checksumEthereumAddress(communityAddress),
        walletAddress: checksumEthereumAddress(walletAddress),
      );
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
        ),
      );
    } else {
      store.dispatch(switchCommunityCall(communityAddress));
    }
  };
}

ThunkAction switchCommunityCall(
  String communityAddress, {
  String? walletAddress,
}) {
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
        store.dispatch(switchToNewCommunityCall(
          communityAddress,
          walletAddress: walletAddress,
        ));
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

ThunkAction getBusinessListCall({
  String? communityAddress,
}) {
  return (Store store) async {
    try {
      communityAddress ??= store.state.cashWalletState.communityAddress;
      store.dispatch(StartFetchingBusinessList());
      Dio client = Dio();
      Response res = await client.get(
        'https://api.airtable.com/v0/appQ4QMWLG5Y5ECsg/Table%201',
        options:
            Options(headers: {"Authorization": "Bearer keywI4WPG7mJVm2XU"}),
      );
      List<Business> businessList = [];
      await Future.forEach(List<Map>.from(res.data['records']), (Map record) {
        if (record['fields'].containsKey('name') &&
            record['fields'].containsKey('account')) {
          dynamic data = record['fields'];
          Map<String, dynamic> business = Map.from({
            'name': data['name'] ?? '',
            'account': data['account'] ?? '',
            'area': num.parse(data['area']), // ?? data['area'],
            'metadata': {
              'image': data['image'][0]['url'] ?? '',
              "coverPhoto": data['coverPhoto'][0]['url'] ?? '',
              'address': data['address'] ?? '',
              'description': data['description'] ?? '',
              'phoneNumber': data['phoneNumber'] ?? '',
              'website': data['website'] ?? '',
              'type': data['type'] ?? '',
              'latLng': data['GPS'] != null
                  ? data!['GPS']
                      .split(',')
                      .toList()
                      .map((item) => double.parse(item.trim()))
                      .toList()
                  : null
            }
          });
          businessList.add(Business.fromJson(business));
        }
      }).then((r) {
        store.dispatch(GetBusinessListSuccess(
          businessList: businessList,
          communityAddress: communityAddress!,
        ));
        store.dispatch(FetchingBusinessListSuccess());
      });
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

ThunkAction getWalletActionsCall({
  int? pageIndex,
  VoidCallback? onSuccess,
}) {
  return (Store store) async {
    try {
      final String walletAddress = store.state.userState.walletAddress;
      final WalletActions walletActions =
          store.state.cashWalletState.walletActions;
      final Map<String, dynamic> response =
          await walletApi.getPaginatedActionsByWalletAddress(
        walletAddress,
        pageIndex ?? walletActions.currentPage,
      );
      final Iterable<dynamic> docs = response['docs'] ?? [];
      final bool hasNextPage = response['hasNextPage'];
      final int nextPage = response['nextPage'] ?? 1;
      List<WalletAction> actions = WalletActionFactory.actionsFromJson(docs);
      if (actions.isNotEmpty) {
        store.dispatch(GetActionsSuccess(
          walletActions: actions,
          nextPage: hasNextPage && nextPage > walletActions.currentPage
              ? nextPage
              : walletActions.currentPage,
        ));
        onSuccess?.call();
      }
    } catch (e, s) {
      log.error(
        'ERROR - getWalletActionsCall',
        error: e,
        stackTrace: s,
      );
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
      void onDone(Price priceInfo) {
        store.dispatch(
          UpdateTokenPrice(
            price: priceInfo,
            tokenAddress: token.address,
          ),
        );
      }

      void onError(Object error, StackTrace stackTrace) {
        log.error('Fetch token price error for - ${token.name} - $error ');
      }

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
      void onDone(num priceChange) {
        store.dispatch(
          GetTokenPriceChangeSuccess(
            priceChange: priceChange,
            tokenAddress: token.address,
          ),
        );
      }

      void onError(Object error, StackTrace stackTrace) {
        log.error('Error getTokenPriceChangeCall - ${token.name} - $error ');
      }

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
  String limit = '7',
}) {
  return (Store store) async {
    try {
      void onDone(List<Stats> stats) {
        store.dispatch(
          GetTokenStatsSuccess(
            stats: stats,
            tokenAddress: token.address,
          ),
        );
      }

      void onError(
        Object error,
        StackTrace stackTrace,
      ) {
        log.error('Error getTokenStatsCall - ${token.name} - $error ');
      }

      await token.fetchStats(
        onDone: onDone,
        onError: onError,
        limit: limit,
      );
    } catch (e) {
      log.error('Error getTokenStatsCall - ${token.name} - ${e.toString()} ');
    }
  };
}

ThunkAction getTokenWalletActionsCall(Token token) {
  return (Store store) async {
    try {
      final String walletAddress = store.state.userState.walletAddress;
      final Map<String, dynamic> response =
          await walletApi.getActionsByWalletAddress(
        walletAddress,
        updatedAt: token.walletActions!.updatedAt.toInt(),
        tokenAddress: token.address,
      );
      final Iterable<dynamic> docs = response['docs'] ?? [];
      final List<WalletAction> actions =
          WalletActionFactory.actionsFromJson(docs);
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
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      Map? wallet = await walletApi.getWalletByPhoneNumber(contactPhoneNumber);
      log.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      String? walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(
          token,
          contactPhoneNumber,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      } else {
        store.dispatch(sendTokenCall(
          token,
          walletAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
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
      Map<String, dynamic> response =
          await walletApi.approveTokenAndCallContract(
        getIt<Web3>(instanceName: 'fuseWeb3'),
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
      EtherAmount balance =
          await getIt<Web3>(instanceName: 'fuseWeb3').getBalance(
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
    store.dispatch(getWalletActionsCall(pageIndex: 1));
    store.dispatch(ResetTokenTxs());
    store.dispatch(startFetchTokensBalances());
    // store.dispatch(updateTokensPrices());
  };
}
