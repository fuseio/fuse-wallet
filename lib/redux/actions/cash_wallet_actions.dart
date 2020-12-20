import 'dart:io';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:bit2c/models/community/business.dart';
import 'package:bit2c/models/cash_wallet_state.dart';
import 'package:bit2c/models/community/business_metadata.dart';
import 'package:bit2c/models/community/community.dart';
import 'package:bit2c/models/community/community_metadata.dart';
import 'package:bit2c/models/jobs/base.dart';
import 'package:bit2c/models/plugins/join_bonus.dart';
import 'package:bit2c/models/plugins/plugins.dart';
import 'package:bit2c/models/tokens/token.dart';
import 'package:bit2c/models/transactions/transaction.dart';
import 'package:bit2c/models/transactions/transactions.dart';
import 'package:bit2c/models/transactions/transfer.dart';
import 'package:bit2c/models/user_state.dart';
import 'package:bit2c/redux/actions/error_actions.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:bit2c/redux/actions/user_actions.dart';
import 'package:bit2c/utils/addresses.dart';
import 'package:bit2c/redux/state/store.dart';
import 'package:bit2c/utils/constans.dart';
import 'package:bit2c/utils/firebase.dart';
import 'package:bit2c/utils/format.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:bit2c/services.dart';
import 'dart:async';
import 'dart:convert';

class AddCashTokens {
  Map<String, Token> tokens;
  AddCashTokens({this.tokens});
}

class AddCashToken {
  Token token;
  AddCashToken({this.token});
}

class SetDefaultCommunity {
  String defaultCommunity;
  SetDefaultCommunity(this.defaultCommunity);
}

class AddCommunities {
  Map<String, Community> communities;
  AddCommunities({this.communities});
}

class InitWeb3Success {
  final wallet_core.Web3 web3;
  InitWeb3Success(this.web3);
}

class GetWalletAddressesSuccess {
  final List<String> networks;
  final String walletAddress;
  final bool backup;
  final String communityManagerAddress;
  final String transferManagerAddress;
  final String daiPointsManagerAddress;
  GetWalletAddressesSuccess(
      {this.backup,
      this.networks,
      this.daiPointsManagerAddress,
      this.walletAddress,
      this.communityManagerAddress,
      this.transferManagerAddress});
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
  final String webUrl;
  RefreshCommunityData({
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

class GetTokenTransfersListSuccess {
  final String tokenAddress;
  final List<Transfer> tokenTransfers;
  GetTokenTransfersListSuccess({this.tokenAddress, this.tokenTransfers});
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

class InviteSendSuccess {
  final String tokenAddress;
  final Transaction invite;
  InviteSendSuccess({this.invite, this.tokenAddress});
}

class ReplaceTransaction {
  final String tokenAddress;
  final Transaction transaction;
  final Transaction transactionToReplace;
  ReplaceTransaction(
      {this.transaction, this.transactionToReplace, this.tokenAddress});
}

class AddTransaction {
  final String tokenAddress;
  final Transaction transaction;
  AddTransaction({this.transaction, this.tokenAddress});
}

class AddJob {
  final String tokenAddress;
  final Job job;
  AddJob({this.job, this.tokenAddress});
}

class JobDone {
  final String tokenAddress;
  final Job job;
  JobDone({this.job, this.tokenAddress});
}

class UpdateJob {
  final String tokenAddress;
  final Job job;
  UpdateJob({this.job, this.tokenAddress});
}

class SetIsJobProcessing {
  final bool isFetching;
  SetIsJobProcessing({this.isFetching});
}

Future<bool> approvalCallback() async {
  return true;
}

ThunkAction enablePushNotifications() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
      void iosPermission() {
        var firebaseMessaging2 = firebaseMessaging;
        firebaseMessaging2.requestNotificationPermissions(
            IosNotificationSettings(sound: true, badge: true, alert: true));
        firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
          logger.info("Settings registered: $settings");
        });
      }

      if (Platform.isIOS) iosPermission();
      String token = await firebaseMessaging.getToken();
      logger.info("Firebase messaging token $token");

      String walletAddress = store.state.userState.walletAddress;
      await api.updateFirebaseToken(walletAddress, token);
      await Segment.setContext({
        'device': {'token': token},
      });

      void switchOnPush(message) {
        String communityAddress = communityAddressFromNotification(message);
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
      logger.severe('ERROR - Enable push notifications: $e');
    }
  };
}

ThunkAction segmentTrackCall(eventName, {Map<String, dynamic> properties}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('Track - $eventName');
      Segment.track(eventName: eventName, properties: properties);
    } catch (e, s) {
      logger.severe('ERROR - segment track call: $e');
      await AppFactory().reportError(e, stackTrace: s);
    }
  };
}

ThunkAction segmentAliasCall(String userId) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('Alias - $userId');
      Segment.alias(alias: userId);
    } catch (e, s) {
      logger.severe('ERROR - segment alias call: $e');
      await AppFactory().reportError(e, stackTrace: s);
    }
  };
}

