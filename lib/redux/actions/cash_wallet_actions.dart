import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:seedbed/models/community/business.dart';
import 'package:seedbed/models/cash_wallet_state.dart';
import 'package:seedbed/models/community/business_metadata.dart';
import 'package:seedbed/models/community/community.dart';
import 'package:seedbed/models/community/community_metadata.dart';
import 'package:seedbed/models/jobs/base.dart';
import 'package:seedbed/models/plugins/join_bonus.dart';
import 'package:seedbed/models/plugins/plugins.dart';
import 'package:seedbed/models/tokens/token.dart';
import 'package:seedbed/models/transactions/transaction.dart';
import 'package:seedbed/models/transactions/transfer.dart';
import 'package:seedbed/models/user_state.dart';
import 'package:seedbed/redux/actions/error_actions.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:seedbed/redux/actions/pro_mode_wallet_actions.dart';
import 'package:seedbed/redux/actions/user_actions.dart';
import 'package:seedbed/utils/addresses.dart';
import 'package:seedbed/redux/state/store.dart';
import 'package:seedbed/utils/constans.dart';
import 'package:seedbed/utils/firebase.dart';
import 'package:seedbed/utils/format.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:seedbed/services.dart';
import 'dart:async';
import 'dart:convert';

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
  final String communityAddress;
  final BigInt tokenBalance;
  GetTokenBalanceSuccess({this.tokenBalance, this.communityAddress});
}

class GetSecondaryTokenBalanceSuccess {
  final String communityAddress;
  final BigInt balance;
  GetSecondaryTokenBalanceSuccess({this.balance, this.communityAddress});
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
  final bool isClosed;
  final Token token;
  final String communityAddress;
  final String communityName;
  final Plugins plugins;
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  final String webUrl;
  final CommunityMetadata metadata;
  final String secondaryTokenAddress;
  final String foreignTokenAddress;
  final Map customData;
  SwitchCommunitySuccess(
      {this.communityAddress,
      this.communityName,
      this.token,
      this.plugins,
      this.secondaryTokenAddress,
      this.isClosed,
      this.homeBridgeAddress,
      this.foreignBridgeAddress,
      this.foreignTokenAddress,
      this.metadata,
      this.webUrl,
      this.customData});
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
  final String communityAddress;
  final String tokenAddress;
  final List<Transfer> tokenTransfers;
  GetTokenTransfersListSuccess(
      {this.communityAddress, this.tokenTransfers, this.tokenAddress});
}

class StartBalanceFetchingSuccess {
  StartBalanceFetchingSuccess();
}

class SetIsTransfersFetching {
  final bool isFetching;
  SetIsTransfersFetching({this.isFetching});
}

class BranchCommunityToUpdate {
  final String communityAddress;
  BranchCommunityToUpdate(this.communityAddress);
}

class BranchListening {}

class BranchListeningStopped {}

class InviteSendSuccess {
  final String communityAddress;
  final Transaction invite;
  InviteSendSuccess({this.invite, this.communityAddress});
}

class ReplaceTransaction {
  final String communityAddress;
  final Transaction transaction;
  final Transaction transactionToReplace;
  ReplaceTransaction(
      {this.transaction, this.transactionToReplace, this.communityAddress});
}

class AddTransaction {
  final String communityAddress;
  final Transaction transaction;
  AddTransaction({this.transaction, this.communityAddress});
}

class AddJob {
  final String communityAddress;
  final Job job;
  AddJob({this.job, this.communityAddress});
}

class JobDone {
  final String communityAddress;
  final Job job;
  JobDone({this.job, this.communityAddress});
}

class UpdateJob {
  final String communityAddress;
  final Job job;
  UpdateJob({this.job, this.communityAddress});
}

class SetIsJobProcessing {
  final bool isFetching;
  SetIsJobProcessing({this.isFetching});
}

class FetchSecondaryTokenSuccess {
  final String communityAddress;
  final Token token;
  FetchSecondaryTokenSuccess({this.token, this.communityAddress});
}

