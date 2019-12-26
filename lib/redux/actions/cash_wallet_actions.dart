import 'package:flutter/material.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/models/job.dart';
import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:flutter_branch_io_plugin/flutter_branch_io_plugin.dart';
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
  final String communityName;
  final Token token;
  AlreadyJoinedCommunity(this.communityAddress, this.communityName, this.token);
}

class SwitchCommunityRequested {
  final String communityAddress;
  SwitchCommunityRequested(this.communityAddress);
}

class SwitchCommunitySuccess {
  final Token token;
  final String communityAddress;
  final String communityName;
  SwitchCommunitySuccess(this.communityAddress, this.communityName, this.token);
}

class SwitchCommunityFailed {}

class GetJoinBonusSuccess {
  // TODO
  GetJoinBonusSuccess();
}

class GetBusinessListSuccess {
  // TODO
  GetBusinessListSuccess();
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

class BusinessesLoadedAction {
  final List<Business> businessList;

  BusinessesLoadedAction(this.businessList);
}

class InviteSendSuccess {
  final Transaction invite;
  InviteSendSuccess(this.invite);
}


class ReplaceTransfer {
  final Transaction transfer;
  final Transaction nTransfer;
  ReplaceTransfer(this.transfer, this.nTransfer);
}

Future<bool> approvalCallback() async {
  return true;
}

ThunkAction listenToBranchCall() {
  return (Store store) async {
    logger.wtf("branch listening.");
    FlutterBranchIoPlugin.listenToDeepLinkStream().listen((stringData) {
      var linkData = jsonDecode(stringData);
      logger.wtf("linkData $linkData");
      if (linkData["~feature"] == "switch_community") {
        var communityAddress = linkData["community_id"];
        logger.wtf("communityAddress $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
      }
      if (linkData["~feature"] == "invite_user") {
        var communityAddress = linkData["community_address"];
        logger.wtf("community_address $communityAddress");
        store.dispatch(BranchCommunityToUpdate(communityAddress));
      }
    }, onDone: () {
      logger.wtf("ondone");
      store.dispatch(listenToBranchCall());
    }, onError: (error) {
      logger.wtf("error, $error");
      store.dispatch(listenToBranchCall());
    });

    if (Platform.isAndroid) {
      FlutterAndroidLifecycle.listenToOnStartStream().listen((string) {
        logger.d("ONSTART");
        FlutterBranchIoPlugin.setupBranchIO();
      });
    }

    store.dispatch(BranchListening());
  };
}

ThunkAction initWeb3Call(String privateKey) {
  return (Store store) async {
    try {
      logger.d('initWeb3. privateKey: $privateKey');
      wallet_core.Web3 web3 = new wallet_core.Web3(approvalCallback);
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
    String tokenAddress = store.state.cashWalletState.token?.address;
    if (tokenAddress != null) {
      store.dispatch(getTokenBalanceCall(tokenAddress));
    }
    new Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (store.state.cashWalletState.walletAddress == '') {
        t.cancel();
        return;
      }
      String tokenAddress = store.state.cashWalletState.token?.address;

      if (tokenAddress != null) {
        store.dispatch(getTokenBalanceCall(tokenAddress));
      }
    });
    store.dispatch(new StartBalanceFetchingSuccess());
  };
}

ThunkAction startTransfersFetchingCall() {
  return (Store store) async {
    String tokenAddress = store.state.cashWalletState.token?.address;
    if (tokenAddress != null) {
      store.dispatch(getTokenTransfersListCall(tokenAddress));
    }
    new Timer.periodic(Duration(seconds: 3), (Timer t) async {
      if (store.state.cashWalletState.walletAddress == '') {
        t.cancel();
        return;
      }
      String tokenAddress = store.state.cashWalletState.token?.address;
      if (tokenAddress != null) {
        store.dispatch(getTokenTransfersListCall(tokenAddress));
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

ThunkAction fetchJobCall(String jobId, Function(Job) fetchSuccessCallback,
    {Timer timer, bool untilDone}) {
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

ThunkAction startFetchingJobCall(String jobId, Function(Job) fetchSuccessCallback, {bool untilDone: false }) {
  return (Store store) async {
    new Timer.periodic(Duration(seconds: 3), (Timer timer) async {
      store.dispatch(fetchJobCall(jobId, fetchSuccessCallback, timer: timer, untilDone: untilDone));
    });
  };
}

ThunkAction inviteAndSendCall(String contactPhoneNumber, num tokensAmount, VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
  return (Store store) async {
    Token token = store.state.cashWalletState.token;
    dynamic response = await api.invite(
        contactPhoneNumber, store.state.cashWalletState.communityAddress);
    logger.wtf("response $response");
    sendSuccessCallback();
    String jobId = response['job']['_id'].toString();

    BigInt value = toBigInt(tokensAmount, token.decimals);
    Transfer invite = new Transfer(
      text: contactPhoneNumber,
      status: 'PENDING',
      value: value,
      type: 'SEND'
    );

    store.dispatch(TransferSendSuccess(invite));
    // store.dispatch(new TransferSendSuccess(invite));

    // store.dispatch(AddSendToInvites(jobId, tokensAmount));
    store.dispatch(startFetchingJobCall(jobId, (Job job) {
      String receiverAddress = job.data["walletAddress"];
      Transfer inviteWithJobId = new Transfer(
        text: contactPhoneNumber,
        status: 'PENDING',
        value: value,
        type: 'SEND',
        jobId: job.id
      );
      store.dispatch(sendToInviteCall(receiverAddress, tokensAmount, inviteWithJobId));
    }, untilDone: true));
  };
}

ThunkAction sendTokenCall(String receiverAddress, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
  return (Store store) async {
    try { 
      wallet_core.Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      Token token = store.state.cashWalletState.token;
      String tokenAddress = token.address;

      BigInt value = toBigInt(tokensAmount, token.decimals);

      logger.wtf(
          'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
      dynamic response = await api.tokenTransfer(
          web3, walletAddress, tokenAddress, receiverAddress, tokensAmount);

      dynamic jobId = response['job']['_id'];
      logger.wtf('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();

      store.dispatch(startFetchingJobCall(jobId, (job) {
        store.dispatch(new TransferJobSuccess(job));
      }));

      Transfer transfer = new Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: tokenAddress,
          value: value,
          type: 'SEND',
          status: 'PENDING',
          jobId: jobId);
      store.dispatch(new TransferSendSuccess(transfer));
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
      Token token = store.state.cashWalletState.token;
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
      }));

      Transfer transfer = new Transfer(
          from: walletAddress,
          to: receiverAddress,
          tokenAddress: tokenAddress,
          value: value,
          type: 'SEND',
          status: 'PENDING',
          jobId: jobId);
      // store.dispatch(new TransferSendSuccess(transfer));
      store.dispatch(new ReplaceTransfer(inviteWithJobId, transfer));
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
        return store.dispatch(new AlreadyJoinedCommunity(
            communityAddress,
            community["name"],
            new Token(
                address: token["address"],
                name: token["name"],
                symbol: token["symbol"],
                decimals: token["decimals"])));
      }
      await api.joinCommunity(web3, walletAddress, communityAddress);
      // return store.dispatch(new JoinCommunitySuccess(
      //     txHash,
      //     communityAddress,
      //     community["name"],
      //     new Token(address: token["address"], name: token["name"], symbol: token["symbol"], decimals: token["decimals"])));
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
      return store.dispatch(new SwitchCommunitySuccess(
          communityAddress,
          community["name"],
          new Token(
              address: token["address"],
              name: token["name"],
              symbol: token["symbol"],
              decimals: token["decimals"])));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not join community'));
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
      var response = await api
          .getBusinessList(store.state.cashWalletState.communityAddress);
      List<Business> businessList = new List();
      response["data"]
          .forEach((f) => businessList.add(new Business.fromJson(f)));
      store.dispatch(new BusinessesLoadedAction(businessList));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get businesses list'));
    }
  };
}

ThunkAction getTokenTransfersListCall(String tokenAddress) {
  return (Store store) async {
    try {
      String walletAddress = store.state.cashWalletState.walletAddress;
      num lastBlockNumber =
          store.state.cashWalletState.transactions.blockNumber;
      // logger.d(
      //     'fetching token transfers of $tokenAddress for $walletAddress wallet');
      Map<String, dynamic> response = await graph.getTransfers(
          walletAddress, tokenAddress,
          fromBlockNumber: lastBlockNumber);
      List<Transfer> transfers = List<Transfer>.from(
          response["data"].map((json) => Transfer.fromJson(json)).toList());
      store.dispatch(new GetTokenTransfersListSuccess(transfers));
    } catch (e) {
      logger.e(e);
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}

ThunkAction sendTokenToContactCall(String contactPhoneNumber, num tokensAmount,
    VoidCallback sendSuccessCallback, VoidCallback sendFailureCallback) {
  return (Store store) async {
    try {
      logger.i('Trying to send $tokensAmount to phone $contactPhoneNumber');
      Map wallet = await api.getWalletByPhoneNumber(contactPhoneNumber);
      logger.wtf("wallet $wallet");
      String walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      logger.wtf("walletAddress $walletAddress");
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(contactPhoneNumber, tokensAmount, sendSuccessCallback, sendFailureCallback));
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