ThunkAction segmentIdentifyCall(Map<String, dynamic> traits) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      UserState userState = store.state.userState;
      String fullPhoneNumber =
          store.state.userState.normalizedPhoneNumber ?? '';
      logger.info('Identify - $fullPhoneNumber');
      traits = traits ?? new Map<String, dynamic>();
      DateTime installedAt = userState.installedAt;
      if (installedAt == null) {
        installedAt = DateTime.now().toUtc();
        store.dispatch(new JustInstalled(installedAt));
      }
      traits["Installed At"] = installedAt.toIso8601String();
      traits["Display Balance"] = userState.displayBalance ?? 0;
      Segment.identify(userId: fullPhoneNumber, traits: traits);
    } catch (e, s) {
      logger.severe('ERROR - segment identify call: $e');
      await AppFactory().reportError(e, stackTrace: s);
    }
  };
}

ThunkAction listenToBranchCall() {
  return (Store store) async {
    final bool isListeningToBranch =
        store.state.cashWalletState.isListeningToBranch ?? false;
    if (!isListeningToBranch) {
      final logger = await AppFactory().getLogger('action');
      logger.info("branch listening.");
      store.dispatch(BranchListening());

      Function handler = (linkData) async {
        logger.info("Got link data: ${linkData.toString()}");
        if (linkData["~feature"] == "switch_community") {
          var communityAddress = linkData["community_address"];
          logger.info("communityAddress $communityAddress");
          store.dispatch(BranchCommunityToUpdate(communityAddress));
          store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
            'Referral': linkData["~feature"],
            'Referral link': linkData['~referring_link']
          })));
          store.dispatch(segmentTrackCall("Wallet: Branch: Studio Invite",
              properties: new Map<String, dynamic>.from(linkData)));
        }
        if (linkData["~feature"] == "invite_user") {
          var communityAddress = linkData["community_address"];
          logger.info("community_address $communityAddress");
          store.dispatch(BranchCommunityToUpdate(communityAddress));
          store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
            'Referral': linkData["~feature"],
            'Referral link': linkData['~referring_link']
          })));
          store.dispatch(segmentTrackCall("Wallet: Branch: User Invite",
              properties: new Map<String, dynamic>.from(linkData)));
        }
      };

      FlutterBranchSdk.initSession().listen((data) {
        handler(data);
      }, onError: (error, s) async {
        logger.severe('ERROR - FlutterBranchSdk initSession $error');
        store.dispatch(BranchListeningStopped());
      }, cancelOnError: true);
    }
  };
}

ThunkAction initWeb3Call({
  String privateKey,
  String communityManagerAddress,
  String transferManagerAddress,
  String dAIPointsManagerAddress,
}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String pk = privateKey ?? store.state.userState.privateKey;
      logger.info('initWeb3. privateKey: $privateKey');
      logger.info('mnemonic : ${store.state.userState.mnemonic.toString()}');
      wallet_core.Web3 web3 = new wallet_core.Web3(approvalCallback,
          defaultCommunityAddress: defaultCommunityAddress,
          communityManagerAddress: communityManagerAddress ??
              DotEnv().env['COMMUNITY_MANAGER_CONTRACT_ADDRESS'],
          transferManagerAddress: transferManagerAddress ??
              DotEnv().env['TRANSFER_MANAGER_CONTRACT_ADDRESS'],
          daiPointsManagerAddress: dAIPointsManagerAddress ??
              DotEnv().env['DAI_POINTS_MANAGER_CONTRACT_ADDRESS']);
      final String branchAddress = store.state.cashWalletState.branchAddress;
      final String communityAddress =
          store.state.cashWalletState.communityAddress;
      if ([null, ''].contains(communityAddress)) {
        if (![null, ''].contains(branchAddress)) {
          store.dispatch(SetDefaultCommunity(branchAddress));
        } else {
          final communityAddress = web3.getDefaultCommunity().toLowerCase();
          store.dispatch(SetDefaultCommunity(communityAddress));
        }
      }
      web3.setCredentials(pk);
      store.dispatch(new InitWeb3Success(web3));
    } catch (e) {
      logger.severe('ERROR - initWeb3Call $e');
      store.dispatch(new ErrorAction('Could not init web3'));
    }
  };
}

ThunkAction startTransfersFetchingCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    bool isTransfersFetchingStarted =
        store.state.cashWalletState.isTransfersFetchingStarted ?? false;
    Map<String, Token> tokens = store.state.cashWalletState.tokens;
    if (!isTransfersFetchingStarted &&
        tokens.isNotEmpty &&
        store.state.userState.walletStatus != null &&
        store.state.userState.walletStatus == 'created' &&
        ![null, ''].contains(store.state.userState.walletAddress)) {
      try {
        Map<String, Token> tokens = store.state.cashWalletState.tokens;
        store.dispatch(fetchListOfTokensByAddress());
        for (Token token in tokens.values) {
          if (![null, ''].contains(token?.address)) {
            store.dispatch(getTokenTransfersListCall(token));
          }
        }
        logger.info('Timer start - startTransfersFetchingCall');
        Timer.periodic(Duration(seconds: intervalSeconds), (Timer t) async {
          if (store.state.userState.walletAddress == '') {
            logger.severe('Timer stopeed - startTransfersFetchingCall');
            store.dispatch(SetIsTransfersFetching(isFetching: false));
            t.cancel();
            return;
          }
          Map<String, Token> tokens = store.state.cashWalletState.tokens;
          for (Token token in tokens.values) {
            if (![null, ''].contains(token.address)) {
              store.dispatch(getReceivedTokenTransfersListCall(token));
              store.dispatch(getTokenBalanceCall(token));
            }
          }
        });
        store.dispatch(SetIsTransfersFetching(isFetching: true));
      } catch (e) {
        logger.severe('error in startTransfersFetchingCall $e');
      }
    }
  };
}

