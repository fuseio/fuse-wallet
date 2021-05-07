import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/string.dart';

final Token fuseToken = Token(
  name: 'Fuse',
  symbol: 'FUSE',
  imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
  decimals: 18,
  address: Addresses.ZERO_ADDRESS,
  originNetwork: 'fuse',
  isNative: true,
  timestamp: 0,
  amount: BigInt.zero,
  walletActions: WalletActions.initial(),
);

final Token fuseDollarToken = Token(
  name: 'Fuse Dollar',
  symbol: 'fUSD',
  imageUrl: "https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-dollar.png",
  decimals: 18,
  address: Addresses.FUSE_DOLLAR_TOKEN_ADDRESS,
  originNetwork: 'fuse',
  timestamp: 0,
  amount: BigInt.zero,
  walletActions: WalletActions.initial(),
);

String toShortName(networkType) =>
    networkType == 'mainnet' ? 'main' : networkType;

String getBridgeMediator(
    {String networkType = 'mainnet', String bridgeType = 'foreign'}) {
  return bridgeType == 'foreign'
      ? bridgeAddresses['${toShortName(networkType)}']['MultiBridgeMediator}']
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
