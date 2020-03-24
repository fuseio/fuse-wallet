import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:localpay/models/business.dart';
import 'package:localpay/models/community.dart';
import 'package:localpay/models/community_metadata.dart';
import 'package:localpay/models/jobs/base.dart';
import 'package:localpay/models/plugins.dart';
import 'package:localpay/models/transactions/transaction.dart';
import 'package:localpay/models/transactions/transactions.dart';
import 'package:localpay/models/transactions/transfer.dart';
import 'package:localpay/models/user_state.dart';
import 'package:localpay/redux/actions/error_actions.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:localpay/redux/actions/pro_mode_wallet_actions.dart';
import 'package:localpay/redux/actions/user_actions.dart';
import 'package:localpay/utils/forks.dart';
import 'package:localpay/redux/state/store.dart';
import 'package:localpay/utils/format.dart';
import 'package:localpay/utils/phone.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:localpay/services.dart';
import 'package:localpay/models/token.dart';
import 'dart:async';
import 'dart:convert';

class SetDefaultCommunity {
  String defaultCommunity;
  SetDefaultCommunity(this.defaultCommunity);
}

class InitWeb3Success {
  final wallet_core.Web3 web3;
  InitWeb3Success(this.web3);
}

class OnboardUserSuccess {
  final String accountAddress;
  OnboardUserSuccess(this.accountAddress);
}

class GetWalletAddressesSuccess {
  final List<String> networks;
  final String walletAddress;
  final String communityManagerAddress;
  final String transferManagerAddress;
  GetWalletAddressesSuccess({this.networks, this.walletAddress, this.communityManagerAddress, this.transferManagerAddress});
}

class CreateAccountWalletRequest {
  final String accountAddress;
  CreateAccountWalletRequest(this.accountAddress);
}

class CreateAccountWalletSuccess {
  final String accountAddress;
  CreateAccountWalletSuccess(this.accountAddress);
}

class GetTokenBalanceSuccess {
  final BigInt tokenBalance;
  GetTokenBalanceSuccess(this.tokenBalance);
}

class SendTokenSuccess {
  final String txHash;
  SendTokenSuccess(this.txHash);
}

class JoinCommunitySuccess {
  final String txHash;
  final String communityAddress;
  final String communityName;
  final Token token;
  JoinCommunitySuccess(
      this.txHash, this.communityAddress, this.communityName, this.token);
}

class AlreadyJoinedCommunity {
  final String communityAddress;
  AlreadyJoinedCommunity(this.communityAddress);
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
  final Transactions transactions;
  final Plugins plugins;
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  SwitchCommunitySuccess({this.communityAddress, this.communityName, this.token,
      this.transactions, this.plugins, this.isClosed, this.homeBridgeAddress, this.foreignBridgeAddress});
}

class FetchCommunityMetadataSuccess {
  final CommunityMetadata metadata;
  FetchCommunityMetadataSuccess(this.metadata);
}

class SwitchCommunityFailed {}

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
  final List<Business> businessList;
  GetBusinessListSuccess(this.businessList);
}

class TransferJobSuccess {
  Job job;
  TransferJobSuccess(this.job);
}

class TransferInviteJobSuccess {
  Job job;
  TransferInviteJobSuccess(this.job);
}

class GetTokenTransfersListSuccess {
  List<Transfer> tokenTransfers;
  GetTokenTransfersListSuccess(this.tokenTransfers);
}

class StartBalanceFetchingSuccess {
  StartBalanceFetchingSuccess();
}

class StartTransfersFetchingSuccess {
  String tokenAddress;
  StartTransfersFetchingSuccess();
}

class TransferSendSuccess {
  Transfer transfer;
  TransferSendSuccess(this.transfer);
}

class BranchCommunityUpdate {
  BranchCommunityUpdate();
}

class BranchCommunityToUpdate {
  final String communityAddress;
  BranchCommunityToUpdate(this.communityAddress);
}

class AddSendToInvites {
  final String jobId;
  final num amount;
  AddSendToInvites(this.jobId, this.amount);
}

class RemoveSendToInvites {
  final String jobId;
  RemoveSendToInvites(this.jobId);
}

class BranchListening {}

class BranchListeningStopped {}

class BranchDataReceived {}

class InviteSendSuccess {
  final Transaction invite;
  InviteSendSuccess(this.invite);
}