ThunkAction createAccountWalletCall(String accountAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      final String communityAddress =
          store.state?.cashWalletState?.communityAddress ??
              defaultCommunityAddress;
      Map<String, dynamic> response =
          await api.createWallet(communityAddress: communityAddress);
      if (!response.containsKey('job')) {
        logger.info('Wallet already exists');
        store.dispatch(CreateAccountWalletSuccess());
        store.dispatch(generateWalletSuccessCall(response, accountAddress));
        store.dispatch(switchCommunityCall(communityAddress));
        return;
      }
      CashWalletState cashWalletState = store.state.cashWalletState;
      Community community = cashWalletState.communities[communityAddress];
      if (!cashWalletState.tokens.containsKey(community?.homeTokenAddress)) {
        store.dispatch(CreateAccountWalletRequest());
        store.dispatch(
            startFetchingJobCall(response['job']['_id'], (Job job) async {
          dynamic fetchedData = job.data;
          final String accountAddress = fetchedData['owner'];
          store.dispatch(CreateAccountWalletSuccess());
          final response = await api.getWallet();
          store.dispatch(generateWalletSuccessCall(response, accountAddress));
          final String communityAddress =
              store.state.cashWalletState.communityAddress ??
                  defaultCommunityAddress;
          store.dispatch(switchCommunityCall(communityAddress));
        }));
      }
    } catch (e, s) {
      logger.severe('ERROR - createAccountWalletCall $e');
      store.dispatch(new ErrorAction('Could not create wallet'));
      await AppFactory().reportError(e, stackTrace: s);
    }
  };
}

ThunkAction generateWalletSuccessCall(
    dynamic walletData, String accountAddress) {
  return (Store store) async {
    String walletAddress = walletData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(enablePushNotifications());
      store.dispatch(setupWalletCall(walletData));
      store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
        "Wallet Generated": true,
        "App name": 'Bit2c club',
        "Phone Number": store.state.userState.normalizedPhoneNumber,
        "Wallet Address": store.state.userState.walletAddress,
        "Account Address": store.state.userState.accountAddress,
        "Display Name": store.state.userState.displayName
      })));
      store.dispatch(segmentTrackCall('Wallet: Wallet Generated'));
      store.dispatch(create3boxAccountCall(accountAddress));
    }
  };
}

ThunkAction getTokenBalanceCall(Token token) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      void Function(BigInt) onDone = (BigInt balance) {
        logger.info('${token.name} balance updated');
        store.dispatch(GetTokenBalanceSuccess(
            tokenBalance: balance, tokenAddress: token.address));
        store.dispatch(UpdateDisplayBalance(
            int.tryParse(formatValue(balance, token.decimals))));
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
          '${token?.name} Balance':
              formatValue(balance, token.decimals, withPrecision: true),
          "DisplayBalance":
              formatValue(balance, token.decimals, withPrecision: true)
        })));
      };
      void Function(Object error, StackTrace stackTrace) onError =
          (Object error, StackTrace stackTrace) async {
        logger.severe('Error in fetchTokenBalance for - ${token.name} $error');
        await AppFactory().reportError(error, stackTrace: stackTrace);
      };
      await token.fetchTokenBalance(walletAddress,
          onDone: onDone, onError: onError);
    } catch (e) {
      logger.severe('ERROR - getTokenBalanceCall $e');
      store.dispatch(new ErrorAction('Could not get token balance'));
    }
  };
}

ThunkAction fetchJobCall(String jobId, Function(Job) fetchSuccessCallback,
    {Timer timer, bool untilDone}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      dynamic response = await api.getJob(jobId);
      logger.info('fetchJobCall: ${response['data']}');
      Job job = JobFactory.create(response);
      logger.info("job.name: ${job.name}");
      if (untilDone) {
        if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
          logger.info('job not done');
          return;
        }
      } else {
        if (job.data['txHash'] == null) {
          logger.info('fetched job with txHash null');
          return;
        }
      }
      fetchSuccessCallback(job);
      if (timer != null) {
        logger.info('Timer stopeed - fetchJobCall');
        timer.cancel();
      }
    } catch (e) {
      logger.severe('ERROR - fetchJobCall $e');
      store.dispatch(new ErrorAction('Could not get job'));
    }
  };
}

ThunkAction startFetchingJobCall(
    String jobId, Function(Job) fetchSuccessCallback,
    {bool untilDone: true}) {
  return (Store store) async {
    new Timer.periodic(Duration(seconds: intervalSeconds), (Timer timer) async {
      store.dispatch(fetchJobCall(jobId, fetchSuccessCallback,
          timer: timer, untilDone: untilDone));
    });
  };
}

