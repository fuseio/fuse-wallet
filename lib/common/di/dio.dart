import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioDi {
  @injectable
  Dio get dio => Dio();
}