class GetWeeklyRewardSucces {
  final BigInt nextReward;
  final BigInt currentReward;
  GetWeeklyRewardSucces({this.currentReward, this.nextReward});
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
      await AppFactory().reportError(e, s);
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
      await AppFactory().reportError(e, s);
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
      await AppFactory().reportError(e, s);
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

ThunkAction initWeb3Call(
  String privateKey, {
  String communityManagerAddress,
  String transferManagerAddress,
  String dAIPointsManagerAddress,
}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
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
          logger.info('SetDefaultCommunity branchAddress $branchAddress');
          store.dispatch(SetDefaultCommunity(branchAddress));
        } else {
          logger.info(
              'SetDefaultCommunity getDefaultCommunity ${web3.getDefaultCommunity().toLowerCase()}');
          store.dispatch(
              SetDefaultCommunity(web3.getDefaultCommunity().toLowerCase()));
        }
      }
      web3.setCredentials(privateKey);
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
    Map<String, Community> communities =
        store.state.cashWalletState.communities;
    final String walletAddress = store.state.userState.walletAddress;
    if (!isTransfersFetchingStarted &&
        communities.isNotEmpty &&
        walletAddress != null) {
      try {
        Map<String, Community> communities =
            store.state.cashWalletState.communities;
        for (Community community in communities.values) {
          if (community.token.address != null) {
            store.dispatch(getTokenTransfersListCall(community));
            store.dispatch(getTokenBalanceCall(community));
          }
        }
        logger.info('Timer start - startTransfersFetchingCall');
        new Timer.periodic(Duration(seconds: intervalSeconds * 2),
            (Timer t) async {
          if (store.state.userState.walletAddress == '') {
            logger.severe('Timer stopeed - startTransfersFetchingCall');
            store.dispatch(new SetIsTransfersFetching(isFetching: false));
            t.cancel();
            return;
          }
          Map<String, Community> communities =
              store.state.cashWalletState.communities;
          for (Community community in communities.values) {
            if (community.token.address != null) {
              store.dispatch(getReceivedTokenTransfersListCall(community));
            }
          }
        });
        store.dispatch(new SetIsTransfersFetching(isFetching: true));
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
      Map<String, dynamic> response = await api.createWallet();
      final String communityAddress =
          store.state.cashWalletState.communityAddress ??
              defaultCommunityAddress;
      if (!response.containsKey('job')) {
        logger.info('Wallet already exists');
        store.dispatch(CreateAccountWalletSuccess(accountAddress));
        store.dispatch(generateWalletSuccessCall(response, accountAddress));
        store.dispatch(switchCommunityCall(communityAddress));
        return;
      }
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      CashWalletState cashWalletState = store.state.cashWalletState;
      List<Job> jobs =
          cashWalletState.communities[communityAddress]?.token?.jobs ?? [];
      bool hasCreateWallet = jobs.any((job) => job.jobType == 'createWallet');
      if (hasCreateWallet) {
        store.dispatch(CreateAccountWalletRequest(accountAddress));
        return;
      }
      response['job']['arguments'] = {
        'accountAddress': accountAddress,
        'communityAddress': communityAddress
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, communityAddress: communityAddress));
      store.dispatch(new CreateAccountWalletRequest(accountAddress));
    } catch (e) {
      logger.severe('ERROR - createAccountWalletCall $e');
      store.dispatch(new ErrorAction('Could not create wallet'));
    }
  };
}