ThunkAction processingJobsCall(Timer timer) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    final String walletAddress = store.state.userState.walletAddress;
    Map<String, Token> tokens = store.state.cashWalletState.tokens;
    for (Token token in tokens.values) {
      List<Job> jobs = token?.jobs ?? [];
      for (Job job in jobs) {
        String currentWalletAddress = store.state.userState.walletAddress;
        if (job.status != 'DONE' && job.status != 'FAILED') {
          bool isJobProcessValid() {
            if (currentWalletAddress != walletAddress) {
              logger.severe('Timer stopeed - processingJobsCall');
              store.dispatch(SetIsJobProcessing(isFetching: false));
              timer.cancel();
              return false;
            }
            if (job.status == 'DONE') {
              return false;
            }
            return true;
          }

          try {
            // logger.info('cash mode performing ${job.name} ${job.id}');
            await job.perform(store, isJobProcessValid);
          } catch (e) {
            logger.severe('failed perform ${job.name} $e');
          }
        }
        if (job.status == 'DONE') {
          logger.info('Done ${job.name} ${job.id}');
          store.dispatch(JobDone(job: job, tokenAddress: token.address));
        }
      }
    }
  };
}

ThunkAction startProcessingJobsCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    final bool isJobProcessingStarted =
        store.state.cashWalletState.isJobProcessingStarted ?? false;
    if (!isJobProcessingStarted) {
      logger.info('Start Processing Jobs Call');
      new Timer.periodic(Duration(seconds: intervalSeconds),
          (Timer timer) async {
        store.dispatch(processingJobsCall(timer));
      });
      store.dispatch(SetIsJobProcessing(isFetching: true));
    }
  };
}

ThunkAction inviteAndSendCall(
    Token token,
    String contactPhoneNumber,
    num tokensAmount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    {String receiverName = ''}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String senderName = store.state.userState.displayName;
      Map<String, Community> communities =
          store.state.cashWalletState.communities;
      Community community = communities.values.firstWhere(
          (element) =>
              element.homeTokenAddress.toLowerCase() ==
              token.address.toLowerCase(),
          orElse: () => null);
      dynamic response = await api.invite(contactPhoneNumber,
          communityAddress: community?.address,
          name: senderName,
          amount: tokensAmount.toString(),
          symbol: token.symbol);
      sendSuccessCallback();

      String tokenAddress = token?.address;

      BigInt value = toBigInt(tokensAmount, token.decimals);
      String walletAddress = store.state.userState.walletAddress;

      Transfer inviteTransfer = new Transfer(
          timestamp: DateTime.now().millisecondsSinceEpoch,
          from: walletAddress,
          to: '',
          tokenAddress: tokenAddress,
          value: value,
          type: 'SEND',
          receiverName: receiverName,
          status: 'PENDING',
          jobId: response['job']['_id']);
      store.dispatch(AddTransaction(
          transaction: inviteTransfer, tokenAddress: tokenAddress));

      response['job']['arguments'] = {
        'tokensAmount': tokensAmount,
        'receiverName': receiverName,
        'sendSuccessCallback': () => {},
        'sendFailureCallback': sendFailureCallback,
        'inviteTransfer': inviteTransfer,
        'communityAddress': community.address
      };

      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, tokenAddress: tokenAddress));
    } catch (e) {
      logger.severe('ERROR - inviteAndSendCall $e');
    }
  };
}

ThunkAction inviteAndSendSuccessCall(
    Job job,
    num tokensAmount,
    String receiverName,
    Transfer inviteTransfer,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    String communityAddress) {
  return (Store store) async {
    Community community =
        store.state.cashWalletState.communities[communityAddress];
    Token token =
        store.state.cashWalletState.tokens[community?.homeTokenAddress];
    VoidCallback successCallBack = () {
      sendSuccessCallback();
      if (community.plugins.inviteBonus != null &&
          community.plugins.inviteBonus.isActive &&
          job.data['bonusInfo'] != null) {
        store.dispatch(inviteBonusCall(token, job.data, community));
      }
      store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
        "Invite ${community.name}": true,
      })));
    };

    String receiverAddress = job.data["walletAddress"];
    store.dispatch(sendTokenCall(token, receiverAddress, tokensAmount,
        successCallBack, sendFailureCallback,
        receiverName: receiverName, inviteTransfer: inviteTransfer));
    store.dispatch(loadContacts());
  };
}

ThunkAction inviteBonusCall(token, dynamic data, Community community) {
  return (Store store) async {
    BigInt value =
        toBigInt(community.plugins.inviteBonus.amount, token.decimals);
    String walletAddress = store.state.userState.walletAddress;
    String bonusJobId = data['bonusJob']['_id'];
    Transfer inviteBonus = new Transfer(
        from: DotEnv().env['FUNDER_ADDRESS'],
        to: walletAddress,
        tokenAddress: token.address,
        text: 'You got a invite bonus!',
        type: 'RECEIVE',
        value: value,
        status: 'PENDING',
        jobId: bonusJobId);
    store.dispatch(
        AddTransaction(transaction: inviteBonus, tokenAddress: token.address));
    Map response = new Map.from({
      'job': {
        'id': bonusJobId,
        'jobType': 'inviteBonus',
        'arguments': {
          'inviteBonus': inviteBonus,
          'communityAddress': community.address,
        }
      }
    });

    Job job = JobFactory.create(response['job']);
    store.dispatch(AddJob(job: job, tokenAddress: community.address));
  };
}