class ReplaceTransaction {
  final Transaction transaction;
  final Transaction transactionToReplace;
  ReplaceTransaction(this.transaction, this.transactionToReplace);
}

class AddTransaction {
  final Transaction transaction;
  AddTransaction(this.transaction);
}

class AddJob {
  final Job job;
  AddJob(this.job);
}

class JobDone {
  final Job job;
  JobDone(this.job);
}

class JobProcessingStarted {
  JobProcessingStarted();
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

      String walletAddress = store.state.cashWalletState.walletAddress;
      await api.updateFirebaseToken(walletAddress, token);
      await Segment.setContext({
        'device': {
          'token': token
        },
      });

      firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          logger.info('onMessage called: $message');
        },
        onResume: (Map<String, dynamic> message) async {
          logger.info('onResume called: $message');
        },
        onLaunch: (Map<String, dynamic> message) async {
          logger.info('onLaunch called: $message');
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
      String fullPhoneNumber = formatPhoneNumber(userState.phoneNumber, userState.countryCode);
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
    final logger = await AppFactory().getLogger('action');
    logger.info("branch listening.");
    store.dispatch(BranchListening());

    Function handler = (linkData) async {
      logger.info("Got link data: ${linkData.toString()}");
      if (linkData["~feature"] == "switch_community") {
        var communityAddress = linkData["community_address"];
        logger.info("communityAddress $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({ 'Referral': linkData["~feature"], 'Referral link': linkData['~referring_link'] })));
        store.dispatch(segmentTrackCall("Wallet: Branch: Studio Invite", properties: new Map<String, dynamic>.from(linkData)));
      }
      if (linkData["~feature"] == "invite_user") {
        var communityAddress = linkData["community_address"];
        logger.info("community_address $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({ 'Referral': linkData["~feature"], 'Referral link': linkData['~referring_link'] })));
        store.dispatch(segmentTrackCall("Wallet: Branch: User Invite", properties: new Map<String, dynamic>.from(linkData)));
      }
      store.dispatch(BranchDataReceived());
    };

    FlutterBranchSdk.initSession().listen((data) {
      handler(data);
    }, onError: (error, s) async {
      logger.severe('ERROR - FlutterBranchSdk initSession $error');
      store.dispatch(BranchListeningStopped());
      await AppFactory().reportError(error, s);
    }, cancelOnError: true);
  };
}

ThunkAction initWeb3Call(String privateKey, {
  String communityManagerContractAddress,
  String transferManagerContractAddress
}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('initWeb3. privateKey: $privateKey');
      wallet_core.Web3 web3 = new wallet_core.Web3(approvalCallback,
          defaultCommunityAddress:
            DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'],
          communityManagerAddress:
            communityManagerContractAddress ?? DotEnv().env['COMMUNITY_MANAGER_CONTRACT_ADDRESS'],
          transferManagerAddress:
            transferManagerContractAddress ?? DotEnv().env['TRANSFER_MANAGER_CONTRACT_ADDRESS']);
      if (store.state.cashWalletState.communityAddress == null ||
          store.state.cashWalletState.communityAddress.isEmpty) {
        store.dispatch(SetDefaultCommunity(web3.getDefaultCommunity()));
      }
      web3.setCredentials(privateKey);
      store.dispatch(new InitWeb3Success(web3));
    } catch (e) {
      logger.severe('ERROR - initWeb3Call $e');
      store.dispatch(new ErrorAction('Could not init web3'));
    }
  };
}

ThunkAction startBalanceFetchingCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    logger.info('Start Balance Fetching Call');
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres];
    String tokenAddress = community?.token?.address;
    if (tokenAddress != null) {
      store.dispatch(getTokenBalanceCall(tokenAddress));
    }
    new Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (store.state.cashWalletState.walletAddress == '') {
        t.cancel();
        return;
      }
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      String tokenAddress = community?.token?.address;

      if (tokenAddress != null) {
        store.dispatch(getTokenBalanceCall(tokenAddress));
      }
    });
    store.dispatch(new StartBalanceFetchingSuccess());
  };
}

ThunkAction startTransfersFetchingCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    logger.info('Start Transfers Fetching Call');
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres];
    String tokenAddress = community.token?.address;
    if (tokenAddress != null) {
      store.dispatch(getTokenTransfersListCall(tokenAddress));
      store.dispatch(getTokenBalanceCall(tokenAddress));
    }
    new Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (store.state.cashWalletState.walletAddress == '') {
        t.cancel();
        return;
      }
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      String tokenAddress = community.token?.address;
      if (tokenAddress != null) {
        store.dispatch(getReceivedTokenTransfersListCall(tokenAddress));
      }
    });
    store.dispatch(new StartTransfersFetchingSuccess());
  };
}

