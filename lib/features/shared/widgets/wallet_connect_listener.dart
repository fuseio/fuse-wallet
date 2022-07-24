import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wallet_connect/wallet_connect.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/features/shared/bottom_sheets/on_session_request.dart';
import 'package:fusecash/features/shared/bottom_sheets/on_wallet_connect_tx.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/crashlytics.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/wallet_connect.dart';

class WCListener extends StatefulWidget {
  final Widget child;

  const WCListener({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<WCListener> createState() => _WCListenerState();
}

class _WCListenerState extends State<WCListener> {
  WCSessionStore? _sessionStore;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    if (!getIt.isRegistered<WCClient>()) {
      final WCClient wcClient = WCClient(
        onSessionRequest: _onSessionRequest,
        onFailure: _onSessionError,
        onDisconnect: _onSessionClosed,
        onEthSign: _onSign,
        onEthSendTransaction: _onSendTransaction,
        onEthSignTransaction: _onSignTransaction,
        onCustomRequest: (_, __) {},
        onConnect: () {},
      );
      getIt.registerSingleton<WCClient>(
        wcClient,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String?>(
      distinct: true,
      converter: (store) => store.state.userState.wcURI,
      onInitialBuild: (String? wcURI) {
        if (wcURI != null) {
          connectToWC(wcURI);
        }
      },
      builder: (_, vm) => widget.child,
    );
  }

  _onSessionRequest(int id, WCPeerMeta peerMeta) async {
    log.info('_onSessionRequest int: $id peerMeta: ${peerMeta.toString()}');
    if (mounted) {
      OnSessionRequestBottomSheet(
        wcPeerMeta: peerMeta,
        onConnect: (WCSessionStore wcSessionStore) {
          setState(() {
            _sessionStore = wcSessionStore;
          });
        },
      ).showSheet(
        context,
      );
    }
  }

  _onSessionError(dynamic message) {
    Crashlytics.logMessage(
      'Error Wallet connect: ${message?.toString()}',
    );
  }

  _onSessionClosed(int? code, String? reason) {
    if (_sessionStore != null) {
      StoreProvider.of<AppState>(context).dispatch(
        RemoveSession(_sessionStore!),
      );
    }
  }

  _onSign(int id, WCEthereumSignMessage ethereumSignMessage) {
    log.info('_onSign int: $id data: ${ethereumSignMessage.toString()}');
    if (ethereumSignMessage.data != null) {
      Map data = jsonDecode(ethereumSignMessage.data!);
      String owner = data['message']['owner'];
      String spender = data['message']['spender'];
      String value = data['message']['value'] ?? '0';
      OnTransactionBottomSheet(
        to: spender,
        value: value,
        onApprove: () async {
          final dynamic response = await chargeApi.approveTokenTransfer(
            getIt<Web3>(),
            owner,
            spender,
            amountInWei: BigInt.parse(value),
          );
          final String jobId = response['job']['_id'];
          _onApprove(
            jobId,
            id,
            contractAddress: spender,
          );
        },
        onReject: () => _onReject(id),
      ).showSheet(
        context,
      );
    }
  }

  _onSendTransaction(int id, WCEthereumTransaction ethereumTransaction) {
    log.info(
        '_onSendTransaction int: $id data: ${ethereumTransaction.toString()}');
    OnTransactionBottomSheet(
      to: ethereumTransaction.to,
      value: ethereumTransaction.value,
      onApprove: () async {
        final dynamic response = await chargeApi.callContract(
          getIt<Web3>(),
          StoreProvider.of<AppState>(context).state.userState.walletAddress,
          ethereumTransaction.to,
          ethereumTransaction.data.replaceFirst(
            '0x',
            '',
          ),
          amountInWei: BigInt.parse(
            ethereumTransaction.value ?? '0',
          ),
        );
        final String jobId = response['job']['_id'];
        _onApprove(
          jobId,
          id,
          contractAddress: ethereumTransaction.to,
        );
      },
      onReject: () => _onReject(id),
    ).showSheet(
      context,
    );
  }

  _onSignTransaction(int id, WCEthereumTransaction ethereumTransaction) {
    log.info(
        '_onSignTransaction int: $id data: ${ethereumTransaction.toString()}');
    OnTransactionBottomSheet(
      to: ethereumTransaction.to,
      value: ethereumTransaction.value,
      onApprove: () async {
        final dynamic response = await chargeApi.callContract(
          getIt<Web3>(),
          StoreProvider.of<AppState>(context).state.userState.walletAddress,
          ethereumTransaction.to,
          ethereumTransaction.data.replaceFirst(
            '0x',
            '',
          ),
          amountInWei: BigInt.parse(
            ethereumTransaction.value ?? '0',
          ),
        );
        final String jobId = response['job']['_id'];
        _onApprove(
          jobId,
          id,
          contractAddress: ethereumTransaction.to,
        );
      },
      onReject: () => _onReject(id),
    ).showSheet(
      context,
    );
  }

  void _onReject(
    int id,
  ) {
    getIt<WCClient>().rejectRequest(id: id);
    Analytics.track(
      eventName: AnalyticsEvents.wcTransaction,
      properties: {
        AnalyticsProps.status: AnalyticsProps.rejected,
        'type': AnalyticsProps.rejected,
      },
    );
    AutoRouter.of(context).pop();
  }

  void _onApprove(
    String jobId,
    int id, {
    String? contractAddress,
  }) {
    StoreProvider.of<AppState>(context).dispatch(
      fetchJobCall(
        jobId,
        (Map res) async {
          final InAppReview inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            Analytics.track(
              eventName: AnalyticsEvents.requestReview,
            );
            inAppReview.requestReview();
          }
        },
        (dynamic error) {
          log.error('JobId $jobId failed!, failReason: $error');
          Analytics.track(
            eventName: AnalyticsEvents.wcTransaction,
            properties: {
              'type': AnalyticsProps.failed,
              AnalyticsProps.status: AnalyticsProps.failed,
              'jobId': jobId,
            },
          );
        },
        onTxCallback: (txHash) {
          log.info('txHash: $txHash');
          getIt<WCClient>().approveRequest<String>(
            id: id,
            result: txHash,
          );
        },
        seconds: 1,
      ),
    );
    Analytics.track(
      eventName: AnalyticsEvents.wcTransaction,
      properties: {
        AnalyticsProps.status: AnalyticsProps.approved,
        'type': AnalyticsProps.approved,
        'contractAddress': contractAddress,
      },
    );
    Analytics.identify({
      AnalyticsProps.wcTransaction: true,
    });
    AutoRouter.of(context).pop();
  }
}