ThunkAction fetchListOfTokensByAddress() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      List<dynamic> response =
          await fuseExplorerApi.getListOfTokensByAddress(walletAddress);
      logger.info(
          'fetchListOfTokensByAddress response ${List.from(response).length}');
      CashWalletState cashWalletState = store.state.cashWalletState;
      Map<String, Token> newTokens =
          Map<String, Token>.from(response.fold({}, (previousValue, element) {
        Token token = Token.fromJson(element).copyWith(
            transactions: Transactions.initial(),
            jobs: List<Job>(),
            name: formatTokenName(element["name"]));
        if (!cashWalletState.tokens.containsKey(token.address) &&
            num.parse(formatValue(token.amount, token.decimals,
                        withPrecision: true))
                    .compareTo(0) ==
                1) {
          logger.info('newToken newToken ${token.name}');
          previousValue[token.address] = token;
        }
        return previousValue;
      }));
      logger.info('newTokens newTokens ${newTokens.length}');
      store.dispatch(AddCashTokens(tokens: newTokens));
    } catch (e) {
      logger.severe('fetchListOfTokensByAddress $e');
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
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      String walletAddress = store.state.userState.walletAddress;
      String tokenAddress = token?.address;
      BigInt value = toBigInt(tokensAmount, token.decimals);
      dynamic response;
      num feeAmount = 20;
      logger.info(
          'Multi bridge - Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
      List trasnferData = await web3.transferTokenToForeign(
          walletAddress,
          receiverAddress,
          checksumEthereumAddress(tokenAddress),
          tokensAmount,
          token.decimals,
          network: 'fuse');
      Map<String, dynamic> feeTrasnferData = await web3.transferTokenOffChain(
          walletAddress, tokenAddress, feeReceiverAddress, feeAmount);
      response = await api.multiRelay([...trasnferData, feeTrasnferData]);

      dynamic jobId = response['job']['_id'];
      logger.info('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();
      Transfer transfer = Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: tokenAddress,
          value: value,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          type: 'SEND',
          note: transferNote,
          receiverName: receiverName,
          status: 'PENDING',
          jobId: jobId);

      store.dispatch(
          AddTransaction(transaction: transfer, tokenAddress: tokenAddress));

      response['job']['arguments'] = {
        'transfer': transfer,
        'jobType': 'transfer',
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, tokenAddress: tokenAddress));
    } catch (e) {
      logger.severe('ERROR - sendTokenToForeignMultiBridge $e');
      sendFailureCallback();
      store.dispatch(ErrorAction('Could not send token'));
    }
  };
}

ThunkAction sendTokenCall(Token token, String receiverAddress, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback,
    {String receiverName, String transferNote, Transfer inviteTransfer}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      String walletAddress = store.state.userState.walletAddress;
      Map<String, Community> communities =
          store.state.cashWalletState.communities;
      String tokenAddress = token?.address;
      Community community = communities.values.firstWhere(
          (element) =>
              element?.homeTokenAddress?.toLowerCase() ==
              tokenAddress?.toLowerCase(),
          orElse: () => null);

      BigInt value;
      dynamic response;
      if (![null, ''].contains(token.communityAddress) &&
          receiverAddress?.toLowerCase() ==
              community?.homeBridgeAddress?.toLowerCase()) {
        num feeAmount = 20;
        value = toBigInt(tokensAmount, token.decimals);
        logger.info(
            'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
        Map<String, dynamic> trasnferData = await web3.transferTokenOffChain(
            walletAddress, tokenAddress, receiverAddress, tokensAmount);
        Map<String, dynamic> feeTrasnferData = await web3.transferTokenOffChain(
            walletAddress, tokenAddress, feeReceiverAddress, feeAmount);
        response = await api.multiRelay([trasnferData, feeTrasnferData]);
      } else {
        value = toBigInt(tokensAmount, token.decimals);
        logger.info(
            'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
        response = await api.tokenTransfer(
          web3,
          walletAddress,
          tokenAddress,
          receiverAddress,
          tokensAmount,
        );
      }

      dynamic jobId = response['job']['_id'];
      logger.info('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();
      Transfer transfer = Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: tokenAddress,
          value: value,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          type: 'SEND',
          note: transferNote,
          receiverName: receiverName,
          status: 'PENDING',
          jobId: jobId);

      if (inviteTransfer != null) {
        store.dispatch(ReplaceTransaction(
            transaction: inviteTransfer, transactionToReplace: transfer));
      } else {
        store.dispatch(
            AddTransaction(transaction: transfer, tokenAddress: tokenAddress));
      }

      response['job']['arguments'] = {
        'transfer': transfer,
        'jobType': 'transfer',
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, tokenAddress: tokenAddress));
    } catch (e) {
      logger.severe('ERROR - sendTokenCall ${e.toString()}');
      sendFailureCallback();
      store.dispatch(ErrorAction('Could not send token'));
    }
  };
}

