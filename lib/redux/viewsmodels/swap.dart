import 'package:equatable/equatable.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/addresses.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/remote_config.dart';

class SwapViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final List<Token> receiveTokens;
  final bool isFetching;

  const SwapViewModel({
    required this.walletAddress,
    required this.tokens,
    required this.receiveTokens,
    required this.isFetching,
  });

  static SwapViewModel fromStore(Store<AppState> store) {
    final Map<String, Token> tokens = Map.from(store.state.swapState.tokens);
    tokens.removeWhere(
      (key, value) =>
          getIt<RemoteConfigService>().unexchangeableTokens.containsKey(
                checksumEthereumAddress(key),
              ),
    );

    final List<Token> tokenList = tokens.values.toList()
      ..where(
          (Token token) => num.parse(token.getBalance(true)).compareTo(0) == 1)
      ..sort();

    final Token fuse = store.state.swapState.tokens[fuseToken.address]!;
    final Token fusd = store.state.swapState.tokens[fuseDollarToken.address]!;
    final Token wfuse =
        store.state.swapState.tokens[Addresses.wfuseTokenAddress]!;
    final Token weth =
        store.state.swapState.tokens[Addresses.wethTokenAddress]!;
    final Token wbtc =
        store.state.swapState.tokens[Addresses.wbtcTokenAddress]!;
    final List<Token> receiveTokens = [
      fusd,
      fuse,
      wfuse,
      weth,
      wbtc,
      ...tokens.values.toList()
        ..removeWhere(
          (element) =>
              element.address == fusd.address ||
              element.address == wfuse.address ||
              element.address == fuse.address ||
              element.address == weth.address ||
              element.address == wbtc.address,
        ),
    ];

    return SwapViewModel(
      isFetching: store.state.swapState.isFetching,
      receiveTokens: receiveTokens,
      walletAddress: store.state.userState.walletAddress,
      tokens: List<Token>.from(tokenList.reversed),
    );
  }

  @override
  List<Object?> get props => [
        walletAddress,
        tokens,
        receiveTokens,
        isFetching,
      ];
}
