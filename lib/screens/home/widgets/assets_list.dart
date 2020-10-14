import 'package:fc_knudde/screens/home/widgets/token_tile.dart';
import 'package:fc_knudde/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fc_knudde/models/app_state.dart';
import 'package:fc_knudde/models/tokens/token.dart';
import 'package:fc_knudde/utils/addresses.dart';

String getTokenUrl(tokenAddress) {
  return tokenAddress == zeroAddress
      ? 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'
      : "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/$tokenAddress/logo.png";
}

class AssetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
      distinct: true,
      converter: TokensListViewModel.fromStore,
      builder: (_, viewModel) {
        return Scaffold(
            key: key,
            body: Column(children: <Widget>[
              Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: viewModel.tokens?.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                            color: Color(0xFFE8E8E8),
                            thickness: 1,
                            height: 0,
                          ),
                      itemBuilder: (context, index) =>
                          TokenTile(token: viewModel.tokens[index]))),
            ]));
      },
    );
  }
}

class TokensListViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  TokensListViewModel({
    this.walletAddress,
    this.tokens,
  });

  static TokensListViewModel fromStore(Store<AppState> store) {
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .toList();

    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .map((Token token) => token?.copyWith(
            imageUrl: store.state.cashWalletState.communities
                    .containsKey(token.communityAddress)
                ? store.state.cashWalletState
                    .communities[token.communityAddress].metadata
                    .getImageUri()
                : null))
        .toList();
    return TokensListViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: [...homeTokens, ...foreignTokens]
        ..where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        ..sort((tokenA, tokenB) => (tokenB?.amount ?? BigInt.zero)
            ?.compareTo(tokenA?.amount ?? BigInt.zero)),
    );
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}
