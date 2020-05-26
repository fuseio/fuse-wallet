import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/screens/pro_mode/assets_list.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:ethereum_address/ethereum_address.dart';

final Token _daiToken = Token(
    address: daiTokenAddress,
    decimals: 18,
    imageUrl: getTokenUrl(checksumEthereumAddress(daiTokenAddress)),
    name: "Dai Stablecoin",
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

final Map<String, Token> exchangableTokens = new Map<String, Token>.from({
  _daiToken.address: _daiToken,
  _usdcToken.address: _usdcToken,
  _dzarToken.address: _dzarToken
});
