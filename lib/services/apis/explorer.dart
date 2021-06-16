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
    @factoryParam String? base,
    @factoryParam String? apiKey,
  ) {
    if (apiKey != null) {
      dio.options.queryParameters = Map.from({'apiKey': apiKey});
    }
    dio.options.baseUrl = base!;
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
