import 'package:fusecash/redux/state/secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

@module
abstract class FlutterSecureStorageDi {
  @Named('flutterSecureStorage')
  FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();
  // @lazySingleton
  // FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage();

  @lazySingleton
  SecureStorage secureStorage(
          @Named('flutterSecureStorage')
              FlutterSecureStorage flutterSecureStorage) =>
      SecureStorage(flutterSecureStorage);
}
