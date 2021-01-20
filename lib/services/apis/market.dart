import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class Market {
  final Dio dio;

  Market(this.dio) {
    dio.options.baseUrl = UrlConstants.COINGECKO_BASE_URL;
    dio.options.headers = Map.from({"Content-Type": 'application/json'});

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
      ));
    }
  }

  // Get current price of tokens (using contract addresses) for a given platform in any other currency that you need.
  Future<dynamic> getCurrentPriceOfTokens(
      String contractAddresses, String vsCurrencies,
      {String networkId = 'ethereum'}) async {
    try {
      Response response = await dio.get(
          'simple/token_price/$networkId?contract_addresses=$contractAddresses&vs_currencies=$vsCurrencies');
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Get the current price of any cryptocurrencies in any other supported currencies that you need.
  Future<dynamic> getCurrentPriceOfToken(
    String ids,
    String vsCurrencies,
  ) async {
    try {
      Response response =
          await dio.get('/simple/price?ids=$ids&vs_currencies=$vsCurrencies');
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Get coin info from contract address
  Future<dynamic> getCoinInfoByAddress(String contractAddress,
      {String networkId = 'ethereum'}) async {
    try {
      Response response =
          await dio.get('/coins/$networkId/contract/$contractAddress');
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}