ThunkAction transactionFailed(transfer, String failReason) {
  return (Store store) async {
    Transfer failedTx =
        transfer.copyWith(status: 'FAILED', failReason: failReason);
    store.dispatch(ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: failedTx,
        tokenAddress: failedTx.tokenAddress));
  };
}

ThunkAction joinCommunityCall(
    {String entitiesListAddress, Community community, Token token}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      String walletAddress = store.state.userState.walletAddress;
      bool isMember =
          await graph.isCommunityMember(walletAddress, entitiesListAddress);
      if (isMember) {
        store.dispatch(AlreadyJoinedCommunity(community.address));
      } else {
        dynamic response = await api.joinCommunity(
            web3, walletAddress, community.address,
            tokenAddress: token.address, originNetwork: token.originNetwork);

        dynamic jobId = response['job']['_id'];
        Transfer transfer = new Transfer(
            type: 'RECEIVE',
            timestamp: DateTime.now().millisecondsSinceEpoch,
            text: 'Joining ' + community?.name + ' community',
            tokenAddress: token?.address,
            status: 'PENDING',
            jobId: jobId);
        logger.info('joinCommunity jobId $jobId');

        store.dispatch(
            AddTransaction(transaction: transfer, tokenAddress: token.address));

        response['job']['arguments'] = {
          'transfer': transfer,
          'community': community,
          'token': token
        };
        Job job = JobFactory.create(response['job']);
        store.dispatch(AddJob(job: job, tokenAddress: token.address));
      }
    } catch (e) {
      logger.severe('ERROR - joinCommunityCall $e');
      store.dispatch(new ErrorAction('Could not join community'));
    }
  };
}

ThunkAction joinCommunitySuccessCall(
    String joinCommunityJobId,
    String joinBonusJobId,
    dynamic communityAddress,
    JoinBonusPlugin joinBonusPlugin,
    Token token) {
  return (Store store) async {
    store.dispatch(new AlreadyJoinedCommunity(communityAddress));
    if (joinBonusPlugin != null && joinBonusPlugin.isActive) {
      BigInt value = toBigInt(joinBonusPlugin.amount, token.decimals);
      Transfer joinBonus = new Transfer(
          from: DotEnv().env['FUNDER_ADDRESS'],
          type: 'RECEIVE',
          value: value,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          tokenAddress: token.address,
          text: 'You got a join bonus!',
          status: 'PENDING',
          jobId: joinBonusJobId ?? joinCommunityJobId);
      store.dispatch(new AddTransaction(
          transaction: joinBonus, tokenAddress: token.address));
      Map response = Map.from({
        'job': {
          'id': joinBonusJobId ?? joinCommunityJobId,
          'isFunderJob': joinBonusJobId != null,
          'jobType': 'joinBonus',
          'arguments': {
            'joinBonus': joinBonus,
            'communityAddress': communityAddress
          }
        }
      });
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, tokenAddress: token.address));
    }
  };
}

ThunkAction joinBonusSuccessCall(communiyAddress) {
  return (Store store) async {
    Map<String, Community> communities =
        store.state.cashWalletState.communities;
    Community communityData = communities[communiyAddress];
    store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
      "Join Bonus ${communityData?.name} Received": true,
      "Community ${communityData?.name} Joined": true,
    })));
    store.dispatch(segmentTrackCall("Wallet: user got a join bonus",
        properties: new Map<String, dynamic>.from({
          "Community Name": communityData.name,
          "Bonus amount": communityData.plugins?.joinBonus?.amount,
        })));
  };
}

ThunkAction fetchCommunityMetadataCall(
    String communityAddress, String communityURI, bool isRopsten) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      CommunityMetadata communityMetadata = CommunityMetadata.initial();
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
            isDefaultImage: metadata['isDefault'] ?? false);
      }
      store.dispatch(FetchCommunityMetadataSuccess(
          metadata: communityMetadata,
          communityAddress: communityAddress.toLowerCase()));
    } catch (e, s) {
      logger.severe('ERROR - fetchCommunityMetadataCall $e');
      await AppFactory().reportError(e, stackTrace: s);
      store.dispatch(new ErrorAction('Could not fetch community metadata'));
    }
  };
}

Future<Map<String, dynamic>> getCommunityData(
    communityAddress, walletAddress) async {
  Map<String, dynamic> communityData = await api.getCommunityData(
      communityAddress,
      isRopsten: true,
      walletAddress: walletAddress);
  if (communityData == null) {
    communityData = await api.getCommunityData(communityAddress,
        walletAddress: walletAddress);
    return Map.from(
        {...communityData, 'isRopsten': false, 'originNetwork': 'mainnet'});
  }
  return Map.from(
      {...communityData, 'isRopsten': true, 'originNetwork': 'ropsten'});
}

Future<Token> fetchToken(
    Community community, bool isRopsten, String originNetwork) async {
  if (community.isMultiBridge) {
    dynamic token = await graph.getHomeBridgedToken(
        community.foreignTokenAddress, isRopsten);
    return Token.initial().copyWith(
        originNetwork: originNetwork,
        address: token['address'].toString(),
        name: formatTokenName(token["name"]),
        symbol: token["symbol"],
        decimals: token["decimals"]);
  } else {
    dynamic token = await graph.getTokenOfCommunity(community.address);
    final String tokenAddress = token["address"].toString();
    return Token.initial().copyWith(
        originNetwork: originNetwork,
        address: tokenAddress,
        name: token["name"],
        symbol: token["symbol"],
        decimals: token["decimals"]);
  }
}

