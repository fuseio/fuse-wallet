import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioDi {
  @lazySingleton
  Dio get dio => Dio();
}
