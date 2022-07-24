import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/tokens/token.dart';


final Token fuseToken = Token(
  name: 'Fuse',
  symbol: 'FUSE',
  imageUrl: 'https://fuselogo.s3.eu-central-1.amazonaws.com/fuse-token.png',
  decimals: 18,
  address: Addresses.nativeTokenAddress,
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
  address: Addresses.fusdTokenAddress,
  timestamp: 0,
  amount: BigInt.zero,
  walletActions: WalletActions.initial(),
);
