import 'package:flutter_test/flutter_test.dart';
import 'package:fusecash/utils/did/private_key_generation.dart';

void main() {
  test(
    "Should generate the same private key from the same mnemonic",
    () async {
      const mnemonic = "husband modify silk must mansion payment jeans reopen "
          "connect eagle spirit wink";
      final privateKeyGeneration = PrivateKeyGeneration();
      final generatedPrivateKey =
          await privateKeyGeneration.generatePrivateKey(mnemonic);
      const privateKey =
          '{"kty":"EC","crv":"secp256k1","d":"wTo43nJjOmx9aSeyZc3wAA7y4EHHEzvKcXB2A6t15iA","x":"1lUjK7OPOVgQjCKRAg_rvJTil0xHldjStkkH5OJp13k","y":"OQJFxHdalE1Zr2i02gZBopKUvNeO2LDjitkBzE4U2QI","alg":"ES256K-R"}';
      expect(generatedPrivateKey, equals(privateKey));
    },
  );
}