ThunkAction generateWalletSuccessCall(
    dynamic walletData, String accountAddress) {
  return (Store store) async {
    String walletAddress = walletData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(enablePushNotifications());
      String privateKey = store.state.userState.privateKey;
      List<String> networks = List<String>.from(walletData['networks']);
      String communityManager = walletData['communityManager'];
      String transferManager = walletData['transferManager'];
      String dAIPointsManager = walletData['dAIPointsManager'];
      store.dispatch(initWeb3Call(privateKey,
          communityManagerAddress: communityManager,
          transferManagerAddress: transferManager,
          dAIPointsManagerAddress: dAIPointsManager));
      bool deployedToForeign = networks?.contains(foreignNetwork) ?? false;
      if (deployedToForeign) {
        store.dispatch(initWeb3ProMode(
            privateKey: privateKey,
            communityManagerAddress: communityManager,
            transferManagerAddress: transferManager,
            dAIPointsManagerAddress: dAIPointsManager));
      }
      store.dispatch(new GetWalletAddressesSuccess(
          walletAddress: walletAddress,
          daiPointsManagerAddress: dAIPointsManager,
          communityManagerAddress: communityManager,
          transferManagerAddress: transferManager,
          networks: networks));
      Future.delayed(Duration(seconds: intervalSeconds), () {
        if (deployedToForeign) {
          store.dispatch(startListenToTransferEvents());
          store.dispatch(startFetchBalancesOnForeign());
          store.dispatch(fetchTokensBalances());
          store.dispatch(startFetchTransferEventsCall());
          store.dispatch(startFetchTokensLastestPrices());
          store.dispatch(startProcessingTokensJobsCall());
        }
      });
      store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
        "Wallet Generated": true,
        "App name": 'Seedbed',
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

ThunkAction getTokenBalanceCall(Community community) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      await community.token.fetchTokenBalance(walletAddress,
          onDone: (BigInt balance) {
        logger.info('${community.token.name} balance updated');
        store.dispatch(GetTokenBalanceSuccess(
            tokenBalance: balance, communityAddress: community.address));
        store.dispatch(UpdateDisplayBalance(
            int.tryParse(formatValue(balance, community.token.decimals))));
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
          '${community.name} Balance': formatValue(
              balance, community.token.decimals,
              withPrecision: true),
          "DisplayBalance": formatValue(balance, community.token.decimals,
              withPrecision: true)
        })));
      }, onError: (Object error, StackTrace stackTrace) {
        logger.severe(
            'Error in fetchTokenBalance for - ${community.token.name} $error');
      }, fromGraph: true);

      if (community.secondaryToken != null &&
          community.secondaryToken.address != null &&
          community.secondaryToken.address != '') {
        await community.secondaryToken.fetchTokenBalance(walletAddress,
            onDone: (BigInt balance) {
          final String amount = formatValue(balance, community.token.decimals,
              withPrecision: true);
          store.dispatch(GetSecondaryTokenBalanceSuccess(
              balance: balance, communityAddress: community.address));
          store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
            'Secondary token - ${community.name} Balance': amount,
            "Secondary token Display Balance": amount
          })));
        }, onError: (Object error, StackTrace stackTrace) {
          logger.severe(
              'Error in fetchTokenBalance secondaryToken for - ${community.token.name} $error');
        }, fromGraph: true);
      }
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
    Map<String, Community> communities =
        store.state.cashWalletState.communities;
    for (Community community in communities.values) {
      List<Job> jobs = community?.token?.jobs ?? [];
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
            logger.severe('failed perform ${job.name}');
          }
        }
        if (job.status == 'DONE') {
          // logger.info('Done ${job.name} ${job.id}');
          store
              .dispatch(JobDone(job: job, communityAddress: community.address));
          String tokenAddress = community?.token?.address;
          if (tokenAddress != null) {
            store.dispatch(getTokenBalanceCall(community));
          }
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
    String name,
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
      Community community = communities.values.firstWhere((element) =>
          element.token.address.toLowerCase() == token.address.toLowerCase());
      dynamic response = await api.invite(contactPhoneNumber,
          communityAddress: community.address,
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
          transaction: inviteTransfer, communityAddress: community.address));

      response['job']['arguments'] = {
        'tokensAmount': tokensAmount,
        'receiverName': receiverName,
        'sendSuccessCallback': () => {},
        'sendFailureCallback': sendFailureCallback,
        'inviteTransfer': inviteTransfer,
        'communityAddress': community.address
      };

      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, communityAddress: community.address));
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
    VoidCallback successCallBack = () {
      sendSuccessCallback();
      if (community.plugins.inviteBonus != null &&
          community.plugins.inviteBonus.isActive &&
          job.data['bonusInfo'] != null) {
        store.dispatch(inviteBonusCall(job.data, community));
      }
      store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
        "Invite ${community.name}": true,
      })));
    };

    String receiverAddress = job.data["walletAddress"];
    store.dispatch(sendTokenCall(community.token, receiverAddress, tokensAmount,
        successCallBack, sendFailureCallback,
        receiverName: receiverName, inviteTransfer: inviteTransfer));
    store.dispatch(loadContacts());
  };
}

ThunkAction inviteBonusCall(dynamic data, Community community) {
  return (Store store) async {
    BigInt value = toBigInt(
        community.plugins.inviteBonus.amount, community.token.decimals);
    String walletAddress = store.state.userState.walletAddress;
    String bonusJobId = data['bonusJob']['_id'];
    Transfer inviteBonus = new Transfer(
        from: DotEnv().env['FUNDER_ADDRESS'],
        to: walletAddress,
        tokenAddress: community.token.address,
        text: 'You got a invite bonus!',
        type: 'RECEIVE',
        value: value,
        status: 'PENDING',
        jobId: bonusJobId);
    store.dispatch(AddTransaction(
        transaction: inviteBonus, communityAddress: community.address));
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
    store.dispatch(AddJob(job: job, communityAddress: community.address));
  };
}

ThunkAction inviteBonusSuccessCall(transfer, String communityAddress) {
  return (Store store) async {
    Transfer confirmedTx = transfer.copyWith(
      status: 'CONFIRMED',
    );
    store.dispatch(new ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: confirmedTx,
        communityAddress: communityAddress));
    store.dispatch(segmentTrackCall('Wallet: invite bonus success'));
  };
}