ThunkAction createAccountWalletCall(String accountAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('createAccountWalletCall');
      logger.info('accountAddress: $accountAddress');
      Map<String, dynamic> response = await api.createWallet();
      if (!response.containsKey('job')) {
        logger.info('Wallet already exists');
        store.dispatch(new CreateAccountWalletSuccess(accountAddress));
        store.dispatch(generateWalletSuccessCall(response, accountAddress));
        return;
      }
      List<Job> jobs = store.state.cashWalletState.communities[store.state.cashWalletState.communityAddress].jobs;
      bool hasCreateWallet = jobs.any((job) => job.jobType == 'createWallet');
      if (hasCreateWallet) {
        store.dispatch(new CreateAccountWalletRequest(accountAddress));
        return;
      }
      response['job']['arguments'] = {
        'accountAddress': accountAddress
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
      store.dispatch(new CreateAccountWalletRequest(accountAddress));
    } catch (e) {
      logger.severe('ERROR - createAccountWalletCall $e');
      store.dispatch(new ErrorAction('Could not create wallet'));
    }
  };
}

ThunkAction generateWalletSuccessCall(dynamic walletData, String accountAddress) {
  return (Store store) async {
    String walletAddress = walletData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
          store.dispatch(enablePushNotifications());
          String privateKey = store.state.userState.privateKey;
          List<String> networks = List<String>.from(walletData['networks']);
          String communityManager = walletData['communityManager'];
          String transferManager = walletData['transferManager'];
          store.dispatch(initWeb3Call(
            privateKey,
            communityManagerContractAddress: communityManager,
            transferManagerContractAddress: transferManager
          ));
          store.dispatch(new GetWalletAddressesSuccess(walletAddress: walletAddress, communityManagerAddress: communityManager, transferManagerAddress: transferManager, networks: networks));
          String fullPhoneNumber = formatPhoneNumber(store.state.userState.phoneNumber, store.state.userState.countryCode);
          store.dispatch(segmentIdentifyCall(
              new Map<String, dynamic>.from({
                "Wallet Generated": true,
                "App name": 'Fuse',
                "Phone Number": fullPhoneNumber,
                "Wallet Address": store.state.cashWalletState.walletAddress,
                "Account Address": store.state.userState.accountAddress,
                "Display Name": store.state.userState.displayName
              })));
          store.dispatch(segmentTrackCall('Wallet: Wallet Generated'));
          store.dispatch(create3boxAccountCall(accountAddress));
    }
  };
}

ThunkAction getWalletAddressessCall({String communityManager, String transferManager}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String privateKey = store.state.userState.privateKey;
      List<String> networks = store.state.userState?.networks ?? [];
      String communityManagerAddress;
      String transferManagerAddress;
      if (communityManager != null &&
          communityManager != '' &&
          transferManager != null &&
          transferManager != '' &&
          networks.isNotEmpty) {
        communityManagerAddress = communityManager;
        transferManagerAddress = transferManager;
      } else {
        dynamic walletData = await api.getWallet();
        List<String> networks = List<String>.from(walletData['networks']);
        String walletAddress = walletData['walletAddress'];
        communityManager = walletData['communityManager'];
        transferManager = walletData['transferManager'];
        store.dispatch(new GetWalletAddressesSuccess(walletAddress: walletAddress, communityManagerAddress: communityManager, transferManagerAddress: transferManager, networks: networks));
      }
      store.dispatch(initWeb3Call(
        privateKey,
        communityManagerContractAddress: communityManagerAddress,
        transferManagerContractAddress: transferManagerAddress
      ));
    } catch (e) {
      logger.severe('ERROR - getWalletAddressCall $e');
      store.dispatch(new ErrorAction('Could not get wallet address'));
    }
  };
}

