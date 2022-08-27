import 'package:didkit/didkit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should get DIDKit version", () {
    final didKitVersion = DIDKit.getVersion();
    expect(didKitVersion, isA<String>());
  });
}