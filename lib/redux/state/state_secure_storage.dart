import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux_persist/redux_persist.dart';

/// Storage engine to save to file.
class SecureStorage implements StorageEngine {
  /// File to save to.
  var storage = new FlutterSecureStorage();

  SecureStorage(this.storage);

  @override
  Future<Uint8List> load() async {
    String data = await storage.read(key: "data");
    return stringToUint8List(data);
  }

  @override
  Future<void> save(Uint8List data) async {
    await storage.write(key: "data", value: uint8ListToString(data));
  }
}