ThunkAction getTokenBalanceCall(String tokenAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      bool isLoading = store.state.cashWalletState.isCommunityLoading ?? false;
      if (isLoading) return;
      String walletAddress = store.state.cashWalletState.walletAddress;
      BigInt tokenBalance = (await graph.getTokenBalance(walletAddress, tokenAddress));
      String communityAddress = store.state.cashWalletState.communityAddress;
      Community community = store.state.cashWalletState.communities[communityAddress];
      String balance = formatValue(tokenBalance, community.token.decimals);

      store.dispatch(new GetTokenBalanceSuccess(tokenBalance));
      store.dispatch(new UpdateDisplayBalance(int.parse(balance)));
      store.dispatch(segmentIdentifyCall(Map<String, dynamic>.from({
        '${community.name} Balance': balance,
        "DisplayBalance": balance
      })));
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
    new Timer.periodic(Duration(seconds: 3), (Timer timer) async {
      store.dispatch(fetchJobCall(jobId, fetchSuccessCallback,
          timer: timer, untilDone: untilDone));
    });
  };
}

ThunkAction processingJobsCall(Timer timer) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('Job');
    String communityAddress = store.state.cashWalletState.communityAddress;
    String walletAddress = store.state.cashWalletState.walletAddress;
    Community community = store.state.cashWalletState.communities[communityAddress];
    List<Job> jobs = community.jobs;
    for (Job job in jobs) {
      String currentCommunityAddress = store.state.cashWalletState.communityAddress;
      String currentWalletAddress = store.state.cashWalletState.walletAddress;
      if (job.status != 'DONE' && job.status != 'FAILED') {
        bool isJobProcessValid() {
          if ((currentCommunityAddress != communityAddress) || (currentWalletAddress != walletAddress)) {
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
      if (job.status == 'DONE') {
        store.dispatch(JobDone(job));
        String tokenAddress = community?.token?.address;
        if (tokenAddress != null) {
          store.dispatch(getTokenBalanceCall(tokenAddress));
        }
      }
    }
  };
}

ThunkAction startProcessingJobsCall() {
  return (Store store) async {
    new Timer.periodic(Duration(seconds: 3), (Timer timer) async {
      store.dispatch(processingJobsCall(timer));
    });
    store.dispatch(JobProcessingStarted());
  };
}

ThunkAction inviteAndSendCall(
  String name,
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
  {String receiverName = ''}
) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String communityAddres = store.state.cashWalletState.communityAddress;
      String senderName = store.state.userState.displayName;
      Community community = store.state.cashWalletState.communities[communityAddres];
      Token token = community?.token;
      dynamic response = await api.invite(
        contactPhoneNumber,
        store.state.cashWalletState.communityAddress,
        name: senderName,
        amount: tokensAmount.toString(),
        symbol: token.symbol
      );
      sendSuccessCallback();

      String tokenAddress = token?.address;

      BigInt value = toBigInt(tokensAmount, token.decimals);
      String walletAddress = store.state.cashWalletState.walletAddress;

      Transfer inviteTransfer = new Transfer(
          from: walletAddress,
          to: '',
          tokenAddress: tokenAddress,
          value: value,
          type: 'SEND',
          receiverName: receiverName,
          status: 'PENDING',
          jobId: response['job']['_id']);
      store.dispatch(AddTransaction(inviteTransfer));

      response['job']['arguments'] = {
        'tokensAmount': tokensAmount,
        'receiverName': receiverName,
        'sendSuccessCallback': () => {},
        'sendFailureCallback': sendFailureCallback,
        'inviteTransfer': inviteTransfer
      };

      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
    } catch (e) {
      logger.severe('ERROR - inviteAndSendCall $e');
    }
  };
}

ThunkAction inviteAndSendSuccessCall(Job job, dynamic data, tokensAmount, receiverName, inviteTransfer, sendSuccessCallback, sendFailureCallback) {
  return (Store store) async {
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community = store.state.cashWalletState.communities[communityAddres];
      VoidCallback successCallBack = () {
        sendSuccessCallback();
          if (community.plugins.inviteBonus != null && community.plugins.inviteBonus.isActive && data['bonusInfo'] != null) {
          store.dispatch(inviteBonusCall(data));
        }
        store.dispatch(segmentIdentifyCall(
          new Map<String, dynamic>.from({
            "Invite ${community.name}": true,
          })
        ));
      };

      String receiverAddress = job.data["walletAddress"];
      store.dispatch(sendTokenCall(receiverAddress, tokensAmount,
          successCallBack, sendFailureCallback,
          receiverName: receiverName, inviteTransfer: inviteTransfer));
      store.dispatch(syncContactsCall(store.state.userState.contacts));
      
  };
}