ThunkAction switchToNewCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      dynamic community = await graph.getCommunityByAddress(communityAddress);
      Map<String, dynamic> communityData = await getCommunityData(
          checksumEthereumAddress(communityAddress),
          checksumEthereumAddress(walletAddress));
      final bool isMultiBridge =
          communityData?.containsKey('isMultiBridge') ?? false;
      final String description = communityData['description'];
      final String homeBridgeAddress = communityData['homeBridgeAddress'];
      final String foreignBridgeAddress = communityData['foreignBridgeAddress'];
      String foreignTokenAddress = communityData['foreignTokenAddress'];
      final String webUrl = communityData['webUrl'];
      Community newCommunity = Community.initial().copyWith(
        address: communityAddress,
        name: communityData["name"],
        foreignTokenAddress: foreignTokenAddress,
        webUrl: webUrl,
        homeBridgeAddress: homeBridgeAddress,
        foreignBridgeAddress: foreignBridgeAddress,
        description: description,
        plugins: Plugins.fromJson(communityData['plugins']),
        isMultiBridge: isMultiBridge,
        isClosed: communityData['isClosed'],
      );
      bool isRopsten = communityData['isRopsten'];
      String originNetwork = communityData['originNetwork'];
      Token communityToken =
          await fetchToken(newCommunity, isRopsten, originNetwork);
      newCommunity =
          newCommunity.copyWith(homeTokenAddress: communityToken.address);
      store.dispatch(AddCashToken(
          token: communityToken.copyWith(
              timestamp: 0, communityAddress: communityAddress)));
      store.dispatch(SwitchCommunitySuccess(community: newCommunity));
      store.dispatch(segmentTrackCall("Wallet: Switch Community",
          properties: Map<String, dynamic>.from({
            "Community Name": newCommunity.name,
            "Community Address": communityAddress,
            "Token Address": communityToken.address,
            "Token Symbol": communityToken.symbol,
            "Origin Network": originNetwork
          })));
      final String entitiesListAddress = community["entitiesList"]["address"];
      store.dispatch(fetchCommunityMetadataCall(
          communityAddress, communityData['communityURI'], isRopsten));
      store.dispatch(getBusinessListCall(
          communityAddress: communityAddress.toLowerCase(),
          isRopsten: isRopsten));
      store.dispatch(joinCommunityCall(
        token: communityToken,
        community: newCommunity,
        entitiesListAddress: entitiesListAddress,
      ));
    } catch (e, s) {
      logger.severe('ERROR - switchToNewCommunityCall $e');
      store.dispatch(ErrorAction('Could not switch community'));
      store.dispatch(SwitchCommunityFailed(communityAddress: communityAddress));
      await AppFactory().reportError(e, stackTrace: s);
    }
  };
}

ThunkAction switchToExisitingCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      Map<String, dynamic> communityData = await getCommunityData(
          checksumEthereumAddress(communityAddress),
          checksumEthereumAddress(walletAddress));
      String foreignTokenAddress = communityData['foreignTokenAddress'];
      String homeBridgeAddress = communityData['homeBridgeAddress'];
      String foreignBridgeAddress = communityData['foreignBridgeAddress'];
      String description = communityData['description'];
      String webUrl = communityData['webUrl'];
      Community newCommunity = Community.initial().copyWith(
        address: communityAddress,
        name: communityData["name"],
        foreignTokenAddress: foreignTokenAddress,
        webUrl: webUrl,
        homeBridgeAddress: homeBridgeAddress,
        foreignBridgeAddress: foreignBridgeAddress,
        description: description,
        plugins: Plugins.fromJson(communityData['plugins']),
        isMultiBridge: communityData?.containsKey('isMultiBridge') ?? false,
        isClosed: communityData['isClosed'],
      );
      bool isRopsten = communityData['isRopsten'];
      Token communityToken = await fetchToken(
          newCommunity, isRopsten, communityData['originNetwork']);
      store.dispatch(AddCashToken(
          token: communityToken.copyWith(
              timestamp: 0, communityAddress: communityAddress.toLowerCase())));
      newCommunity =
          newCommunity.copyWith(homeTokenAddress: communityToken?.address);
      store.dispatch(SwitchCommunitySuccess(community: newCommunity));
      store.dispatch(getBusinessListCall(
          communityAddress: communityAddress.toLowerCase(),
          isRopsten: isRopsten));
      store.dispatch(fetchCommunityMetadataCall(communityAddress.toLowerCase(),
          communityData['communityURI'], isRopsten));
    } catch (e, s) {
      logger.severe('ERROR - switchToExisitingCommunityCall $e');
      await AppFactory().reportError(e, stackTrace: s);
      store.dispatch(ErrorAction('Could not switch community'));
      store.dispatch(SwitchCommunityFailed(
          communityAddress: communityAddress.toLowerCase()));
    }
  };
}

