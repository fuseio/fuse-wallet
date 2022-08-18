import 'package:didkit/didkit.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/constants/strings.dart';
import 'package:fusecash/utils/did/private_key_generation.dart';

Future<String> generateDID(String mnemonic) async {
  debugPrint("Generating DID from mnemonic: $mnemonic");
  final privateKeyGeneration = PrivateKeyGeneration();
  final privateKeyToGenerateDID =
      await privateKeyGeneration.generatePrivateKey(mnemonic);
  final did = DIDKit.keyToDID(Strings.defaultDIDMethod, privateKeyToGenerateDID);
  debugPrint("did: $did");
  return did;
}
