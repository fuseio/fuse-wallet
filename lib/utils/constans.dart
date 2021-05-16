import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supervecina/screens/home/widgets/drawer.dart';

final Map<String, Map<String, String>> donors = Map.from({
  '0xed0bd7f319cd03539cbd3b5c592cae91a349dbae': {
    'image': 'comunitaria.png',
    'name': 'Comunitaria'
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
    'image': 'asociación_3_barrios.jpeg',
    'name': 'Asociación Tres Barrios'
  },
  '0x0c9b8c54634301350a0a5059cadcc828afd4b246': {
    'image': 'asociación_3_barrios.jpeg',
    'name': 'Asociación Tres Barrios'
  }
});

final int intervalSeconds = int.parse(DotEnv().env['INTERVAL_SECONDS']);

String toShortName(networkType) =>
    networkType == 'mainnet' ? 'main' : networkType;

String getBridgeMediator(
    {String networkType = 'mainnet', String bridgeType = 'foreign'}) {
  return bridgeType == 'foreign'
      ? bridgeAddresses['${toShortName(networkType)}']['MultiBridgeMediator}']
      : bridgeAddresses['fuse']
          ['MultiBridgeMediator${capitalize(toShortName(networkType))}'];
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