// ThunkAction fetchListOfTokenByAccountAddress() {
//   return (Store store) async {
//     try {
//       final logger = await AppFactory().getLogger('action');
//       String walletAddress = store.state.userState.walletAddress;
//       List<dynamic> tokens =
//           await fuseExplorerApi.getListOfTokenByAccountAddress(walletAddress);
//       print('tokens tokens tokens $tokens');
//       Future<List<Community>> future =
//           Future.wait(tokens.map((dynamic tokenData) async {
//         print(
//             'tokenData tokenData tokenData $tokenData ${tokenData['address']}');
//         try {
//           dynamic tokenCommunityData =
//               await graph.getCommunityAddressByToken(tokenData['address']);
//           if (tokenCommunityData['communityAddress'] != null) {
//             final String communityAddress =
//                 tokenCommunityData['communityAddress'];
//             dynamic community =
//                 await graph.getCommunityByAddress(communityAddress);
//             bool isRopsten = tokenCommunityData != null &&
//                 tokenCommunityData['originNetwork'] == 'ropsten';
//             Map<String, dynamic> communityData = await api.getCommunityData(
//                 communityAddress,
//                 isRopsten: isRopsten,
//                 walletAddress: walletAddress);
//             final Plugins communityPlugins =
//                 Plugins.fromJson(communityData['plugins']);
//             final String homeBridgeAddress = communityData['homeBridgeAddress'];
//             final String foreignBridgeAddress =
//                 communityData['foreignBridgeAddress'];
//             final String webUrl = communityData['webUrl'];

//             CommunityMetadata communityMetadata = CommunityMetadata.initial();
//             if (communityData['communityURI'] != null) {
//               String hash = communityData['communityURI'].startsWith('ipfs://')
//                   ? communityData['communityURI'].split('://').last
//                   : communityData['communityURI'].split('/').last;
//               dynamic metadata = await api.fetchMetadata(
//                 hash,
//                 isRopsten: isRopsten,
//               );
//               communityMetadata = communityMetadata.copyWith(
//                   image: metadata['image'],
//                   coverPhoto: metadata['coverPhoto'],
//                   imageUri: metadata['imageUri'] ?? null,
//                   coverPhotoUri: metadata['coverPhotoUri'] ?? null,
//                   isDefaultImage: metadata['isDefault'] ?? false);
//             }
//             return Community.initial().copyWith(
//                 plugins: communityPlugins,
//                 metadata: communityMetadata,
//                 token: Token.initial().copyWith(
//                     originNetwork: tokenCommunityData['originNetwork'],
//                     address: tokenData['address'],
//                     name: tokenData['name'],
//                     symbol: tokenData["symbol"],
//                     decimals: int.parse(tokenData["decimals"])),
//                 name: community['name'],
//                 isClosed: communityData['isClosed'],
//                 homeBridgeAddress: homeBridgeAddress,
//                 address: communityAddress,
//                 foreignBridgeAddress: foreignBridgeAddress,
//                 webUrl: webUrl);
//           }
//           logger.severe('ERORR in tokenCommunityData $tokenCommunityData');
//           return null;
//         } catch (e) {
//           logger.severe('ERORR in fetchListOfTokenByAccountAddress $e');
//           return null;
//         }
//       }));

//       List<Community> result = await future;
//       result = result.toSet().toList()
//         ..removeWhere((element) => element == null);
//       store.dispatch(AddCommunities(
//           communities: Map<String, Community>.from(
//               result.fold({}, (previousValue, element) {
//         previousValue[element.address] = element;
//         return previousValue;
//       }))));
//     } catch (e) {}
//   };
// }

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
      Community community = communities.values.firstWhere((element) =>
          element.token.address.toLowerCase() == token.address.toLowerCase());
      String tokenAddress = token?.address;

      BigInt value = toBigInt(tokensAmount, token.decimals);
      logger.info(
          'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
      dynamic response = await api.tokenTransfer(
          web3, walletAddress, tokenAddress, receiverAddress, tokensAmount);

      dynamic jobId = response['job']['_id'];
      logger.info('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();
      Transfer transfer = new Transfer(
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
        store.dispatch(new ReplaceTransaction(
            transaction: inviteTransfer, transactionToReplace: transfer));
      } else {
        store.dispatch(new AddTransaction(
            transaction: transfer, communityAddress: community.address));
      }

      response['job']['arguments'] = {
        'transfer': transfer,
        'jobType': 'transfer',
        'communityAddress': community.address
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job: job, communityAddress: community.address));
    } catch (e) {
      logger.severe('ERROR - sendTokenCall $e');
      sendFailureCallback();
      store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction transactionFailed(transfer, communityAddress) {
  return (Store store) async {
    Transfer failedTx = transfer.copyWith(status: 'FAILED');
    store.dispatch(new ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: failedTx,
        communityAddress: communityAddress));
  };
}

