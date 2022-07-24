import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfoBase {
  Future<bool> get isConnected;
}

@lazySingleton
class NetworkInfo extends NetworkInfoBase {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfo(this.internetConnectionChecker);

  @override
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
