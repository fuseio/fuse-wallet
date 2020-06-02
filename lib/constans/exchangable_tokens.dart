import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:ethereum_address/ethereum_address.dart';

final Token daiToken = Token(
    address: daiTokenAddress,
    decimals: 18,
    imageUrl: getTokenUrl(checksumEthereumAddress(daiTokenAddress)),
    name: "Dai Stablecoin",
    amount: BigInt.from(0),
    symbol: "DAI");

final _dzarToken = Token(
    symbol: "DZAR",
    name: "Digital Rand",
    decimals: 6,
    imageUrl: getTokenUrl('0x9Cb2f26A23b8d89973F08c957C4d7cdf75CD341c'),
    address: "0x9Cb2f26A23b8d89973F08c957C4d7cdf75CD341c");

final _usdcToken = Token(
    symbol: "USDC",
    name: "USD Coin",
    decimals: 6,
    imageUrl: getTokenUrl('0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'),
    address: "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48");

final _tetherToken = Token(
    symbol: "USDT",
    name: "Tether USD",
    decimals: 6,
    imageUrl: getTokenUrl('0xdAC17F958D2ee523a2206206994597C13D831ec7'),
    address: "0xdAC17F958D2ee523a2206206994597C13D831ec7");

final _trueUSDToken = Token(
    symbol: "TUSD",
    name: "TrueUSD",
    decimals: 18,
    imageUrl: getTokenUrl('0x0000000000085d4780B73119b644AE5ecd22b376'),
    address: "0x0000000000085d4780B73119b644AE5ecd22b376");

final _eursToken = Token(
    symbol: "EURS",
    name: "STASIS EURS Token",
    decimals: 2,
    imageUrl: getTokenUrl('0xdB25f211AB05b1c97D595516F45794528a807ad8'),
    address: "0xdB25f211AB05b1c97D595516F45794528a807ad8");

final _rupiahToken = Token(
    symbol: "IDRT",
    name: "Rupiah Token",
    decimals: 2,
    imageUrl: getTokenUrl('0x998FFE1E43fAcffb941dc337dD0468d52bA5b48A'),
    address: "0x998FFE1E43fAcffb941dc337dD0468d52bA5b48A");

final _etherToken = Token(
    symbol: "ETH",
    name: "Ether",
    decimals: 18,
    imageUrl: getTokenUrl(zeroAddress),
    address: zeroAddress);

final Map<String, Token> exchangableTokens = new Map<String, Token>.from({
  _etherToken.address: _etherToken,
  _usdcToken.address: _usdcToken,
  _dzarToken.address: _dzarToken,
  _tetherToken.address: _tetherToken,
  daiToken.address: daiToken,
  _trueUSDToken.address: _trueUSDToken,
  _eursToken.address: _eursToken,
  _rupiahToken.address: _rupiahToken,
});