ThunkAction joinCommunityCall(
    {String communityAddress,
    String entitiesListAddress,
    String communityName,
    JoinBonusPlugin joinBonusPlugin,
    Token token}) {
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
        store.dispatch(AlreadyJoinedCommunity(communityAddress));
      } else {
        dynamic response =
            await api.joinCommunity(web3, walletAddress, communityAddress);

        dynamic jobId = response['job']['_id'];
        Transfer transfer = new Transfer(
            type: 'RECEIVE',
            timestamp: DateTime.now().millisecondsSinceEpoch,
            text: 'Joining ' + communityName + ' community',
            tokenAddress: token.address,
            status: 'PENDING',
            jobId: jobId);
        logger.info('joinCommunity jobId $jobId');

        store.dispatch(AddTransaction(
            transaction: transfer, communityAddress: communityAddress));

        response['job']['arguments'] = {
          'transfer': transfer,
          'communityAddress': communityAddress,
          'communityName': communityName,
          'joinBonusPlugin': joinBonusPlugin,
          'token': token
        };
        Job job = JobFactory.create(response['job']);
        store.dispatch(AddJob(job: job, communityAddress: communityAddress));
      }
    } catch (e) {
      logger.severe('ERROR - joinCommunityCall $e');
      store.dispatch(new ErrorAction('Could not join community'));
    }
  };
}

ThunkAction joinCommunitySuccessCall(
    Job job,
    dynamic fetchedData,
    Transfer transfer,
    dynamic communityAddress,
    String communityName,
    JoinBonusPlugin joinBonusPlugin,
    Token token) {
  return (Store store) async {
    // final logger = await AppFactory().getLogger('action');
    Transfer confirmedTx = transfer.copyWith(
      status: 'CONFIRMED',
      text: 'Joined ' + (communityName ?? '') + ' community',
    );
    String joinCommunityJobId = job.id;
    // logger.info(
    //     'joinCommunitySuccessCall joinCommunityJobId $joinCommunityJobId');
    store.dispatch(new AlreadyJoinedCommunity(communityAddress));
    store.dispatch(new ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: confirmedTx,
        communityAddress: communityAddress));
    if (joinBonusPlugin != null && joinBonusPlugin.isActive) {
      String joinBonusJobId = fetchedData['data']['funderJobId'];
      BigInt value = toBigInt(joinBonusPlugin.amount, token.decimals);
      // logger.info('joinCommunitySuccessCall joinBonusJobId $joinBonusJobId');
      Transfer joinBonus = new Transfer(
          from: DotEnv().env['FUNDER_ADDRESS'],
          type: 'RECEIVE',
          value: value,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          tokenAddress: confirmedTx?.tokenAddress,
          text: 'You got a join bonus!',
          status: 'PENDING',
          jobId: joinBonusJobId ?? joinCommunityJobId);
      store.dispatch(new AddTransaction(
          transaction: joinBonus, communityAddress: communityAddress));
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
      store.dispatch(AddJob(job: job, communityAddress: communityAddress));
    }
  };
}

ThunkAction joinBonusSuccessCall(transfer, communiyAddress) {
  return (Store store) async {
    Transfer confirmedTx = transfer.copyWith(
      status: 'CONFIRMED',
    );
    store.dispatch(ReplaceTransaction(
        transaction: transfer,
        transactionToReplace: confirmedTx,
        communityAddress: communiyAddress));
    Map<String, Community> communities =
        store.state.cashWalletState.communities;
    Community communityData = communities[communiyAddress];
    store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
      "Join Bonus ${communityData.name} Received": true,
      "Community ${communityData.name} Joined": true,
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
      logger.info('ERROR - fetchCommunityMetadataCall $e');
      await AppFactory().reportError(e, s);
      store.dispatch(new ErrorAction('Could not fetch community metadata'));
    }
  };
}

ThunkAction fetchSecondaryTokenCall(
    String tokenAddress, String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      dynamic tokens = await graph.getTokenByAddress(tokenAddress);
      dynamic tokenInfo = tokens[0];
      CashWalletState cashWalletState = store.state.cashWalletState;
      final Community community = cashWalletState.communities[communityAddress];
      Token second = community.secondaryToken != null
          ? community.secondaryToken
          : Token.initial();
      logger.info(
          'fetched secondary token ${tokenInfo["name"]} ${tokenInfo["address"]} (${tokenInfo["symbol"]})');
      Token secondaryToken = second.copyWith(
          originNetwork: 'mainnet',
          address: tokenInfo["address"],
          name: tokenInfo["name"],
          symbol: tokenInfo["symbol"],
          decimals: tokenInfo["decimals"]);
      store.dispatch(FetchSecondaryTokenSuccess(
          token: secondaryToken, communityAddress: communityAddress));
      store.dispatch(getRewardsInfo());
    } catch (e) {
      logger.info('ERROR - fetchSecondaryTokenCall $e');
    }
  };
}

