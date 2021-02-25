import 'dart:async';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/models/swap/swap.dart';
import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class SwapService {
  final Dio dio;

  SwapService(this.dio) {
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

  Future<SwapCallParameters> swapCallParameters(
    String currencyIn,
    String currencyOut,
    String amountIn,
    String recipient,
  ) async {
    Map body = Map.from({
      'currencyIn': currencyIn,
      'currencyOut': currencyOut,
      'amountIn': amountIn,
      'recipient': recipient,
    });

    Response response = await dio.post('/swapcallparameters', data: body);
    return SwapCallParameters.fromJson(response.data);
  }

  Future<TradeInfo> trade(
    String currencyIn,
    String currencyOut,
    String amountIn,
    String recipient,
  ) async {
    Map body = Map.from({
      'currencyIn': currencyIn,
      'currencyOut': currencyOut,
      'amountIn': amountIn,
      'recipient': recipient,
    });

    Response response = await dio.post('/trade', data: body);
    return TradeInfo.fromJson(response.data['data']['info']);
  }
}
