import 'dart:async';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:injectable/injectable.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class Funder {
  final Dio dio;

  Funder(this.dio) {
    dio.options.baseUrl = dotenv.env['FUNDER_BASE_URL']!;
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

  Future<Map<String, dynamic>> getJob(String id) async {
    Response response = await dio.get('/job/$id');
    return response.data['data'];
  }
}

final Funder funderApi = getIt<Funder>();
