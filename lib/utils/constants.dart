import 'package:supervecina/constants/addresses.dart';
import 'package:supervecina/constants/strings.dart';
import 'package:supervecina/models/actions/actions.dart';
import 'package:supervecina/models/tokens/token.dart';
import 'package:supervecina/utils/string.dart';

final String wethTokenAddress = '0xa722c13135930332eb3d749b2f0906559d2c5b99';
final String wbtcTokenAddress = '0x33284f95ccb7b948d9d352e1439561cf83d8d00d';
final String wfuseTokenAddress = '0x0be9e53fd7edac9f859882afdda116645287c629';

final Map<String, Map<String, String>> donors = Map.from({
  '0xed0bd7f319cd03539cbd3b5c592cae91a349dbae': {
    'image': 'comunitaria.jpeg',
    'name': Strings.appTitle
  },
  '0x615334c6256cd8dd94eed368cebedcf07a36a5ae': {
    'image': 'caritas.png',
    'name': 'Cáritas'
  },
  '0xfab6afa92671b319499384435c9df0ff11252b6c': {
    'image': 'banco_de_alimentos.jpeg',
    'name': 'Banco de Alimentos'
  },
  '0xa86696defccd53bbc5b6c80fd6b9824e453cd16d': {
    'image': 'barrios.jpg',
    'name': 'Asociación Tres Barrios'
  },
  '0x0c9b8c54634301350a0a5059cadcc828afd4b246': {
    'image': 'barrios.jpg',
    'name': 'Asociación Tres Barrios'
  }
});

final Token illaToken = Token(
  name: Strings.appTitle,
  symbol: 'ILLA',
  imageUrl:
      'https://fuse-studio.s3.eu-central-1.amazonaws.com/748bbbd19008eb3a1ac91a21e02b4d708d1552c0dba4c687bc8a451684cd9b18',
  decimals: 18,
  address: Addresses.ILLA_ADDRESS,
  originNetwork: 'fuse',
  isNative: true,
  timestamp: 0,
  amount: BigInt.zero,
  walletActions: WalletActions.initial(),
);

final Token fuseToken = Token(
  name: 'Fuse',
  symbol: 'FUSE',
  imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
  decimals: 18,
  address: Addresses.NATIVE_ADDRESS,
  originNetwork: 'fuse',
  isNative: true,
  timestamp: 0,
  amount: BigInt.zero,
  walletActions: WalletActions.initial(),
);

String toShortName(networkType) =>
    networkType == 'mainnet' ? 'main' : networkType;

String getBridgeMediator(
    {String networkType = 'mainnet', String bridgeType = 'foreign'}) {
  return bridgeType == 'foreign'
      ? bridgeAddresses[toShortName(networkType)]['MultiBridgeMediator}']
      : bridgeAddresses['fuse']
          ['MultiBridgeMediator${toShortName(networkType).capitalize()}'];
}

Map<String, dynamic> bridgeAddresses = Map.from({
  "fuse": {
    "MultiBridgeMediatorRopsten": "0xAEBC2058780eb0372e7Ee75c11019d26E36894ad",
    "MultiBridgeMediatorMain": "0xc2220646E1E76D5fF3a441eDd9E8EFF0e4A8EF03",
  },
  "main": {"MultiBridgeMediator": "0xf301d525da003e874DF574BCdd309a6BF0535bb6"},
  "ropsten": {
    "MultiBridgeMediator": "0x68b762A7a68F6D87Fcf2E2EaF7eF48D00cAa2419"
  }
});
