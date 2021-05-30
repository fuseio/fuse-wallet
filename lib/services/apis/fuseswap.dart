import 'dart:async';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/stats.dart';
import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class FuseSwapService {
  final Dio dio;

  FuseSwapService(this.dio) {
    dio.options.baseUrl = UrlConstants.FUSESWAP_SERVICE_API;
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

  Future<SwapCallParameters> requestParameters(
    SwapRequestBody swapRequestBody,
  ) async {
    Response response = await dio.post(
      '/swap/requestparameters',
      data: swapRequestBody.toJson(),
    );
    return SwapCallParameters.fromJson(response.data);
  }

  Future<TradeInfo> quote(
    SwapRequestBody swapRequestBody,
  ) async {
    Response response = await dio.post(
      '/swap/quote',
      data: swapRequestBody.toJson(),
    );
    return TradeInfo.fromJson(response.data['data']['info']);
  }

  Future<Price> price(
    String tokenAddress, {
    String currency = 'usd',
  }) async {
    Response response = await dio.get('/price/$tokenAddress');
    return Price(
      currency: currency,
      quote: (response.data['data']['price'] ?? 0).toString(),
    );
  }

  Future<List<Stats>> stats(
    String tokenAddress, {
    String limit = '30',
  }) async {
    Response response = await dio.get('/stats/$tokenAddress', queryParameters: {
      'limit': limit,
    });
    return (response.data['data'] as List<dynamic>)
        .map((stats) => Stats.fromJson(stats))
        .toList();
  }

  Future<num> priceChange(
    String tokenAddress,
  ) async {
    Response response = await dio.get('/pricechange/$tokenAddress');
    return num.tryParse(response.data['data']['priceChange'].toString()) ?? 0;
  }

  Future<num> priceDiff(
    String tokenAddress,
    String days,
  ) async {
        Response response = await dio.post(
      '/pricechange/$tokenAddress',
      data: Map.from({
        "duration": {
          "days": days,
        },
      }),
    );
    return num.tryParse(response.data['data']['priceChange'].toString()) ?? 0;
  }
}