ThunkAction getRewardsInfo() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      CashWalletState cashWalletState = store.state.cashWalletState;
      final String communityAddress = cashWalletState.communityAddress;
      final Community community = cashWalletState.communities[communityAddress];
      if (community.customData != null &&
          community.customData.containsKey('marketMakerContractAddress')) {
        dynamic mintedReward = await web3
            .getRewardsInfo(community.customData['marketMakerContractAddress']);
        store.dispatch(GetWeeklyRewardSucces(
            currentReward: mintedReward['mintedReward'],
            nextReward: mintedReward['newMintedReward']));
      }
    } catch (e) {
      logger.severe('ERROR - getMintedReward $e');
    }
  };
}

ThunkAction setMintedReward(
  BigInt nom,
  BigInt dnom,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.userState.walletAddress;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      CashWalletState cashWalletState = store.state.cashWalletState;
      final String communityAddress = cashWalletState.communityAddress;
      final Community community = cashWalletState.communities[communityAddress];
      String reserveContractAddress =
          community?.customData['reserveContractAddress'];
      logger.info('reserveContractAddress $reserveContractAddress');
      if (![null, ''].contains(reserveContractAddress)) {
        dynamic data =
            await web3.setMintedReward(reserveContractAddress, [nom, dnom]);
        dynamic response = await api.callContract(
            web3, walletAddress, reserveContractAddress, 0, data);
        dynamic jobId = response['job']['_id'];
        sendSuccessCallback();
        logger.info('Job $jobId for calling setWeeklyReward');
      }
    } catch (e) {
      logger.severe('ERROR - setMintedReward $e');
      sendFailureCallback();
    }
  };
}

ThunkAction switchToNewCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      dynamic community = await graph.getCommunityByAddress(communityAddress);
      logger.info('community fetched for $communityAddress');
      dynamic token = await graph.getTokenOfCommunity(communityAddress);
      final String tokenAddress = token["address"];
      bool isRopsten = token != null && token['originNetwork'] == 'ropsten';
      logger.info(
          'token $tokenAddress (${token["symbol"]}) fetched for $communityAddress on ${token['originNetwork']} network');
      String walletAddress = store.state.userState.walletAddress;
      Map<String, dynamic> communityData = await api.getCommunityData(
          communityAddress,
          isRopsten: isRopsten,
          walletAddress: walletAddress);
      final Plugins communityPlugins =
          Plugins.fromJson(communityData['plugins']);
      final String homeBridgeAddress = communityData['homeBridgeAddress'];
      final String foreignBridgeAddress = communityData['foreignBridgeAddress'];
      String foreignTokenAddress = communityData['foreignTokenAddress'];
      final String webUrl = communityData['webUrl'];
      final String secondaryTokenAddress =
          communityData['secondaryTokenAddress'];

      if (![null, ''].contains(secondaryTokenAddress)) {
        store.dispatch(fetchSecondaryTokenCall(
            secondaryTokenAddress, communityAddress.toLowerCase()));
      }
      Map customData = Map.from(communityData['customData']);
      logger.info(
          'reserveContractAddress ${communityData['customData']['reserveContractAddress']}');
      final Token communityToken = Token.initial().copyWith(
          originNetwork: token['originNetwork'],
          address: tokenAddress,
          name: token["name"],
          symbol: token["symbol"],
          decimals: token["decimals"]);
      store.dispatch(SwitchCommunitySuccess(
          customData: customData,
          communityAddress: communityAddress,
          communityName: community["name"],
          token: communityToken,
          plugins: communityPlugins,
          isClosed: communityData['isClosed'],
          homeBridgeAddress: homeBridgeAddress,
          foreignBridgeAddress: foreignBridgeAddress,
          foreignTokenAddress: foreignTokenAddress,
          webUrl: webUrl));
      store.dispatch(segmentTrackCall("Wallet: Switch Community",
          properties: new Map<String, dynamic>.from({
            "Community Name": community["name"],
            "Community Address": communityAddress,
            "Token Address": tokenAddress,
            "Token Symbol": token["symbol"],
            "Origin Network": token['originNetwork']
          })));
      logger.info('joinCommunityCall joinCommunityCall $tokenAddress');

      final String entitiesListAddress = community["entitiesList"]["address"];
      store.dispatch(fetchCommunityMetadataCall(
          communityAddress, communityData['communityURI'], isRopsten));
      store.dispatch(getBusinessListCall(
          communityAddress: communityAddress.toLowerCase(),
          isRopsten: isRopsten));
      store.dispatch(joinCommunityCall(
          communityName: community["name"],
          communityAddress: communityAddress,
          entitiesListAddress: entitiesListAddress,
          joinBonusPlugin: communityPlugins?.joinBonus,
          token: communityToken));
    } catch (e, s) {
      logger.severe('ERROR - switchToNewCommunityCall $e');
      store.dispatch(ErrorAction('Could not switch community'));
      store.dispatch(SwitchCommunityFailed(communityAddress: communityAddress));
      await AppFactory().reportError(e, s);
    }
  };
}