ThunkAction inviteBonusCall(dynamic data) {
  return (Store store) async {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres];
    BigInt value = toBigInt(community.plugins.inviteBonus.amount, community.token.decimals);
    String walletAddress = store.state.cashWalletState.walletAddress;
    String bonusJobId = data['bonusJob']['_id'];
    Transfer inviteBonus = new Transfer(
        from: DotEnv().env['FUNDER_ADDRESS'],
        to: walletAddress,
        text: 'You got a invite bonus!',
        type: 'RECEIVE',
        value: value,
        status: 'PENDING',
        jobId: bonusJobId);
    store.dispatch(AddTransaction(inviteBonus));
    Map response = new Map.from({
      'job': {
        'id': bonusJobId,
        'jobType': 'inviteBonus',
        'arguments': {
          'inviteBonus': inviteBonus,
        }
      }
    });
  
    Job job = JobFactory.create(response['job']);
    store.dispatch(AddJob(job));
  };
}

ThunkAction inviteBonusSuccessCall(String txHash, transfer) {
  return (Store store) async {
    Transfer confirmedTx = transfer.copyWith(status: 'CONFIRMED', txHash: txHash);
    store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
    store.dispatch(segmentTrackCall('Wallet: invite bonus success'));
  };
}

ThunkAction sendTokenCall(String receiverAddress, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback,
    {String receiverName, String transferNote, Transfer inviteTransfer}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      Token token = community?.token;
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
          type: 'SEND',
          note: transferNote,
          receiverName: receiverName,
          status: 'PENDING',
          jobId: jobId);

      if (inviteTransfer != null) {
        store.dispatch(new ReplaceTransaction(inviteTransfer, transfer));
      } else {
        store.dispatch(new AddTransaction(transfer));
      }

      response['job']['arguments'] = {
        'transfer': transfer,
        'jobType': 'transfer'
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
    } catch (e) {
      logger.severe('ERROR - sendTokenCall $e');
      sendFailureCallback();
      store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction sendTokenSuccessCall(job, transfer) {
  return (Store store) async {
    Transfer confirmedTx =
        transfer.copyWith(status: 'CONFIRMED', txHash: job.data['txHash']);
    store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
  };
}

ThunkAction transactionFailed(transfer) {
  return (Store store) async {
    Transfer failedTx =
        transfer.copyWith(status: 'FAILED');
    store.dispatch(new ReplaceTransaction(transfer, failedTx));
  };
}

ThunkAction joinCommunityCall({dynamic community, dynamic token}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      String walletAddress = store.state.cashWalletState.walletAddress;
      bool isMember = await graph.isCommunityMember(
          walletAddress, community["entitiesList"]["address"]);
      String communityAddress = community['address'];
      if (isMember) {
        return store.dispatch(new AlreadyJoinedCommunity(communityAddress));
      }

      dynamic response =
          await api.joinCommunity(web3, walletAddress, communityAddress);

      dynamic jobId = response['job']['_id'];
      Transfer transfer = new Transfer(
          type: 'RECEIVE',
          text: 'Joining ' + community["name"] + ' community',
          status: 'PENDING',
          jobId: jobId);

      store.dispatch(new AddTransaction(transfer));

      response['job']['arguments'] = {
        'transfer': transfer,
        'community': community
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
    } catch (e) {
      logger.severe('ERROR - joinCommunityCall $e');
      store.dispatch(new ErrorAction('Could not join community'));
    }
  };
}

ThunkAction joinCommunitySuccessCall(Job job, dynamic fetchedData, Transfer transfer, dynamic community) {
  return (Store store) async {
      Transfer confirmedTx = transfer.copyWith(
      status: 'CONFIRMED',
      text: 'Joined ' + (community["name"]) + ' community',
      txHash: job.data['txHash']);
    store.dispatch(new AlreadyJoinedCommunity(community['address']));
    store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community communityData = store.state.cashWalletState.communities[communityAddres];
    if (communityData.plugins.joinBonus != null && communityData.plugins.joinBonus.isActive) {
      BigInt value = toBigInt(communityData.plugins.joinBonus.amount, communityData.token.decimals);
      String joinBonusJobId = fetchedData['data']['funderJobId'];
      String joinCommunityJobId = fetchedData['_id'];
      Transfer joinBonus = new Transfer(
        from: DotEnv().env['FUNDER_ADDRESS'],
        type: 'RECEIVE',
        value: value,
        text: 'You got a join bonus!',
        status: 'PENDING',
        jobId: joinBonusJobId ?? joinCommunityJobId);
      store.dispatch(new AddTransaction(joinBonus));
      Map response = Map.from({
        'job': {
          'id': joinBonusJobId ?? joinCommunityJobId,
          'isFunderJob': joinBonusJobId != null,
          'jobType': 'joinBonus',
          'arguments': {
            'joinBonus': joinBonus
          }
        }
      });
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
    }
  };
}

