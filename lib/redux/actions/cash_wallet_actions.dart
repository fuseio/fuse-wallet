import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/plugins.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/models/job.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:flutter_branch_io_plugin/flutter_branch_io_plugin.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'dart:io';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:fusecash/services.dart';
import 'package:fusecash/models/token.dart';
import 'dart:async';
import 'dart:convert';
import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:flutter_android_lifecycle/flutter_android_lifecycle.dart';

// class DualOutput extends LogOutput {

//   File file;
//   DualOutput() {
//     file = null;
//   }

//   Future<File> getFile() async {
//     final directory = await getApplicationDocumentsDirectory();
//     return File(directory.path+"/logs.txt");
//   }

//   @override
//   void output(OutputEvent event) async {
//     if (file == null) {
//       file = await getFile();
//     }
//     for (var line in event.lines) {
//       print(line);
// //      await file.writeAsString(line + '\n', mode: FileMode.append);
//     }
//   }
// }

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
  final Token token;
  final String communityAddress;
  final String communityName;
  final Transactions transactions;
  final Plugins plugins;
  SwitchCommunitySuccess(this.communityAddress, this.communityName, this.token,
      this.transactions, this.plugins);
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

Future<bool> approvalCallback() async {
  return true;
}

ThunkAction segmentTrackCall(evantName, {Map<String, dynamic> properties}) {
  return (Store store) async {
    await FlutterSegment.track(eventName: evantName, properties: properties);
  };
}

ThunkAction segmentIdentifyCall(userId, {Map<String, dynamic> traits}) {
  return (Store store) async {
    await FlutterSegment.identify(userId: userId, traits: traits);
  };
}

