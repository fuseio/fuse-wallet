import 'dart:convert';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:secp256k1/secp256k1.dart';

class PrivateKeyGeneration {
  Future<String> generatePrivateKey(String mnemonic) async {
    //mnemonic - notice photo opera keen climb agent soft parrot best joke field devote
    final seed = bip39.mnemonicToSeed(
        mnemonic); //[105, 104, 114, 235, 191, 74, 81, 25, 186, 14, 224, 98, 187, 127, 45, 150, 115, 57, 174, 200, 238, 175, 36, 200, 142, 171, 91, 50, 40, 188, 126, 59, 73, 165, 227, 3, 92, 110, 15, 220, 157, 233, 140, 87, 195, 12, 91, 90, 165, 113, 52, 220, 139, 101, 206, 246, 2, 182, 24, 189, 73, 225, 195, 72]

    var rootKey = bip32.BIP32.fromSeed(seed); //Instance of 'BIP32'

    // derive path for ethereum '60' see bip 44, first address
    final child = rootKey.derivePath("m/44'/60'/0'/0/0"); //Instance of 'BIP32'

    Iterable<int> iterable = child
        .privateKey!; //[44, 254, 73, 198, 41, 37, 89, 193, 190, 104, 116, 244, 188, 50, 31, 128, 25, 101, 57, 132, 49, 132, 105, 153, 166, 32, 39, 237, 145, 88, 63, 154]

    final epk = HEX.encode(List.from(
        iterable)); //2cfe49c6292559c1be6874f4bc321f801965398431846999a62027ed91583f9a

    final pk = PrivateKey.fromHex(epk); //Instance of 'PrivateKey'

    final pub = pk.publicKey.toHex().substring(
        2); //41a72ac211e17bfa49bde064d4617ed88f08d394dfdbf20f51c367035d0dc9e8901f5ac8c57c64f9306b0ed200e08a1b36a08969dc1755f149eac0e3b652a06c

    final ad = HEX.decode(
        epk); //[44, 254, 73, 198, 41, 37, 89, 193, 190, 104, 116, 244, 188, 50, 31, 128, 25, 101, 57, 132, 49, 132, 105, 153, 166, 32, 39, 237, 145, 88, 63, 154]

    final d = base64Url.encode(ad).substring(0,
        43); // remove "=" padding 43/44 // ad -> LP5JxiklWcG-aHT0vDIfgBllOYQxhGmZpiAn7ZFYP5o

    final mx = pub.substring(0,
        64); // first 32 bytes // mx -> 41a72ac211e17bfa49bde064d4617ed88f08d394dfdbf20f51c367035d0dc9e8

    final ax = HEX.decode(
        mx); //[65, 167, 42, 194, 17, 225, 123, 250, 73, 189, 224, 100, 212, 97, 126, 216, 143, 8, 211, 148, 223, 219, 242, 15, 81, 195, 103, 3, 93, 13, 201, 232]

    final x = base64Url.encode(ax).substring(0,
        43); // remove "=" padding 43/44 // x -> QacqwhHhe_pJveBk1GF-2I8I05Tf2_IPUcNnA10Nyeg

    final my = pub.substring(
        64); // last 32 bytes // my -> 901f5ac8c57c64f9306b0ed200e08a1b36a08969dc1755f149eac0e3b652a06c

    final ay = HEX.decode(
        my); //[144, 31, 90, 200, 197, 124, 100, 249, 48, 107, 14, 210, 0, 224, 138, 27, 54, 160, 137, 105, 220, 23, 85, 241, 73, 234, 192, 227, 182, 82, 160, 108]

    final y = base64Url
        .encode(ay)
        .substring(0, 43); //kB9ayMV8ZPkwaw7SAOCKGzagiWncF1XxSerA47ZSoGw

    // ATTENTION !!!!!
    // alg "ES256K-R" for did:ethr and did:tz2 "EcdsaSecp256k1RecoverySignature2020"
    // use alg "ES256K" for did:key
    final key = {
      'kty': 'EC',
      'crv': 'secp256k1',
      'd': d,
      'x': x,
      'y': y,
      'alg': 'ES256K-R' // or 'alg': "ES256K" for did:key
    };
    // key = {
    //   "kty": "EC",
    //   "crv": "secp256k1",
    //   "d": "LP5JxiklWcG-aHT0vDIfgBllOYQxhGmZpiAn7ZFYP5o",
    //   "x": "QacqwhHhe_pJveBk1GF-2I8I05Tf2_IPUcNnA10Nyeg",
    //   "y": "kB9ayMV8ZPkwaw7SAOCKGzagiWncF1XxSerA47ZSoGw",
    //   "alg": "ES256K-R"
    // }

    return jsonEncode(key);
  }
}