ThunkAction joinBonusSuccessCall(txHash, transfer) {
  return (Store store) async {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community communityData = store.state.cashWalletState.communities[communityAddres];
    Transfer confirmedTx = transfer.copyWith(status: 'CONFIRMED', txHash: txHash);
    store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
    store.dispatch(segmentIdentifyCall(
      new Map<String, dynamic>.from({
        "Join Bonus ${communityData.name} Received": true,
        "Community ${communityData.name} Joined": true,
      })
    ));
    store.dispatch(segmentTrackCall("Wallet: user got a join bonus",
        properties: new Map<String, dynamic>.from({
          "Community Name": communityData.name,
          "Bonus amount": communityData.plugins.joinBonus.amount,
        })));
  };
}

ThunkAction fetchCommunityMetadataCall(String communityURI) {
  return (Store store) async {
    String uri = communityURI.split('://')[1];
    dynamic metadata = await api.fetchMetadata(uri);
    CommunityMetadata communityMetadata = new CommunityMetadata(
      image: metadata['image'],
      coverPhoto: metadata['coverPhoto'],
      isDefaultImage: metadata['isDefault'] != null ? metadata['isDefault'] : false
    );
    store.dispatch(FetchCommunityMetadataSuccess(communityMetadata));
  };
}

ThunkAction switchToNewCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      store.dispatch(new SwitchToNewCommunity(communityAddress));
      dynamic community = await graph.getCommunityByAddress(communityAddress);
      logger.info('community fetched for $communityAddress');
      dynamic token = await graph.getTokenOfCommunity(communityAddress);
      logger.info('token ${token["address"]} (${token["symbol"]}) fetched for $communityAddress');
      bool isRopsten = token != null && token['originNetwork'] == 'ropsten';
      String walletAddress = store.state.cashWalletState.walletAddress;
      Map<String, dynamic> communityData = await api.getCommunityData(communityAddress, isRopsten: isRopsten, walletAddress: walletAddress);
      store.dispatch(fetchCommunityMetadataCall(communityData['communityURI']));
      Plugins communityPlugins = Plugins.fromJson(communityData['plugins']);
      store.dispatch(joinCommunityCall(community: community, token: token));
      store.dispatch(getBusinessListCall());
      String homeBridgeAddress = communityData['homeBridgeAddress'];
      String foreignBridgeAddress = communityData['foreignBridgeAddress'];
      store.dispatch(new SwitchCommunitySuccess(
          communityAddress: communityAddress,
          communityName: community["name"],
          token: new Token(
              originNetwork: token['originNetwork'],
              address: token["address"],
              name: token["name"],
              symbol: token["symbol"],
              decimals: token["decimals"]),
          transactions: new Transactions(),
          plugins: communityPlugins,
          isClosed: communityData['isClosed'],
          homeBridgeAddress: homeBridgeAddress,
          foreignBridgeAddress: foreignBridgeAddress
          ));
      store.dispatch(segmentTrackCall("Wallet: Switch Community",
          properties: new Map<String, dynamic>.from({
            "Community Name": community["name"],
            "Community Address": communityAddress,
            "Token Address": token["address"],
            "Token Symbol": token["symbol"],
            "Origin Network": token['originNetwork']
          })));
    } catch (e, s) {
      logger.info('ERROR - switchToNewCommunityCall $e');
      await AppFactory().reportError(e, s);
      store.dispatch(new ErrorAction('Could not switch community'));
      store.dispatch(new SwitchCommunityFailed());
    }
  };
}