ThunkAction switchToExisitingCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      Community current = store
          .state.cashWalletState.communities[communityAddress.toLowerCase()];
      bool isRopsten =
          current.token != null && current.token.originNetwork == 'ropsten';
      String walletAddress = store.state.userState.walletAddress;
      Map<String, dynamic> communityData = await api.getCommunityData(
          communityAddress,
          isRopsten: isRopsten,
          walletAddress: walletAddress);
      final Plugins communityPlugins =
          Plugins.fromJson(communityData['plugins']);
      String homeBridgeAddress = communityData['homeBridgeAddress'];
      String foreignBridgeAddress = communityData['foreignBridgeAddress'];
      String foreignTokenAddress = communityData['foreignTokenAddress'];
      String webUrl = communityData['webUrl'];
      String secondaryTokenAddress =
          communityData['secondaryTokenAddress'] ?? '';
      Map customData = Map.from(communityData['customData']);
      logger.info(
          'reserveContractAddress ${communityData['customData']['reserveContractAddress']}');
      store.dispatch(SwitchCommunitySuccess(
          customData: customData,
          communityAddress: communityAddress,
          communityName: current.name,
          token: current.token,
          plugins: communityPlugins,
          isClosed: current.isClosed,
          homeBridgeAddress: homeBridgeAddress,
          secondaryTokenAddress: secondaryTokenAddress,
          foreignBridgeAddress: foreignBridgeAddress,
          foreignTokenAddress: foreignTokenAddress,
          webUrl: webUrl));

      store.dispatch(getBusinessListCall(
          communityAddress: communityAddress.toLowerCase(),
          isRopsten: isRopsten));
      store.dispatch(fetchCommunityMetadataCall(communityAddress.toLowerCase(),
          communityData['communityURI'], isRopsten));
      if (![null, ''].contains(secondaryTokenAddress)) {
        store.dispatch(fetchSecondaryTokenCall(
            secondaryTokenAddress, communityAddress.toLowerCase()));
      }
    } catch (e, s) {
      logger.severe('ERROR - switchToExisitingCommunityCall $e');
      await AppFactory().reportError(e, s);
      store.dispatch(ErrorAction('Could not switch community'));
      store.dispatch(SwitchCommunityFailed(
          communityAddress: communityAddress.toLowerCase()));
    }
  };
}