ThunkAction refetchCommunityData() {
  return (Store store) async {
    String communityAddress = store.state.cashWalletState.communityAddress;
    final logger = await AppFactory().getLogger('action');
    logger.info('refetchCommunityData refetchCommunityData $communityAddress');
    String walletAddress = store.state.userState.walletAddress;
    Community current =
        store.state.cashWalletState.communities[communityAddress.toLowerCase()];
    if (current != null &&
        current.name != null &&
        current.isMember != null &&
        current.isMember) {
      Map<String, dynamic> communityData = await getCommunityData(
          checksumEthereumAddress(communityAddress),
          checksumEthereumAddress(walletAddress));
      bool isRopsten = communityData['isRopsten'];
      store.dispatch(fetchCommunityMetadataCall(communityAddress.toLowerCase(),
          communityData['communityURI'], isRopsten));
      store.dispatch(RefreshCommunityData(
          communityAddress: communityAddress,
          plugins: Plugins.fromJson(communityData['plugins']),
          webUrl: communityData['webUrl']));
      store.dispatch(fetchCommunityMetadataCall(communityAddress.toLowerCase(),
          communityData['communityURI'], isRopsten));
    } else {
      store.dispatch(switchCommunityCall(communityAddress));
    }
  };
}

ThunkAction switchCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    logger.info('switchCommunityCall switchCommunityCall $communityAddress');
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
        store.dispatch(switchToExisitingCommunityCall(communityAddress));
      } else {
        store.dispatch(SwitchToNewCommunity(communityAddress));
        store.dispatch(switchToNewCommunityCall(communityAddress));
      }
    } catch (e, s) {
      logger.info('ERROR - switchCommunityCall $e');
      await AppFactory().reportError(e, stackTrace: s);
      store.dispatch(ErrorAction('Could not switch community'));
      store.dispatch(SwitchCommunityFailed(
          communityAddress: communityAddress.toLowerCase()));
    }
  };
}

Map<String, dynamic> responseHandler(Response response) {
  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> obj = json.decode(response.body);
      return obj;
      break;
    default:
      throw 'Error! status: ${response.statusCode}, reason: ${response.reasonPhrase}';
  }
}

ThunkAction getBusinessListCall({String communityAddress, bool isRopsten}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
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
        Future<List<Business>> businesses =
            Future.wait(entities.map((dynamic entity) async {
          try {
            dynamic metadata = await api.getEntityMetadata(
                communityAddress, entity['address'],
                isRopsten: isOriginRopsten);
            return Business.initial().copyWith(
                account: entity['address'],
                name: metadata['name'] ?? '',
                metadata: BusinessMetadata.fromJson(metadata ?? {}));
          } catch (e) {
            return Business.initial().copyWith(
                account: entity['address'],
                name: formatAddress(entity['address']),
                metadata: BusinessMetadata.initial()
                    .copyWith(address: entity['address']));
          }
        }));
        List<Business> result = await businesses;
        result..toList();
        store.dispatch(GetBusinessListSuccess(
            businessList: result, communityAddress: communityAddress));
        store.dispatch(FetchingBusinessListSuccess());
      }
    } catch (e) {
      logger.severe('ERROR - getBusinessListCall $e');
      store.dispatch(FetchingBusinessListFailed());
      store.dispatch(new ErrorAction('Could not get businesses list'));
    }
  };
}

ThunkAction getTokenTransfersListCall(Token token) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      String tokenAddress = token?.address;
      num lastBlockNumber = token?.transactions?.blockNumber;
      dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
          walletAddress, tokenAddress,
          startblock: lastBlockNumber ?? 0);
      List<Transfer> transfers = List<Transfer>.from(
          tokensTransferEvents.map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(GetTokenTransfersListSuccess(
          tokenTransfers: transfers, tokenAddress: tokenAddress));
    } catch (e) {
      logger.severe('ERROR - getTokenTransfersListCall $e');
      store.dispatch(ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction getReceivedTokenTransfersListCall(Token token) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      num lastBlockNumber = token?.transactions?.blockNumber;
      final String tokenAddress = token?.address;
      dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
          walletAddress, tokenAddress,
          startblock: lastBlockNumber ?? 0);
      List<Transfer> transfers = List<Transfer>.from(
          tokensTransferEvents.map((json) => Transfer.fromJson(json)).toList());
      if (transfers.isNotEmpty) {
        store.dispatch(GetTokenTransfersListSuccess(
            tokenTransfers: transfers, tokenAddress: token.address));
      }
    } catch (e) {
      logger.severe('ERROR - getReceivedTokenTransfersListCall $e');
      store.dispatch(ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction sendTokenToContactCall(
    Token token,
    String contactPhoneNumber,
    num tokensAmount,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
    {String receiverName,
    String transferNote}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      logger.info("wallet $wallet");
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      logger.info("walletAddress $walletAddress");
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(token, contactPhoneNumber,
            tokensAmount, sendSuccessCallback, sendFailureCallback,
            receiverName: receiverName));
        return;
      }
      store.dispatch(sendTokenCall(token, walletAddress, tokensAmount,
          sendSuccessCallback, sendFailureCallback,
          receiverName: receiverName, transferNote: transferNote));
    } catch (e) {
      logger.severe('ERROR - sendTokenToContactCall $e');
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}
