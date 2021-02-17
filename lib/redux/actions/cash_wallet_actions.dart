import 'dart:async';
import 'dart:io';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ethereum_address/ethereum_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/community/business_metadata.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/community/community_metadata.dart';
import 'package:fusecash/models/jobs/base.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/factory.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transactions.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/models/user_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/preloader.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/log/log.dart';

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

class GetTokenTransfersListSuccess {
  final String tokenAddress;
  final List<Transaction> tokenTransfers;
  GetTokenTransfersListSuccess({this.tokenAddress, this.tokenTransfers});
}

class GetActionsSuccess {
  final List<WalletAction> walletActions;
  final num updateAt;
  GetActionsSuccess({this.updateAt, this.walletActions});
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
        store.dispatch(SetDefaultCommunity(branchAddress));
      } else {
        store.dispatch(SetDefaultCommunity(defaultCommunityAddress));
      }
    }
  };
}

ThunkAction startFetchingCall() {
  return (Store store) async {
    bool isTransfersFetchingStarted =
        store.state.cashWalletState.isTransfersFetchingStarted ?? false;
    if (!isTransfersFetchingStarted &&
        store.state.userState.walletStatus != null &&
        store.state.userState.walletStatus == 'created' &&
        ![null, ''].contains(store.state.userState.walletAddress)) {
      try {
        log.info('Timer start - startFetchingCall');
        Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
            (Timer t) async {
          if (store.state.userState.walletAddress == '') {
            log.error('Timer stopeed - startFetchingCall');
            store.dispatch(SetIsTransfersFetching(isFetching: false));
            t.cancel();
            return;
          }
          store.dispatch(getWalletActionsCall());
          Map<String, Token> tokens =
              store.state.cashWalletState.tokens ?? Map();
          for (Token token in tokens.values) {
            if (![null, ''].contains(token.address)) {
              // store.dispatch(getReceivedTokenTransfersListCall(token));
              store.dispatch(getTokenBalanceCall(token));
            }
          }
        });
        store.dispatch(SetIsTransfersFetching(isFetching: true));
      } catch (e) {
        log.error('error in startFetchingCall $e');
      }
    }
  };
}

