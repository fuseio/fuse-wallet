import 'package:esol/models/tokens/token.dart';
import 'package:esol/screens/home/widgets/assets_list.dart';
import 'package:esol/utils/addresses.dart';

final Token daiToken = Token.initial().copyWith(
    address: '0x6B175474E89094C44Da98b954EedeAC495271d0F',
    decimals: 18,
    imageUrl: getTokenUrl('0x6B175474E89094C44Da98b954EedeAC495271d0F'),
    name: "Dai Stablecoin",
    subtitle: 'US dollar',
    amount: BigInt.zero,
    symbol: "DAI");

final _dzarToken = Token.initial().copyWith(
    symbol: "DZAR",
    name: "Digital Rand",
    amount: BigInt.zero,
    decimals: 6,
    subtitle: 'South Africa',
    imageUrl: getTokenUrl('0x9Cb2f26A23b8d89973F08c957C4d7cdf75CD341c'),
    address: "0x9Cb2f26A23b8d89973F08c957C4d7cdf75CD341c");

final _usdcToken = Token.initial().copyWith(
    symbol: "USDC",
    name: "USD Coin",
    decimals: 6,
    subtitle: 'US dollar',
    imageUrl: getTokenUrl('0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'),
    address: "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48");

final _tetherToken = Token.initial().copyWith(
    symbol: "USDT",
    name: "Tether USD",
    amount: BigInt.zero,
    decimals: 6,
    subtitle: 'US dollar',
    imageUrl: getTokenUrl('0xdAC17F958D2ee523a2206206994597C13D831ec7'),
    address: "0xdAC17F958D2ee523a2206206994597C13D831ec7");

final _trueUSDToken = Token.initial().copyWith(
    symbol: "TUSD",
    name: "TrueUSD",
    amount: BigInt.zero,
    decimals: 18,
    subtitle: 'US dollar',
    imageUrl: getTokenUrl('0x0000000000085d4780B73119b644AE5ecd22b376'),
    address: "0x0000000000085d4780B73119b644AE5ecd22b376");

final _eursToken = Token.initial().copyWith(
    symbol: "EURS",
    name: "STASIS EURS Token",
    amount: BigInt.zero,
    decimals: 2,
    subtitle: 'Europe',
    imageUrl: getTokenUrl('0xdB25f211AB05b1c97D595516F45794528a807ad8'),
    address: "0xdB25f211AB05b1c97D595516F45794528a807ad8");

final _rupiahToken = Token.initial().copyWith(
    symbol: "IDRT",
    name: "Rupiah Token",
    amount: BigInt.zero,
    decimals: 2,
    subtitle: 'Indonesia',
    imageUrl: getTokenUrl('0x998FFE1E43fAcffb941dc337dD0468d52bA5b48A'),
    address: "0x998FFE1E43fAcffb941dc337dD0468d52bA5b48A");

final _etherToken = Token.initial().copyWith(
    symbol: "ETH",
    amount: BigInt.zero,
    name: "Ether",
    decimals: 18,
    imageUrl: getTokenUrl(zeroAddress),
    address: zeroAddress);

final Map<String, Token> exchangableTokens = new Map<String, Token>.from({
  _etherToken.address: _etherToken,
  daiToken.address: daiToken,
  _usdcToken.address: _usdcToken,
  _tetherToken.address: _tetherToken,
  _trueUSDToken.address: _trueUSDToken,
  _eursToken.address: _eursToken,
  _dzarToken.address: _dzarToken,
  _rupiahToken.address: _rupiahToken,
});

final dollarPeggedToken = [
  daiToken.address.toLowerCase(),
  _usdcToken.address.toLowerCase(),
  _tetherToken.address.toLowerCase(),
  _trueUSDToken.address.toLowerCase(),
  _eursToken.address.toLowerCase()
];
