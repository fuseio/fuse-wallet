import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/community_metadata.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/models/job.dart';
import 'package:fusecash/models/transactions.dart';
import 'package:fusecash/models/transfer.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/phone.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:fusecash/services.dart';
import 'package:fusecash/models/token.dart';
import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';

void enablePushNotifications() async {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  void iosPermission() {
    var firebaseMessaging2 = firebaseMessaging;
    firebaseMessaging2.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  if (Platform.isIOS) iosPermission();
  var token = await firebaseMessaging.getToken();
  logger.wtf("token $token");
  await FlutterSegment.putDeviceToken(token);
  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      logger.wtf('onMessage called: $message');
    },
    onResume: (Map<String, dynamic> message) async {
      logger.wtf('onResume called: $message');
    },
    onLaunch: (Map<String, dynamic> message) async {
      logger.wtf('onLaunch called: $message');
    },
  );
}

var logger = Logger(printer: PrettyPrinter()
    // output: DualOutput()
    );

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

class GetWalletAddressSuccess {
  final String walletAddress;
  GetWalletAddressSuccess(this.walletAddress);
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

class SwitchCommunitySuccess {
  final bool isClosed;
  final Token token;
  final String communityAddress;
  final String communityName;
  final Transactions transactions;
  final Plugins plugins;
  SwitchCommunitySuccess(this.communityAddress, this.communityName, this.token,
      this.transactions, this.plugins, this.isClosed);
}

class FetchCommunityMetadataSuccess {
  final CommunityMetadata metadata;
  FetchCommunityMetadataSuccess(this.metadata);
}

class SwitchCommunityFailed {}

class GetJoinBonusSuccess {
  // TODO
  GetJoinBonusSuccess();
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

ThunkAction segmentTrackCall(eventName, {Map<String, dynamic> properties}) {
  return (Store store) async {
    await FlutterSegment.track(eventName: eventName, properties: properties);
  };
}

ThunkAction segmentAliasCall(String userId) {
  return (Store store) async {
    await FlutterSegment.alias(alias: userId);
  };
}

ThunkAction segmentIdentifyCall(String userId, Map<String, dynamic> traits) {
  return (Store store) async {
    await FlutterSegment.identify(userId: userId, traits: traits);
  };
}

ThunkAction listenToBranchCall() {
  return (Store store) async {
    logger.wtf("branch listening.");
    store.dispatch(BranchListening());

    Function handler = (linkData) async {
      logger.wtf("Got link data: ${linkData.toString()}");
      if (linkData["~feature"] == "switch_community") {
        var communityAddress = linkData["community_address"];
        logger.wtf("communityAddress $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(segmentTrackCall("Wallet: Branch: Studio Invite", properties: new Map<String, dynamic>.from(linkData)));
      }
      if (linkData["~feature"] == "invite_user") {
        var communityAddress = linkData["community_address"];
        logger.wtf("community_address $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
        store.dispatch(segmentTrackCall("Wallet: Branch: User Invite", properties: new Map<String, dynamic>.from(linkData)));
      }
      store.dispatch(BranchDataReceived());
    };

    FlutterBranchSdk.initSession().listen((data) {
      handler(data);
    }, onError: (error) {
      print(error);
    });
  };
}

ThunkAction initWeb3Call(String privateKey) {
  return (Store store) async {
    try {
      logger.d('initWeb3. privateKey: $privateKey');
      wallet_core.Web3 web3 = new wallet_core.Web3(approvalCallback,
          defaultCommunityAddress:
              DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'],
          communityManagerAddress:
              DotEnv().env['COMMUNITY_MANAGER_CONTRACT_ADDRESS'],
          transferManagerAddress:
              DotEnv().env['TRANSFER_MANAGER_CONTRACT_ADDRESS']);
      if (store.state.cashWalletState.communityAddress == null ||
          store.state.cashWalletState.communityAddress.isEmpty) {
        store.dispatch(SetDefaultCommunity(web3.getDefaultCommunity()));
      }
      web3.setCredentials(privateKey);
      store.dispatch(new InitWeb3Success(web3));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not init web3'));
    }
  };
}

ThunkAction startBalanceFetchingCall() {
  return (Store store) async {
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
    try {
      logger.d('createAccountWalletCall');
      logger.d('accountAddress: $accountAddress');
      store.dispatch(new CreateAccountWalletRequest(accountAddress));
      Map<String, dynamic> response = await api.createWallet();
      if (!response.containsKey('job')) {
        print('Wallet already exists');
        store.dispatch(generateWalletSuccessCall(response, accountAddress));
        return;
      }
      response['job']['arguments'] = {
        'accountAddress': accountAddress
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not create wallet'));
    }
  };
}

ThunkAction generateWalletSuccessCall(dynamic wallet, String accountAddress) {
  return (Store store) async {
    String walletAddress = wallet["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
          store.dispatch(new GetWalletAddressSuccess(walletAddress));
          enablePushNotifications();
          String fullPhoneNumber = formatPhoneNumber(store.state.userState.phoneNumber, store.state.userState.countryCode);
          logger.d('fullPhoneNumber: $fullPhoneNumber');
          store.dispatch(segmentIdentifyCall(
              fullPhoneNumber,
              new Map<String, dynamic>.from({
                "Phone Number": fullPhoneNumber,
                "Wallet Address": walletAddress,
                "Account Address": accountAddress,
                "Display Name": store.state.userState.displayName
              })));
          store.dispatch(segmentTrackCall('Wallet: Wallet Generated'));
          store.dispatch(create3boxAccountCall(accountAddress));
    }
  };
}

ThunkAction getWalletAddressCall() {
  return (Store store) async {
    try {
      dynamic wallet = await api.getWallet();
      String walletAddress = wallet["walletAddress"];
      store.dispatch(new GetWalletAddressSuccess(walletAddress));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get wallet address'));
    }
  };
}

ThunkAction getTokenBalanceCall(String tokenAddress) {
  return (Store store) async {
    try {
      String walletAddress = store.state.cashWalletState.walletAddress;
      // logger.d(
      //     'fetching token balance of $tokenAddress for $walletAddress wallet');
      BigInt tokenBalance =
          await graph.getTokenBalance(walletAddress, tokenAddress);
      store.dispatch(new GetTokenBalanceSuccess(tokenBalance));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get token balance'));
    }
  };
}

ThunkAction fetchJobCall(String jobId, Function(Job) fetchSuccessCallback,
    {Timer timer, bool untilDone}) {
  return (Store store) async {
    try {
      dynamic response = await api.getJob(jobId);
      Job job = JobFactory.create(response);
      logger.wtf("job.name: ${job.name}");
      if (untilDone) {
        if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
          logger.wtf('job not done');
          return;
        }
      } else {
        if (job.data['txHash'] == null) {
          logger.wtf('fetched job with txHash null');
          return;
        }
      }
      fetchSuccessCallback(job);
      if (timer != null) {
        timer.cancel();
      }
    } catch (e) {
      logger.e(e);
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
    String communityAddres = store.state.cashWalletState.communityAddress;
    String walletAddress = store.state.cashWalletState.walletAddress;
    Community community = store.state.cashWalletState.communities[communityAddres];
    List<Job> jobs = community.jobs;
    for (Job job in jobs) {
      String currentCommunityAddress = store.state.cashWalletState.communityAddress;
      String currentWalletAddress = store.state.cashWalletState.walletAddress;
      bool isJobProcessValid() {
        if ((currentCommunityAddress != communityAddres) || (currentWalletAddress != walletAddress)) {
          timer.cancel();
          return false;
        }
        if (job.status == 'DONE') {
          return false;
        }
        return true;
      }
      if (job.status != 'DONE') {
        await job.perform(store, isJobProcessValid);
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
  String contactPhoneNumber,
  num tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
  {String receiverName = ''}
) {
  return (Store store) async {
    dynamic response = await api.invite(
        contactPhoneNumber, store.state.cashWalletState.communityAddress);
    logger.wtf("response $response");
    sendSuccessCallback();
    response['job']['arguments'] = {
      'tokensAmount': tokensAmount,
      'receiverName': receiverName,
      'sendSuccessCallback': () => {},
      'sendFailureCallback': sendFailureCallback
    };
    Job job = JobFactory.create(response['job']);
    store.dispatch(AddJob(job));
    // String jobId = response['job']['_id'].toString();
    // store.dispatch(startFetchingJobCall(jobId, (Job job) {
    //   String receiverAddress = job.data["walletAddress"];
    //   store.dispatch(sendTokenCall(receiverAddress, tokensAmount,
    //       sendSuccessCallback, sendFailureCallback,
    //       receiverName: receiverName));
      // store.dispatch(syncContactsCall(store.state.userState.contacts));
    // }, untilDone: true));
  };
}

ThunkAction inviteAndSendSuccessCall(Job job, tokensAmount, receiverName, sendSuccessCallback, sendFailureCallback) {
  return (Store store) async {
      String receiverAddress = job.data["walletAddress"];
      store.dispatch(sendTokenCall(receiverAddress, tokensAmount,
          sendSuccessCallback, sendFailureCallback,
          receiverName: receiverName));
      store.dispatch(syncContactsCall(store.state.userState.contacts));
  };
}


ThunkAction sendTokenCall(String receiverAddress, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback,
    {String receiverName}) {
  return (Store store) async {
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      Token token = community?.token;
      String tokenAddress = token?.address;

      BigInt value = toBigInt(tokensAmount, token.decimals);

      logger.wtf(
          'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
      dynamic response = await api.tokenTransfer(
          web3, walletAddress, tokenAddress, receiverAddress, tokensAmount);

      dynamic jobId = response['job']['_id'];
      logger.wtf('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();
      Transfer transfer = new Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: tokenAddress,
          value: value,
          type: 'SEND',
          receiverName: receiverName,
          status: 'PENDING',
          jobId: jobId);

      store.dispatch(new AddTransaction(transfer));

      store.dispatch(segmentTrackCall("Wallet: User Transfer", properties: transfer.toJson()));
      response['job']['arguments'] = {
        'transfer': transfer
      };
      Job job = JobFactory.create(response['job']);
      store.dispatch(AddJob(job));
    } catch (e) {
      logger.e(e);
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

ThunkAction sendToInviteCall(String receiverAddress, num tokensAmount, Transfer inviteWithJobId) {
  return (Store store) async {
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      Token token = community.token;
      String tokenAddress = token.address;

      BigInt value = toBigInt(tokensAmount, token.decimals);

      logger.wtf(
          'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
      dynamic response = await api.tokenTransfer(
          web3, walletAddress, tokenAddress, receiverAddress, tokensAmount);

      dynamic jobId = response['job']['_id'];
      logger.wtf('Job $jobId for sending token sent to the relay service');

      store.dispatch(startFetchingJobCall(jobId, (job) {
        store.dispatch(new TransferJobSuccess(job));
        Transfer confirmedTx = inviteWithJobId.copyWith(
            status: 'CONFIRMED', txHash: job.data['txHash']);
        store.dispatch(new ReplaceTransaction(inviteWithJobId, confirmedTx));
      }));

      Transfer transfer = new Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: tokenAddress,
          value: value,
          type: 'SEND',
          status: 'PENDING',
          jobId: jobId);
      store.dispatch(new ReplaceTransaction(inviteWithJobId, transfer));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction joinCommunityCall({dynamic community, dynamic token}) {
  return (Store store) async {
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
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
      logger.e(e);
      store.dispatch(new ErrorAction('Could not join community'));
    }
  };
}

ThunkAction joinCommunitySuccessCall(Job job, Transfer transfer, dynamic community) {
  return (Store store) async {
      Transfer confirmedTx = transfer.copyWith(
      status: 'CONFIRMED',
      text: 'Joined ' + (community["name"]) + ' community',
      txHash: job.data['txHash']);
    store.dispatch(new ReplaceTransaction(transfer, confirmedTx));


    String communityAddres = store.state.cashWalletState.communityAddress;
    Community communityData =
      store.state.cashWalletState.communities[communityAddres];
    if (communityData.plugins.joinBonus != null && communityData.plugins.joinBonus.isActive) {
      BigInt value = toBigInt(communityData.plugins.joinBonus.amount, communityData.token.decimals);
      Transfer joinBonus = new Transfer(
        from: DotEnv().env['FUNDER_ADDRESS'],
        type: 'RECEIVE',
        value: value,
        status: 'PENDING');
      store.dispatch(segmentTrackCall("Wallet: user got a join bonus",
        properties: new Map<String, dynamic>.from({
          "Community Name": community["name"],
          "Bonus amount": communityData.plugins.joinBonus.amount,
        })));
      store.dispatch(new AddTransaction(joinBonus));
    }
  };
}

ThunkAction fetchCommunityMetadataCall(String communityURI) {
  return (Store store) async {
    String uri = communityURI.split('://')[1];
    dynamic metadata = await api.fetchMetadata(uri);
    CommunityMetadata communityMetadata = new CommunityMetadata(image: metadata['image'], coverPhoto: metadata['coverPhoto']);
    store.dispatch(FetchCommunityMetadataSuccess(communityMetadata));
  };
}

ThunkAction switchCommunityCall(String communityAddress) {
  return (Store store) async {
    try {
      store.dispatch(new SwitchCommunityRequested(communityAddress));
      dynamic community = await graph.getCommunityByAddress(communityAddress);
      logger.d('community fetched for $communityAddress');
      dynamic token = await graph.getTokenOfCommunity(communityAddress);
      logger.d(
          'token ${token["address"]} (${token["symbol"]}) fetched for $communityAddress');
      bool isRopsten = token != null && token['originNetwork'] == 'ropsten';
      Map<String, dynamic> communityData =
          await api.getCommunityData(communityAddress, isRopsten: isRopsten);
      store.dispatch(fetchCommunityMetadataCall(communityData['communityURI']));
      Plugins communityPlugins = Plugins.fromJson(communityData['plugins']);
      store.dispatch(joinCommunityCall(community: community, token: token));
      store.dispatch(segmentTrackCall("Wallet: Switch Community",
          properties: new Map<String, dynamic>.from({
            "Community Name": community["name"],
            "Community Address": communityAddress,
            "Token Address": token["address"],
            "Token Symbol": token["symbol"],
            "Origin Network": token['originNetwork']
          })));
      store.dispatch(getBusinessListCall());
      store.dispatch(new SwitchCommunitySuccess(
          communityAddress,
          community["name"],
          new Token(
              originNetwork: token['originNetwork'],
              address: token["address"],
              name: token["name"],
              symbol: token["symbol"],
              decimals: token["decimals"]),
          new Transactions(),
          communityPlugins,
          communityData['isClosed']
          ));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not switch community'));
      store.dispatch(new SwitchCommunityFailed());
    }
  };
}

ThunkAction getJoinBonusCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get join bonus'));
    }
  };
}

Map<String, dynamic> _responseHandler(Response response) {
  print('response: ${response.statusCode}, ${response.reasonPhrase}');
  switch (response.statusCode) {
    case 200:
      Map<String, dynamic> obj = json.decode(response.body);
      return obj;
    case 401:
      throw 'Error! Unauthorized';
      break;
    default:
      throw 'Error! status: ${response.statusCode}, reason: ${response.reasonPhrase}';
  }
}

ThunkAction getBusinessListCall() {
  return (Store store) async {
    try {
      store.dispatch(StartFetchingBusinessList());
      if (isPaywise(store.state.cashWalletState.communityAddress)) {
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
      } else {
        dynamic community = await graph
            .getCommunityByAddress(store.state.cashWalletState.communityAddress);
        List<Business> businessList = new List();
        await Future.forEach(community['entitiesList']['communityEntities'],
            (entity) async {
          if (entity['isBusiness']) {
            String communityAddres = store.state.cashWalletState.communityAddress;
            Community community =
                store.state.cashWalletState.communities[communityAddres];
            bool isOriginRopsten = community.token?.originNetwork != null
                ? community.token?.originNetwork == 'ropsten'
                : false;
            dynamic metadata = await api.getEntityMetadata(
                store.state.cashWalletState.communityAddress, entity['address'],
                isRopsten: isOriginRopsten);
            entity['name'] = metadata['name'];
            entity['metadata'] = metadata;
            entity['account'] = entity['address'];
            businessList.add(new Business.fromJson(entity));
          }
        }).then((r) {
          store.dispatch(new GetBusinessListSuccess(businessList));
          store.dispatch(FetchingBusinessListSuccess());
        });
      }

    } catch (e) {
      logger.e(e);
      store.dispatch(FetchingBusinessListFailed());
      store.dispatch(new ErrorAction('Could not get businesses list'));
    }
  };
}

ThunkAction getTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    try {
      if (store.state.cashWalletState.isCommunityLoading) return;
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community =
          store.state.cashWalletState.communities[communityAddres];
      num lastBlockNumber = community.transactions.blockNumber;
      num currentBlockNumber =
          await store.state.cashWalletState.web3.getBlockNumber();
      Map<String, dynamic> response = await graph.getTransfers(
          walletAddress, tokenAddress,
          fromBlockNumber: lastBlockNumber, toBlockNumber: currentBlockNumber);
      List<Transfer> transfers = List<Transfer>.from(
          response["data"].map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(new GetTokenTransfersListSuccess(transfers));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction getReceivedTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    try {
      if (store.state.cashWalletState.isCommunityLoading) return;
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
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction sendTokenToContactCall(String contactPhoneNumber, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback,
    {String receiverName}) {
  return (Store store) async {
    try {
      logger.i('Trying to send $tokensAmount to phone $contactPhoneNumber');
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      logger.wtf("wallet $wallet");
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      logger.wtf("walletAddress $walletAddress");
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(contactPhoneNumber, tokensAmount,
            sendSuccessCallback, sendFailureCallback,
            receiverName: receiverName));
        return;
      }
      store.dispatch(sendTokenCall(
          walletAddress, tokensAmount, sendSuccessCallback, sendFailureCallback,
          receiverName: receiverName));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}
