// import 'dart:async';
// import 'package:auto_route/auto_route.dart';
// // import 'package:dio/dio.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // import 'package:fusecash/constants/env.dart';
// // import 'package:fusecash/constants/urls.dart';
// // import 'package:injectable/injectable.dart';
// // import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// abstract class IExplorer {
//   Future<List<dynamic>> getTransferEventsByAccountAddress({
//     @required String address,
//     String sort = 'desc',
//     int startblock = 0,
//   });
//   Future<List<dynamic>> getTokenTransferEventsByAccountAddress({
//     @required String tokenAddress,
//     @required String accountAddress,
//     String sort = 'desc',
//     int startblock = 0,
//   });

//   Future<BigInt> getTokenBalanceByAccountAddress({
//     @required String tokenAddress,
//     @required String accountAddress,
//   });

//   Future<Map<String, dynamic>> getTokenInfo({
//     @required String tokenAddress,
//   });

//   Future<List<dynamic>> getListOfTokensByAddress({
//     @required String accountAddress,
//   });
// }