import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkInfoDi {
  @lazySingleton
  InternetConnectionChecker get dataConnectionChecker =>
      InternetConnectionChecker();
}