ThunkAction listenToBranchCall() {
  return (Store store) async {
    logger.wtf("branch listening.");
    store.dispatch(BranchListening());

    FlutterAndroidLifecycle.listenToOnStartStream().listen((stringData) {
      logger.wtf("ONSTART");
      logger.wtf("Listen To On Start Stream Branch.io");
      FlutterBranchIoPlugin.setupBranchIO();
      logger.wtf("stringData $stringData");
    }, onDone: () {
      store.dispatch(listenToBranchCall());
    }, onError: (error) {
      logger.wtf("error, $error");
      store.dispatch(listenToBranchCall());
    });

    await Future.delayed(Duration(microseconds: 500), () {
      FlutterBranchIoPlugin.listenToDeepLinkStream().listen((stringData) async {
        var linkData = jsonDecode(stringData);
        logger.wtf("Listen To On Deep Link Stream Branch.io");
        logger.wtf("linkData $linkData");

        if (linkData["~feature"] == "switch_community") {
          var communityAddress = linkData["community_address"];
          logger.wtf("communityAddress $communityAddress");
          store.dispatch(BranchCommunityToUpdate(communityAddress));
          store.dispatch(segmentTrackCall("Branch Switch Community",
              properties: new Map<String, dynamic>.from(linkData)));
        }
        if (linkData["~feature"] == "invite_user") {
          var communityAddress = linkData["community_address"];
          logger.wtf("community_address $communityAddress");
          store.dispatch(BranchCommunityToUpdate(communityAddress));
          store.dispatch(segmentTrackCall("Branch Invite User",
              properties: new Map<String, dynamic>.from(linkData)));
        }
      }, onDone: () {
        logger.wtf("ondone");
        store.dispatch(listenToBranchCall());
      }, onError: (error) {
        logger.wtf("error, $error");
        store.dispatch(listenToBranchCall());
      });
    });

    FlutterAndroidLifecycle.listenToOnResumeStream().listen((stringData) async {
      logger.wtf("Listen To On Resume Stream Branch.io");
      logger.wtf("stringData $stringData");
    }, onDone: () {
      logger.wtf("ondone");
      store.dispatch(listenToBranchCall());
    }, onError: (error) {
      logger.wtf("error, $error");
      store.dispatch(listenToBranchCall());
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
    Community community = store.state.cashWalletState.communities[communityAddres];
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
      Community community = store.state.cashWalletState.communities[communityAddres];
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
    Community community = store.state.cashWalletState.communities[communityAddres];
    String tokenAddress = community.token?.address;
    if (tokenAddress != null) {
      store.dispatch(getTokenTransfersListCall(tokenAddress));
    }
    new Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (store.state.cashWalletState.walletAddress == '') {
        t.cancel();
        return;
      }
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community = store.state.cashWalletState.communities[communityAddres];
      String tokenAddress = community.token?.address;
      if (tokenAddress != null) {
        store.dispatch(getRecivedTokenTransfersListCall(tokenAddress));
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
      await api.createWallet();
      store.dispatch(new CreateAccountWalletSuccess(accountAddress));
      new Timer.periodic(Duration(seconds: 5), (Timer t) async {
        dynamic wallet = await api.getWallet();
        String walletAddress = wallet["walletAddress"];
        if (walletAddress != null && walletAddress.isNotEmpty) {
          store.dispatch(new GetWalletAddressSuccess(walletAddress));
          store.dispatch(segmentIdentifyCall(walletAddress,
              traits: new Map<String, dynamic>.from({
                "walletAddress": walletAddress,
                "accountAddress": accountAddress,
                "displatName": store.state.userState.displayName
              })));
          store.dispatch(segmentTrackCall('Wallet Generated'));
          store.dispatch(create3boxAccountCall(accountAddress));
          t.cancel();
        }
      });
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not create wallet'));
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

ThunkAction fetchJobCall(String jobId, Function(Job) fetchSuccessCallback, {Timer timer, bool untilDone}) {
  return (Store store) async {
    try {
      dynamic response = await api.getJob(jobId);
      Job job = Job.fromJson(response);
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
      // switch (job.name) {
      //   case Job.RELAY:
      //     {
      //       String walletModule = job.data["walletModule"];
      //       logger.wtf("walletModule: $walletModule");
      //       switch (walletModule) {
      //         case Job.COMMUNITY_MANAGER:
      //           {
      //             // TODO nothing.
      //             break;
      //           }
      //         case Job.TRANSFER_MANAGER:
      //           {
      //             logger.wtf("dispatching");
      //             store.dispatch(new TransferJobSuccess(job));
      //             break;
      //           }
      //         default:
      //           {
      //             //statements;
      //           }
      //           break;
      //       }
      //       break;
      //     }
      //   case Job.CREATE_WALLET:
      //     {
      //       store.dispatch(callSendToInviteCall(job));
      //       break;
      //     }
      //   default:
      //     {}
      //     break;
      // }
      if (timer != null) {
        timer.cancel();
      }
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get job'));
    }
  };
}

ThunkAction startFetchingJobCall(String jobId, Function(Job) fetchSuccessCallback, {bool untilDone: true}) {
  return (Store store) async {
    new Timer.periodic(Duration(seconds: 3), (Timer timer) async {
      store.dispatch(fetchJobCall(jobId, fetchSuccessCallback,
          timer: timer, untilDone: untilDone));
    });
  };
}

ThunkAction inviteAndSendCall(String contactPhoneNumber, num tokensAmount, VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
  return (Store store) async {
    dynamic response = await api.invite(
        contactPhoneNumber, store.state.cashWalletState.communityAddress);
    logger.wtf("response $response");
    String jobId = response['job']['_id'].toString();
    store.dispatch(startFetchingJobCall(jobId, (Job job) {
      String receiverAddress = job.data["walletAddress"];
      store.dispatch(sendTokenCall(receiverAddress, tokensAmount,
          sendSuccessCallback, sendFailureCallback));
      store.dispatch(syncContactsCall(store.state.userState.contacts));
    }, untilDone: true));
  };
}

ThunkAction sendTokenCall(String receiverAddress, num tokensAmount, VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
  return (Store store) async {
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community = store.state.cashWalletState.communities[communityAddres];
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
          status: 'PENDING',
          jobId: jobId);

      store.dispatch(new AddTransaction(transfer));

      store.dispatch(startFetchingJobCall(jobId, (job) {
        Transfer confirmedTx =
            transfer.copyWith(status: 'CONFIRMED', txHash: job.data['txHash']);
        store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
      }));
    } catch (e) {
      logger.e(e);
      sendFailureCallback();
      store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction sendToInviteCall(String receiverAddress, num tokensAmount, Transfer inviteWithJobId) {
  return (Store store) async {
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      String communityAddres = store.state.cashWalletState.communityAddress;
      Community community = store.state.cashWalletState.communities[communityAddres];
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

// ThunkAction callSendToInviteCall(Job job) {
//   return (Store store) async {
//     Map<String, num> sendToInvites = store.state.cashWalletState.sendToInvites;
//     store.dispatch(sendTokenCall(job.data["walletAddress"], sendToInvites[job.id]));
//     store.dispatch(RemoveSendToInvites(job.id));
//   };
// }

ThunkAction joinCommunityCall({dynamic community, dynamic token}) {
  return (Store store) async {
    try {
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      bool isMember = await graph.isCommunityMember(
          walletAddress, community["entitiesList"]["address"]);
      String communityAddress = community['address'];
      if (isMember) {
        // Transfer joined = new Transfer(
        //     type: 'RECEIVE',
        //     text: 'Joined community',
        //     status: 'CONFIRMED',
        //     jobId: 'joined',
        //     txHash: '');
        // store.dispatch(new AddTransaction(joined));
        return store.dispatch(new AlreadyJoinedCommunity(communityAddress));
      }

      dynamic response =
          await api.joinCommunity(web3, walletAddress, communityAddress);
      dynamic jobId = response['job']['_id'];
      Transfer transfer = new Transfer(
          type: 'RECEIVE',
          text: 'Joining community',
          status: 'PENDING',
          jobId: jobId);

      store.dispatch(new AddTransaction(transfer));

      store.dispatch(startFetchingJobCall(jobId, (job) {
        Transfer confirmedTx = transfer.copyWith(
            status: 'CONFIRMED',
            text: 'Joined community',
            txHash: job.data['txHash']);
        store.dispatch(new ReplaceTransaction(transfer, confirmedTx));
      }));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not join community'));
    }
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
      store.dispatch(joinCommunityCall(community: community, token: token));
      Map<String, dynamic> communityData =
          await api.getCommunityData(communityAddress);
      Plugins communityPlugins;
      if (communityData != null) {
        Map<String, dynamic> plugins = Map<String, dynamic>.from(
            communityData.containsKey('plugins')
                ? communityData['plugins']
                : {});
        if (plugins.containsKey('onramp')) {
          Map<String, dynamic> onramp =
              Map<String, dynamic>.from(plugins['onramp']);
          Map<String, dynamic> services =
              Map<String, dynamic>.from(onramp['services']);
          communityPlugins = Plugins.fromJsonState(services);
        }
      }
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
          communityPlugins));
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

ThunkAction getBusinessListCall() {
  return (Store store) async {
    try {
      store.dispatch(StartFetchingBusinessList());
      dynamic community = await graph
          .getCommunityByAddress(store.state.cashWalletState.communityAddress);
      List<Business> businessList = new List();
      await Future.forEach(community['entitiesList']['communityEntities'], (entity) async {
        if (entity['isBusiness']) {
          String communityAddres = store.state.cashWalletState.communityAddress;
          Community community = store.state.cashWalletState.communities[communityAddres];
          bool isOriginRopsten = community.token?.originNetwork != null ? community.token?.originNetwork == 'ropsten' : false;
          dynamic metadata = await api.getEntityMetadata(
              store.state.cashWalletState.communityAddress, entity['address'], isRopsten: isOriginRopsten);
          entity['name'] = metadata['name'];
          entity['metadata'] = metadata;
          entity['account'] = entity['address'];
          businessList.add(new Business.fromJson(entity));
        }
      }).then((r) {
        store.dispatch(new GetBusinessListSuccess(businessList));
        store.dispatch(FetchingBusinessListSuccess());
      });
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
      num lastBlockNumber = store.state.cashWalletState.transactions.blockNumber;
      num currentBlockNumber = await store.state.cashWalletState.web3.getBlockNumber();
      Map<String, dynamic> response = await graph.getTransfers(
          walletAddress, tokenAddress,
          fromBlockNumber: lastBlockNumber, toBlockNumber: currentBlockNumber);
      List<Transfer> transfers = List<Transfer>.from(response["data"].map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(new GetTokenTransfersListSuccess(transfers));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction getRecivedTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    try {
      if (store.state.cashWalletState.isCommunityLoading) return;
      String walletAddress = store.state.cashWalletState.walletAddress;
      num lastBlockNumber =
          store.state.cashWalletState.transactions.blockNumber;
      num currentBlockNumber =
          await store.state.cashWalletState.web3.getBlockNumber();
      // logger.d(
      //     'fetching token transfers of $tokenAddress for $walletAddress wallet');
      Map<String, dynamic> response = await graph.getReceivedTransfers(
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

ThunkAction sendTokenToContactCall(String contactPhoneNumber, num tokensAmount, VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
  return (Store store) async {
    try {
      logger.i('Trying to send $tokensAmount to phone $contactPhoneNumber');
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      logger.wtf("wallet $wallet");
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      logger.wtf("walletAddress $walletAddress");
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(contactPhoneNumber, tokensAmount,
            sendSuccessCallback, sendFailureCallback));
        return;
      }
      store.dispatch(sendTokenCall(walletAddress, tokensAmount,
          sendSuccessCallback, sendFailureCallback));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not send token to contact'));
    }
  };
}
