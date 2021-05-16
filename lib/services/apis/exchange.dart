import 'dart:async';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class Exchange {
  final Dio dio;

  Exchange(this.dio) {
    dio.options.baseUrl = UrlConstants.TOTLE_EXCHANGE_API;
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

  Future<Map<String, dynamic>> swap(
    String walletAddress,
    Map data,
  ) async {
    Map body = Map.from({
      'address': walletAddress,
      ...data,
    });

    Response response = await dio.post('/swap', data: body);
    return response.data;
  }
}