ThunkAction switchToExisitingCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      store.dispatch(new SwitchCommunityRequested(communityAddress));
      Community current = store.state.cashWalletState.communities[communityAddress.toLowerCase()];
      bool isRopsten = current.token != null && current.token.originNetwork == 'ropsten';
      String walletAddress = store.state.cashWalletState.walletAddress;
      Map<String, dynamic> communityData = await api.getCommunityData(communityAddress, isRopsten: isRopsten, walletAddress: walletAddress);
      Plugins communityPlugins = Plugins.fromJson(communityData['plugins']);
      store.dispatch(getBusinessListCall());
      String homeBridgeAddress = communityData['homeBridgeAddress'];
      String foreignBridgeAddress = communityData['foreignBridgeAddress'];
      store.dispatch(new SwitchCommunitySuccess(
          communityAddress: communityAddress,
          communityName: current.name,
          token: current.token,
          transactions: current.transactions,
          plugins: communityPlugins,
          isClosed: current.isClosed,
          homeBridgeAddress: homeBridgeAddress,
          foreignBridgeAddress: foreignBridgeAddress
          ));
    } catch (e, s) {
      logger.info('ERROR - switchToExisitingCommunityCall $e');
      await AppFactory().reportError(e, s);
      store.dispatch(new ErrorAction('Could not switch community'));
      store.dispatch(new SwitchCommunityFailed());
    }
  };
}

ThunkAction switchCommunityCall(String communityAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      bool isLoading = store.state.cashWalletState.isCommunityLoading ?? false;
      if (isLoading) return;
      Community current = store.state.cashWalletState.communities[communityAddress.toLowerCase()];
      if (current != null && current.name != null && current.token != null) {
        store.dispatch(switchToExisitingCommunityCall(communityAddress));
      } else {
        store.dispatch(switchToNewCommunityCall(communityAddress));
      }
    } catch (e, s) {
      logger.info('ERROR - switchCommunityCall $e');
      await AppFactory().reportError(e, s);
      store.dispatch(new ErrorAction('Could not switch community'));
      store.dispatch(new SwitchCommunityFailed());
    }
  };
}

Map<String, dynamic> _responseHandler(Response response) {
  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> obj = json.decode(response.body);
      return obj;
      break;
    default:
      throw 'Error! status: ${response.statusCode}, reason: ${response.reasonPhrase}';
  }
}

ThunkAction getBusinessListCall() {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String communityAddress = store.state.cashWalletState.communityAddress;
      store.dispatch(StartFetchingBusinessList());
      if (isPaywise(communityAddress)) {
        Client client = new Client();
        dynamic res = await client.get('https://api.airtable.com/v0/appVQfuM5SRKAGF1c/Table%201', headers: {"Authorization": "Bearer keywI4WPG7mJVm2XU"});
        dynamic a = _responseHandler(res);
        List<Business> businessList = new List();
        await Future.forEach(a['records'], (record) {
          if (record['fields'].containsKey('name') && record['fields'].containsKey('account')) {
            dynamic data = record['fields'];
            Map<String, dynamic> business = Map.from({
              'name': data['name'] ?? '',
              'account': data['account'] ?? '',
              'metadata': {
                'image': data['image'][0]['url'] ?? '',
                "coverPhoto": data['coverPhoto'][0]['url'] ?? '',
                'address': data['address'] ?? '',
                'description': data['description'] ?? '',
                'phoneNumber': data['phoneNumber'] ?? '',
                'website': data['website'] ?? '',
                'type': data['type'] ?? '',
                'address': data['address'] ?? '',
                'latLng': data['GPS'] != null ? data['GPS'].split(',').toList().map((item) => double.parse(item.trim())).toList() : null
              }
            });
            businessList.add(new Business.fromJson(business));
          }
        }).then((r) {
          store.dispatch(new GetBusinessListSuccess(businessList));
          store.dispatch(FetchingBusinessListSuccess());
        });
      } else if (isPeso(communityAddress)) {
        Client client = new Client();
        dynamic res = await client.get('https://api.airtable.com/v0/applg6xomn2EIirM0/Table%201', headers: {"Authorization": "Bearer keywI4WPG7mJVm2XU"});
        dynamic a = _responseHandler(res);
        List<Business> businessList = new List();
        await Future.forEach(a['records'], (record) {
          if (record['fields'].containsKey('name') && record['fields'].containsKey('account')) {
            dynamic data = record['fields'];
            Map<String, dynamic> business = Map.from({
              'name': data['name'] ?? '',
              'account': data['account'] ?? '',
              'metadata': {
                'image': data['image'][0]['url'] ?? '',
                "coverPhoto": data['coverPhoto'][0]['url'] ?? '',
                'address': data['address'] ?? '',
                'description': data['description'] ?? '',
                'phoneNumber': data['phoneNumber'] ?? '',
                'website': data['website'] ?? '',
                'type': data['type'] ?? '',
                'address': data['address'] ?? '',
                'latLng': data['GPS'] != null ? data['GPS'].split(',').toList().map((item) => double.parse(item.trim())).toList() : null
              }
            });
            businessList.add(new Business.fromJson(business));
          }
        }).then((r) {
          store.dispatch(new GetBusinessListSuccess(businessList));
          store.dispatch(FetchingBusinessListSuccess());
        });
      } else {
        Community community = store.state.cashWalletState.communities[communityAddress];
        bool isOriginRopsten = community.token?.originNetwork != null
            ? community.token?.originNetwork == 'ropsten'
            : false;
        dynamic communityEntities = await graph.getCommunityBusinesses(communityAddress);
        List<Business> businessList = new List();
        await Future.forEach(communityEntities, (entity) async {
          dynamic metadata = await api.getEntityMetadata(communityAddress, entity['address'], isRopsten: isOriginRopsten);
          entity['name'] = metadata['name'];
          entity['metadata'] = metadata;
          entity['account'] = entity['address'];
          businessList.add(new Business.fromJson(entity));
        }).then((r) {
          store.dispatch(new GetBusinessListSuccess(businessList));
          store.dispatch(FetchingBusinessListSuccess());
        });
      }
    } catch (e) {
      logger.severe('ERROR - getBusinessListCall $e');
      store.dispatch(FetchingBusinessListFailed());
      store.dispatch(new ErrorAction('Could not get businesses list'));
    }
  };
}

