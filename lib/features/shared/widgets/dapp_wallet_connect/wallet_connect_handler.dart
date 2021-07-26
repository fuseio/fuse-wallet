import 'dart:async';
import 'dart:convert';

import 'package:ethereum_address/ethereum_address.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/widgets/dapp_wallet_connect/dapp_wc_remove_pool.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:wallet_connect_flutter/wallet_connect_flutter.dart';

import 'connect_response_model.dart';
import 'dapp_wc_connect.dart';
import 'dapp_wc_send_tx.dart';

class WalletConnectHandler implements IWCHandler {
  late WalletConnectFlutter conn;
  String wa = "";
  late BuildContext context;

  ConnectResponse connectResponse = new ConnectResponse(
    id: "id",
    meta: Meta(
      description: "",
      icons: [],
      name: '',
      url: '',
    ),
  );

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<WalletConnectFlutter> initPlatformState(
    BuildContext _context,
    String _wa,
  ) async {
    conn = await WalletConnectFlutter(handler: this);
    context = _context;
    wa = _wa;
    return conn;
  }

  Future<void> handleWC(String uri, WalletConnectFlutter _conn) async {
    if (!uri.contains('bridge')) {
      log.error('connect uri invalid');
      return;
    }
    await _conn.killSession();
    WalletConnectResponse res = await _conn.connect(uri);
    if (res.isError()) {
      return;
    }
    log.info('connect ${res.toString()} $wa');
    log.info('$wa');
  }

  num toNum(String value) {
    final BigInt amount = BigInt.parse(value);
    return amount.toDouble();
  }

  Future approveSend(dynamic res, int id) async {
    new Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      dynamic response = await api.getJob(res['job']['_id']);
      log.info('approveTokenAndCallContract: ${res.toString()}');
      if (response['data']['txHash'] == null) {
        log.info('fetched job with txHash null');
        return;
      } else {
        log.info('txHash ${response['data']['txHash']}');
        final WalletConnectResponse walletConnectResponse =
            await conn.approveCallRequest(id, response['data']['txHash']);
        log.info(
            'onCallRequestEthSendTransaction: walletConnectResponse ${walletConnectResponse.toString()}');
        timer.cancel();
      }
    });
  }

  Future approveCurrentSession(int? id, String? requestInJson) async {
    WalletConnectResponse res = await conn.approveSession(
      [
        wa,
      ],
      122,
    );
    if (res.isError()) {
      print("#########error");
      return;
    }
    log.info('connect ${res.toString()}');
    log.info('onSessionRequest $requestInJson');
  }

  Future approveRemovePool(int id, dynamic result) async {
    log.info(result);
    await conn.approveCallRequest(id, result["domain"]["chainId"]);
  }

  /// Overide's ///
  @override
  void onSessionRequest(int? id, String? requestInJson) async {
    var parse = jsonDecode(requestInJson!);
    Meta meta = await Meta(
        description: parse["meta"]["description"],
        icons: parse["meta"]["icons"],
        name: parse["meta"]["name"],
        url: parse["meta"]["url"]);
    connectResponse =
        await ConnectResponse(id: parse["id"].toString(), meta: meta);
    await DAppWalletConnect(context, wa, connectResponse, conn,
            await approveCurrentSession(id, requestInJson))
        .showBottomSheet();
  }

  @override
  void onCallRequestEthSendTransaction(int? id, String? result) async {
    log.info('onCallRequestEthSendTransaction $id $result');
    Map data = json.decode(result!);
    log.info('a $data');
    final String from = checksumEthereumAddress(data['from']);
    final String to = checksumEthereumAddress(data['to']);
    final num numAmount = num.parse(formatValue(
      BigInt.parse(data["value"]),
      18,
    ));
    log.info('numAmount $numAmount');
    final dynamic res = await api.callContract(
      fuseWeb3!,
      from,
      to,
      // numAmount,
      data['data'].replaceFirst(
        '0x',
        '',
      ),
      network: 'fuse',
      amountInWei: BigInt.parse(
        data["value"],
      ),
    );
    log.info('approveTokenAndCallContract: ${res.toString()}');
    await DAppWalletConnectSendTX(
      context,
      connectResponse,
      to,
      wa,
      numAmount,
      approveSend(res, id!),
    ).showBottomSheet();
  }

  @override
  void onCallRequestEthSignTypedData(int? id, String? result) async {
    log.info('onCallRequestEthSignTypedData $result');
    Map data = json.decode(result!);
    log.info('a $data');
    final String owner = checksumEthereumAddress(data['message']['owner']);
    final String spender = checksumEthereumAddress(data['message']['spender']);

    await DAppWalletConnectRemovePool(
      context,
      connectResponse,
      owner,
      spender,
      approveRemovePool(id!, result),
    ).showBottomSheet();
  }

  @override
  void onSessionDisconnect(String? errInJson) async {
    await conn.killSession();
    log.info('onSessionDisconnect $errInJson');
  }

  /// NOT Implemented yet ///
  @override
  void onCallRequestEthSign(int? id, String? requestInJson) {
    log.info('onCallRequestEthSign $requestInJson');
  }

  @override
  void onCallRequestEthSignTransaction(int? id, String? requestInJson) {
    log.info('onCallRequestEthSignTransaction $requestInJson');
  }

  @override
  void onCallRequestPersonalSign(int? id, String? requestInJson) {
    log.info(
        'onCallRequestPersonalSignonCallRequestPersonalSign $requestInJson');
  }

  @override
  void onError(String? error) {
    log.info('onError $error');
  }

  @override
  void onCallRequestEthSendRawTransaction(int? id, String? requestInJson) {
    log.info('onCallRequestEthSendRawTransaction $requestInJson');
  }
}
