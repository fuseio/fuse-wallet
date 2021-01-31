
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/home/widgets/assets_list.dart';

final String zeroAddress = "0x0000000000000000000000000000000000000000";

final Token daiToken = Token.initial().copyWith(
    address: '0x94Ba7A27c7A95863d1bdC7645AC2951E0cca06bA',
    decimals: 18,
    imageUrl: getTokenUrl('0x6B175474E89094C44Da98b954EedeAC495271d0F'),
    name: "Dai Stablecoin on Fuse",
    subtitle: 'US dollar',
    amount: BigInt.zero,
    symbol: "DAI");

final Token usdcToken = Token.initial().copyWith(
    symbol: "USDC",
    name: "USD Coin on Fuse",
    decimals: 6,
    subtitle: 'US dollar',
    imageUrl: getTokenUrl('0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'),
    address: '0x620fd5fa44BE6af63715Ef4E65DDFA0387aD13F5');

final Token wrappedEther = Token.initial().copyWith(
    symbol: "WETH",
    name: "Wrapped ETH on Fuse",
    decimals: 18,
    subtitle: 'Ether',
    imageUrl: getTokenUrl(zeroAddress),
    address: '0xd8Bf72f3e163B9CF0C73dFdCC316417A5ac20670');

final Map<String, Token> swappableTokens = new Map<String, Token>.from({
  daiToken.symbol: daiToken,
  usdcToken.symbol: usdcToken,
  wrappedEther.symbol: wrappedEther
});