ThunkAction switchCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    if (communityAddress == null) return;
    try {
      bool isLoading = store.state.cashWalletState.isCommunityLoading ?? false;
      if (isLoading) return;
      Community current = store
          .state.cashWalletState.communities[communityAddress.toLowerCase()];
      if (current != null &&
          current.name != null &&
          current.token != null &&
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
      await AppFactory().reportError(e, s);
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
      bool isOriginRopsten = isRopsten ??
          (community?.token?.originNetwork != null
              ? community?.token?.originNetwork == 'ropsten'
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

ThunkAction getTokenTransfersListCall(Community community) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      String tokenAddress = community?.token?.address;
      num lastBlockNumber = community?.token?.transactions?.blockNumber;
      dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
          walletAddress, tokenAddress,
          startblock: lastBlockNumber ?? 0);
      List<Transfer> transfers = List<Transfer>.from(
          tokensTransferEvents.map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(new GetTokenTransfersListSuccess(
          tokenTransfers: transfers, communityAddress: community.address));

      if (community.secondaryToken != null) {
        num lastBlockNumber =
            community?.secondaryToken?.transactions?.blockNumber;
        final tokenAddress = community?.secondaryToken?.address;
        dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
            walletAddress, tokenAddress,
            startblock: lastBlockNumber ?? 0);
        List<Transfer> transfers = List<Transfer>.from(tokensTransferEvents
            .map((json) => Transfer.fromJson(json))
            .toList());
        store.dispatch(new GetTokenTransfersListSuccess(
            tokenTransfers: transfers,
            communityAddress: community.address,
            tokenAddress: tokenAddress));
      }
    } catch (e) {
      logger.severe('ERROR - getTokenTransfersListCall $e');
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction getReceivedTokenTransfersListCall(Community community) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String walletAddress = store.state.userState.walletAddress;
      num lastBlockNumber = community?.token?.transactions?.blockNumber;
      final String tokenAddress = community?.token?.address;
      dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
          walletAddress, tokenAddress,
          startblock: lastBlockNumber ?? 0);
      List<Transfer> transfers = List<Transfer>.from(
          tokensTransferEvents.map((json) => Transfer.fromJson(json)).toList());
      if (transfers.isNotEmpty) {
        // logger.info('transfers transfers transfers ${transfers.length}');
        store.dispatch(new GetTokenTransfersListSuccess(
            tokenTransfers: transfers, communityAddress: community.address));
        store.dispatch(getTokenBalanceCall(community));
      }

      if (community.secondaryToken != null) {
        dynamic response = await api.fetchTokenTxByAddress(
            walletAddress, community.secondaryToken.address,
            startblock:
                community?.secondaryToken?.transactions?.blockNumber ?? 0);
        List<Transfer> secondaryTokenTransfers = List<Transfer>.from(
            response.map((json) => Transfer.fromJson(json)).toList());
        // logger.info(
        //     'secondaryTokenTransfers secondaryTokenTransfers secondaryTokenTransfers ${secondaryTokenTransfers.length}');
        if (transfers.isNotEmpty) {
          store.dispatch(new GetTokenTransfersListSuccess(
              tokenTransfers: secondaryTokenTransfers,
              communityAddress: community.address,
              tokenAddress: community.secondaryToken.address));
          store.dispatch(getTokenBalanceCall(community));
        }
      }
    } catch (e) {
      logger.severe('ERROR - getReceivedTokenTransfersListCall $e');
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction sendTokenToContactCall(
    Token token,
    String name,
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
        store.dispatch(inviteAndSendCall(token, name, contactPhoneNumber,
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

ThunkAction buyTokenAction(num tokensAmount, VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.userState.walletAddress;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      CashWalletState cashWalletState = store.state.cashWalletState;
      final String communityAddress = cashWalletState.communityAddress;
      final Community community = cashWalletState.communities[communityAddress];
      final Token daiToken = community.token;
      final String reserveContractAddress =
          community?.customData['reserveContractAddress'];
      if (![null, ''].contains(reserveContractAddress)) {
        dynamic response = await api.buyToken(
            reserveContractAddress,
            daiToken.address,
            web3,
            daiToken.address,
            walletAddress,
            tokensAmount);
        sendSuccessCallback();
        dynamic jobId = response['job']['_id'];
        logger.info('buyTokenAction $jobId');
        Transfer transfer = new Transfer(
            from: walletAddress,
            to: walletAddress,
            tokenAddress: daiToken.address,
            value: toBigInt(tokensAmount, daiToken.decimals),
            type: 'SEND',
            note: '',
            receiverName: '',
            timestamp: DateTime.now().millisecondsSinceEpoch,
            status: 'PENDING',
            jobId: jobId);

        response['job']['jobType'] = 'convertToken';
        response['job']['arguments'] = {
          'transfer': transfer,
          'communityAddress': community.address
        };
        store.dispatch(new AddTransaction(
            transaction: transfer, communityAddress: communityAddress));
        Job job = JobFactory.create(response['job']);
        store.dispatch(AddJob(job: job, communityAddress: communityAddress));
      }
    } catch (e) {
      sendFailureCallback();
      logger.severe('ERROR - buyTokenAction $e');
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}

ThunkAction sellTokenAction(num tokensAmount, VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.userState.walletAddress;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      CashWalletState cashWalletState = store.state.cashWalletState;
      final String communityAddress = cashWalletState.communityAddress;
      final Community community = cashWalletState.communities[communityAddress];
      final Token daiToken = community.token;
      final Token comToken = community.secondaryToken;
      final String reserveContractAddress =
          community?.customData['reserveContractAddress'];
      if (![null, ''].contains(reserveContractAddress)) {
        dynamic response = await api.sellToken(
            community.customData['reserveContractAddress'],
            daiToken.address,
            web3,
            comToken.address,
            walletAddress,
            tokensAmount);
        sendSuccessCallback();
        dynamic jobId = response['job']['_id'];
        logger.info('sellTokenAction $jobId');
        Transfer transfer = new Transfer(
            from: walletAddress,
            to: walletAddress,
            tokenAddress: comToken.address,
            value: toBigInt(tokensAmount, community.token.decimals),
            type: 'SEND',
            note: '',
            receiverName: '',
            timestamp: DateTime.now().millisecondsSinceEpoch,
            status: 'PENDING',
            jobId: jobId);
        store.dispatch(new AddTransaction(
            transaction: transfer, communityAddress: communityAddress));
        response['job']['jobType'] = 'convertToken';
        response['job']['arguments'] = {
          'transfer': transfer,
          'communityAddress': communityAddress
        };
        Job job = JobFactory.create(response['job']);
        store.dispatch(AddJob(job: job, communityAddress: communityAddress));
      }
    } catch (e) {
      sendFailureCallback();
      logger.severe('ERROR - sellTokenAction $e');
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}
