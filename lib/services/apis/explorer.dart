import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
// import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class Explorer {
  Dio dio;

  Explorer(
    this.dio,
    @factoryParam String base,
    @factoryParam String apiKey,
  ) {
    if (apiKey != null) {
      dio.options.queryParameters = Map.from({'apiKey': apiKey});
    }
    dio.options.baseUrl = base;
    dio.options.headers = Map.from({"Content-Type": 'application/json'});

    // if (kDebugMode) {
    //   dio.interceptors.add(PrettyDioLogger(
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: true,
    //     responseBody: true,
    //     error: true,
    //     compact: true,
    //   ));
    // }
  }

  Future<List<dynamic>> getTokenTransferEventsByAccountAddress(
    String tokenAddress,
    String accountAddress, {
    String sort = 'desc',
    int startblock = 0,
  }) async {
    try {
      Response response = await dio.get(
          '?module=account&action=tokentx&contractaddress=$tokenAddress&address=$accountAddress&startblock=$startblock&sort=$sort');
      if (response.data['message'] == 'OK' && response.data['status'] == '1') {
        List transfers = [];
        for (dynamic transferEvent in response.data['result']) {
          transfers.add({
            'blockNumber': num.parse(transferEvent['blockNumber']),
            'txHash': transferEvent['hash'],
            'to': transferEvent['to'],
            'from': transferEvent["from"],
            'status': "CONFIRMED",
            'timestamp': DateTime.fromMillisecondsSinceEpoch(
                    DateTime.fromMillisecondsSinceEpoch(
                                int.parse(transferEvent['timeStamp']))
                            .millisecondsSinceEpoch *
                        1000)
                .millisecondsSinceEpoch,
            'value': transferEvent['value'],
            'tokenAddress': tokenAddress,
            'type': transferEvent["from"].toString().toLowerCase() ==
                    accountAddress.toLowerCase()
                ? 'SEND'
                : 'RECEIVE',
          });
        }
        return transfers;
      } else {
        return [];
      }
    } catch (e) {
      throw 'Error! Get token transfers events failed for - accountAddress: $accountAddress --- $e';
    }
  }

  Future<List<dynamic>> getTransferEventsByAccountAddress(
    String address, {
    String sort = 'desc',
    int startblock = 0,
  }) async {
    try {
      Response response = await dio.get(
          '?module=account&action=tokentx&address=$address&startblock=$startblock&sort=$sort');
      if (response.data['message'] == 'OK' && response.data['status'] == '1') {
        List transfers = [];
        for (dynamic transferEvent in response.data['result']) {
          transfers.add({
            'blockNumber': num.parse(transferEvent['blockNumber']),
            'txHash': transferEvent['hash'],
            'to': transferEvent['to'],
            'from': transferEvent["from"],
            'status': "CONFIRMED",
            'timestamp': DateTime.fromMillisecondsSinceEpoch(
                    DateTime.fromMillisecondsSinceEpoch(
                                int.parse(transferEvent['timeStamp']))
                            .millisecondsSinceEpoch *
                        1000)
                .millisecondsSinceEpoch,
            'value': transferEvent['value'],
            'tokenAddress': transferEvent['contractAddress'],
            'type': transferEvent["from"].toString().toLowerCase() ==
                    address.toLowerCase()
                ? 'SEND'
                : 'RECEIVE',
          });
        }
        return transfers;
      } else {
        return [];
      }
    } catch (e) {
      throw 'Error! Get token transfers events failed for - address: $address --- $e';
    }
  }

  Future<Token> getTokenInfo(String tokenAddress) async {
    Response response = await dio
        .get('?module=token&action=getToken&contractaddress=$tokenAddress');
    if (response.data['message'] == 'OK' && response.data['status'] == '1') {
      return Token.fromJson({
        ...response.data['result'],
        "name": formatTokenName(response.data['result']["name"]),
        "address": response.data['result']["contractAddress"],
        'decimals': int.parse(response.data['result']['decimals'])
      }).copyWith(
        timestamp: 0,
        amount: BigInt.zero,
      );
    } else {
      return null;
    }
  }

  Future<List<Token>> getListOfTokensByAddress(String address) async {
    Response response =
        await dio.get('?module=account&action=tokenlist&address=$address');
    if (response.data['message'] == 'OK' && response.data['status'] == '1') {
      List<Token> tokens = [];
      for (dynamic token in response.data['result']) {
        tokens.add(
          Token.fromJson({
            "amount": token['balance'],
            "originNetwork": 'mainnet',
            "address": token['contractAddress'].toLowerCase(),
            "decimals": int.parse(token['decimals']),
            "name": formatTokenName(token["name"]),
            "symbol": token['symbol'],
          }).copyWith(
            timestamp: 0,
          ),
        );
      }
      return tokens;
    } else {
      return [];
    }
  }
}