ThunkAction createAccountWalletCall(String accountAddress) {
  return (Store store) async {
    try {
      final String communityAddress =
          store.state?.cashWalletState?.communityAddress ??
              defaultCommunityAddress;
      Map<String, dynamic> response =
          await api.createWallet(communityAddress: communityAddress);
      ArsProgressDialog progressDialog = ArsProgressDialog(
        ExtendedNavigator.named('homeRouter').context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        loadingWidget: Container(
          height: 100.0,
          width: 250.0,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Preloader(
                width: 10,
                height: 10,
              ),
              Text(
                I18n.of(ExtendedNavigator.named('homeRouter').context)
                    .initializing_wallet,
                style: TextStyle(
                  color: Theme.of(ExtendedNavigator.named('homeRouter').context)
                      .primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        animationDuration: Duration(milliseconds: 500),
      );
      progressDialog.show();
      if (!response.containsKey('job')) {
        log.info('Wallet already exists');
        store.dispatch(CreateAccountWalletSuccess());
        store.dispatch(generateWalletSuccessCall(response, accountAddress));
        store.dispatch(switchCommunityCall(
          communityAddress,
          onSuccess: () {
            progressDialog.dismiss(); //close dialog
          },
        ));
      } else {
        CashWalletState cashWalletState = store.state.cashWalletState;
        Community community = cashWalletState.communities[communityAddress];
        if (!cashWalletState.tokens.containsKey(community?.homeTokenAddress)) {
          store.dispatch(CreateAccountWalletRequest());
          store.dispatch(
            startFetchingJobCall(
              response['job']['_id'],
              (Job job) async {
                dynamic fetchedData = job.data;
                final String accountAddress = fetchedData['owner'];
                store.dispatch(CreateAccountWalletSuccess());
                final response = await api.getWallet();
                store.dispatch(
                    generateWalletSuccessCall(response, accountAddress));
                store.dispatch(
                  switchCommunityCall(
                    communityAddress,
                    onSuccess: () {
                      progressDialog.dismiss(); //close dialog
                    },
                  ),
                );
              },
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

ThunkAction generateWalletSuccessCall(
    dynamic walletData, String accountAddress) {
  return (Store store) async {
    String walletAddress = walletData["walletAddress"];
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(enablePushNotifications());
      store.dispatch(setupWalletCall(walletData));
      store.dispatch(segmentIdentifyCall(new Map<String, dynamic>.from({
        "Wallet Generated": true,
        "App name": 'Fuse',
        "Phone Number": store.state.userState.normalizedPhoneNumber,
        "Wallet Address": store.state.userState.walletAddress,
        "Account Address": store.state.userState.accountAddress,
        "Display Name": store.state.userState.displayName
      })));
      store.dispatch(segmentTrackCall('Wallet: Wallet Generated'));
      store.dispatch(saveUserInDB(walletAddress));
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
      await token.fetchTokenBalance(walletAddress,
          onDone: onDone, onError: onError);
    } catch (e) {
      log.error('ERROR - getTokenBalanceCall $e');
    }
  };
}

ThunkAction fetchJobCall(String jobId, Function(Job) fetchSuccessCallback,
    {Timer timer, bool untilDone}) {
  return (Store store) async {
    try {
      dynamic response = await api.getJob(jobId);
      Job job = JobFactory.create(response);
      log.info("job.name: ${job.name}");
      if (untilDone) {
        if (job.lastFinishedAt == null || job.lastFinishedAt.isEmpty) {
          log.info('job not done');
          return;
        }
      } else {
        if (job.data['txHash'] == null) {
          log.info('fetched job with txHash null');
          return;
        }
      }
      fetchSuccessCallback(job);
      if (timer != null) {
        log.info('Timer stopeed - fetchJobCall');
        timer.cancel();
      }
    } catch (e) {
      log.error('ERROR - fetchJobCall $e');
    }
  };
}

ThunkAction startFetchingJobCall(
  String jobId,
  Function(Job) fetchSuccessCallback, {
  bool untilDone: true,
}) {
  return (Store store) async {
    new Timer.periodic(
        Duration(
          seconds: Variables.INTERVAL_SECONDS,
        ), (Timer timer) async {
      store.dispatch(
        fetchJobCall(
          jobId,
          fetchSuccessCallback,
          timer: timer,
          untilDone: untilDone,
        ),
      );
    });
  };
}

ThunkAction processingJobsCall(Timer timer) {
  return (Store store) async {
    final String walletAddress = store.state.userState.walletAddress;
    Map<String, Token> tokens = store.state.cashWalletState.tokens;
    for (Token token in tokens.values) {
      List<Job> jobs = token?.jobs ?? [];
      for (Job job in jobs) {
        String currentWalletAddress = store.state.userState.walletAddress;
        if (job.status != 'DONE' && job.status != 'FAILED') {
          bool isJobProcessValid() {
            if (currentWalletAddress != walletAddress) {
              log.error('Timer stopeed - processingJobsCall');
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
            await job.perform(store, isJobProcessValid);
          } catch (e) {
            log.error('failed perform ${job.name} $e');
          }
        }
        if (job.status == 'DONE') {
          log.info('Done ${job.name} ${job.id}');
          store.dispatch(JobDone(job: job, tokenAddress: token.address));
        }
      }
    }
  };
}

ThunkAction startProcessingJobsCall() {
  return (Store store) async {
    final bool isJobProcessingStarted =
        store.state.cashWalletState.isJobProcessingStarted ?? false;
    if (!isJobProcessingStarted) {
      log.info('Start Processing Jobs Call');
      new Timer.periodic(Duration(seconds: Variables.INTERVAL_SECONDS),
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
      log.error('ERROR - inviteAndSendCall $e');
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
    Token token =
        store.state.cashWalletState.tokens[inviteTransfer.tokenAddress];
    VoidCallback successCallBack = () {
      sendSuccessCallback();
      Community community = store
          .state.cashWalletState.communities[communityAddress.toLowerCase()];
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
    String walletAddress = store.state.userState.walletAddress;
    List<dynamic> tokensList = await fuseExplorerApi.getListOfTokensByAddress(
      walletAddress,
    );
    CashWalletState cashWalletState = store.state.cashWalletState;
    Map<String, Token> newTokens = Map<String, Token>.from(tokensList.fold(
      {},
      (previousValue, element) {
        Token token = Token.fromJson(element).copyWith(
          transactions: Transactions.initial(),
          jobs: List<Job>(),
          name: formatTokenName(element["name"]),
          timestamp: 0,
        );
        if (!cashWalletState.tokens.containsKey(token.address) &&
            num.parse(formatValue(token.amount, token.decimals,
                        withPrecision: true))
                    .compareTo(0) ==
                1) {
          log.info('newToken newToken ${token.name}');
          previousValue[token.address] = token;
        }
        return previousValue;
      },
    ));
    log.info('newTokens newTokens ${newTokens.length}');
    store.dispatch(AddCashTokens(tokens: newTokens));
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
      BigInt value = toBigInt(tokensAmount, token.decimals);
      dynamic response;
      num feeAmount = 20;
      log.info(
          'Multi bridge - Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress with fee $feeAmount');
      List trasnferData = await homeWeb3.transferTokenToForeign(
          walletAddress,
          receiverAddress,
          checksumEthereumAddress(tokenAddress),
          tokensAmount,
          token.decimals,
          network: 'fuse');
      Map<String, dynamic> feeTrasnferData =
          await homeWeb3.transferTokenOffChain(
        walletAddress,
        tokenAddress,
        Addresses.FEE_ADDRESS,
        feeAmount,
      );
      response = await api.multiRelay([...trasnferData, feeTrasnferData]);

      dynamic jobId = response['job']['_id'];
      log.info('Job $jobId for sending token sent to the relay service');

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
      log.error('ERROR - sendTokenToForeignMultiBridge $e');
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
  Transfer inviteTransfer,
}) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
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
        Map<String, dynamic> trasnferData =
            await homeWeb3.transferTokenOffChain(
          walletAddress,
          tokenAddress,
          receiverAddress,
          tokensAmount,
        );
        Map<String, dynamic> feeTrasnferData =
            await homeWeb3.transferTokenOffChain(
          walletAddress,
          tokenAddress,
          Addresses.FEE_ADDRESS,
          feeAmount,
        );
        response = await api.multiRelay([trasnferData, feeTrasnferData]);
      } else {
        log.info(
            'Sending $tokensAmount tokens of $tokenAddress from wallet $walletAddress to $receiverAddress');
        response = await api.tokenTransfer(
          homeWeb3,
          walletAddress,
          tokenAddress,
          receiverAddress,
          tokensAmount,
        );
      }

      dynamic jobId = response['job']['_id'];
      log.info('Job $jobId for sending token sent to the relay service');

      sendSuccessCallback();
    } catch (e) {
      log.error('ERROR - sendTokenCall ${e.toString()}');
      sendFailureCallback();
    }
  };
}

ThunkAction transactionFailed(transfer, String failReason) {
  return (Store store) async {
    Transfer failedTx = transfer.copyWith(
      status: 'FAILED',
      failReason: failReason,
    );
    store.dispatch(ReplaceTransaction(
      transaction: transfer,
      transactionToReplace: failedTx,
      tokenAddress: failedTx.tokenAddress,
    ));
  };
}

ThunkAction joinCommunityCall({Community community, Token token, onSuccess}) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      dynamic communityData =
          await graph.getCommunityByAddress(community.address);
      final String entitiesListAddress =
          communityData["entitiesList"]["address"];
      bool isMember =
          await graph.isCommunityMember(walletAddress, entitiesListAddress);
      log.info(
          'walletAddress $walletAddress isMember - $isMember entitiesListAddress - $entitiesListAddress');
      if (isMember) {
        store.dispatch(AlreadyJoinedCommunity(community.address));
      } else {
        await api.joinCommunity(
          homeWeb3,
          walletAddress,
          community.address,
          tokenAddress: token.address,
          originNetwork: token.originNetwork,
          network: 'fuse',
          communityName: community.name,
        );
        if (onSuccess != null) {
          onSuccess();
        }
      }
    } catch (e) {
      log.error('ERROR - joinCommunityCall ${e.toString()}');
    }
  };
}

ThunkAction fetchCommunityMetadataCall(
    String communityAddress, String communityURI, bool isRopsten) {
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
            isDefaultImage: metadata['isDefault'] ?? false);
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
  Community community,
  bool isRopsten,
  String originNetwork,
) async {
  if (community.homeTokenAddress != null &&
      community.homeTokenAddress.isNotEmpty) {
    Map tokenInfo =
        await fuseExplorerApi.getTokenInfo(community.homeTokenAddress);
    final token = Token.fromJson(tokenInfo).copyWith(
      originNetwork: originNetwork,
      transactions: Transactions.initial(),
      address: community.homeTokenAddress.toLowerCase(),
      timestamp: 0,
      amount: BigInt.zero,
      communityAddress: community.address.toLowerCase(),
      name: formatTokenName(tokenInfo['name']),
    );
    return token;
  } else {
    dynamic tokenInfo = await graph.getHomeBridgedToken(
      community.foreignTokenAddress,
      isRopsten,
    );
    final token = Token.fromJson(tokenInfo).copyWith(
      originNetwork: originNetwork,
      address: tokenInfo['address'].toLowerCase(),
      timestamp: 0,
      transactions: Transactions.initial(),
      amount: BigInt.zero,
      communityAddress: community.address.toLowerCase(),
      name: formatTokenName(tokenInfo['name']),
    );
    return token;
  }
}

ThunkAction switchToNewCommunityCall(String communityAddress, {onSuccess}) {
  return (Store store) async {
    try {
      String walletAddress =
          checksumEthereumAddress(store.state.userState.walletAddress);
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
          onSuccess: onSuccess,
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

ThunkAction switchToExisitingCommunityCall(String communityAddress) {
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
    } catch (e, s) {
      log.error('ERROR - switchToExisitingCommunityCall $e');
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
    if (current != null &&
        current.name != null &&
        current.isMember != null &&
        current.isMember) {
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

ThunkAction switchCommunityCall(String communityAddress, {Function onSuccess}) {
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
        store.dispatch(switchToExisitingCommunityCall(communityAddress));
      } else {
        store.dispatch(SwitchToNewCommunity(communityAddress));
        store.dispatch(
            switchToNewCommunityCall(communityAddress, onSuccess: onSuccess));
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
        Future<List<Business>> businesses =
            Future.wait(entities.map((dynamic entity) async {
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
        }));
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

ThunkAction getTokenTransfersListCall(Token token) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      String tokenAddress = token?.address;
      num lastBlockNumber = token?.transactions?.blockNumber ?? 0;
      dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
        walletAddress,
        tokenAddress,
        startblock: lastBlockNumber,
      );
      List<Transaction> transfers = List<Transaction>.from(
        tokensTransferEvents.map(
          (transaction) => TransactionFactory.fromJson(transaction),
        ),
      );
      if (transfers.isNotEmpty) {
        store.dispatch(GetTokenTransfersListSuccess(
          tokenTransfers: transfers,
          tokenAddress: tokenAddress,
        ));
      }
    } catch (e) {
      log.error('ERROR - getTokenTransfersListCall $e');
    }
  };
}

ThunkAction getWalletActionsCall() {
  return (Store store) async {
    String walletAddress = store.state.userState.walletAddress;
    WalletActions walletActions = store.state.cashWalletState.walletActions;
    Iterable<dynamic> tokensTransferEvents =
        await api.getActionsByWalletAddress(
      walletAddress,
      updatedAt: walletActions?.updatedAt ?? 0,
    );
    List<WalletAction> actions = List<WalletAction>.from(
      tokensTransferEvents.map(
        (json) => WalletActionFactory.fromJson(json),
      ),
    );
    if (actions.isNotEmpty) {
      store.dispatch(GetActionsSuccess(
        walletActions: actions,
        updateAt: actions.last.timestamp,
      ));
    }
  };
}

ThunkAction getReceivedTokenTransfersListCall(Token token) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      num lastBlockNumber = token?.transactions?.blockNumber ?? 0;
      final String tokenAddress = token?.address;
      dynamic tokensTransferEvents = await api.fetchTokenTxByAddress(
        walletAddress,
        tokenAddress,
        startblock: lastBlockNumber,
      );

      List<Transaction> transfers = List<Transaction>.from(
        tokensTransferEvents.map(
          (json) => TransactionFactory.fromJson(json),
        ),
      );
      if (transfers.isNotEmpty) {
        store.dispatch(GetTokenTransfersListSuccess(
          tokenTransfers: transfers,
          tokenAddress: token.address,
        ));
      }
    } catch (e) {
      log.error('ERROR - getReceivedTokenTransfersListCall $e');
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