ThunkAction getTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      bool isLoading = store.state.cashWalletState.isCommunityLoading ?? false;
      if (isLoading) return;
      if (web3 == null) {
        throw "Web3 is empty";
      }
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community = store.state.cashWalletState.communities[communityAddres];
      num lastBlockNumber = community.transactions.blockNumber;
      num currentBlockNumber = await web3.getBlockNumber();
      Map<String, dynamic> response = await graph.getTransfers(
          walletAddress, tokenAddress,
          fromBlockNumber: lastBlockNumber, toBlockNumber: currentBlockNumber);
      List<Transfer> transfers = List<Transfer>.from(
          response["data"].map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(new GetTokenTransfersListSuccess(transfers));
    } catch (e) {
      logger.severe('ERROR - getTokenTransfersListCall $e');
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction getReceivedTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      String walletAddress = store.state.cashWalletState.walletAddress;
      num lastBlockNumber = community.transactions.blockNumber;
      num currentBlockNumber =
          await store.state.cashWalletState.web3.getBlockNumber();
      Map<String, dynamic> response = await graph.getReceivedTransfers(
          walletAddress, tokenAddress,
          fromBlockNumber: lastBlockNumber, toBlockNumber: currentBlockNumber);
      List<Transfer> transfers = List<Transfer>.from(
          response["data"].map((json) => Transfer.fromJson(json)).toList());
      if (transfers.isNotEmpty) {
        store.dispatch(new GetTokenTransfersListSuccess(transfers));
        store.dispatch(getTokenBalanceCall(tokenAddress));
      }
    } catch (e) {
      logger.severe('ERROR - getReceivedTokenTransfersListCall $e');
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction sendTokenToContactCall(String name, String contactPhoneNumber, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback,
    {String receiverName, String transferNote}) {
  return (Store store) async {
    final logger = await AppFactory().getLogger('action');
    try {
      logger.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      logger.info("wallet $wallet");
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      logger.info("walletAddress $walletAddress");
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(
          name,
          contactPhoneNumber,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
          receiverName: receiverName
        ));
        return;
      }
      store.dispatch(sendTokenCall(
          walletAddress, tokensAmount, sendSuccessCallback, sendFailureCallback,
          receiverName: receiverName, transferNote: transferNote));
    } catch (e) {
      logger.severe('ERROR - sendTokenToContactCall $e');
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}

ThunkAction transferDaiPointsToForiegnNetwork() {
  return (Store store) async {
    String communityAddres = DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'].toLowerCase();
    Community community = store.state.cashWalletState.communities[communityAddres];
    String receiverAddress = community.homeBridgeAddress;
    num tokensAmount = num.parse(formatValue(community.tokenBalance, community.token.decimals));

    VoidCallback sendSuccessCallback = () {
      store.dispatch(startListenToTransferEvents());
    };

    VoidCallback sendFailureCallback = () { };

    store.dispatch(sendTokenCall(receiverAddress, tokensAmount, sendSuccessCallback, sendFailureCallback));
  };
}