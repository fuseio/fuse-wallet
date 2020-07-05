import 'package:fusecash/utils/transaction_row.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/pro_mode/token_tile.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/utils/format.dart';

String getTokenUrl(tokenAddress) {
  return tokenAddress == zeroAddress
      ? 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'
      : "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/$tokenAddress/logo.png";
}

class AssetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        body: Column(children: <Widget>[
          Expanded(
              child: ListView(children: [
            StoreConnector<AppState, _AssetsListViewModel>(
                distinct: true,
                converter: _AssetsListViewModel.fromStore,
                builder: (_, viewModel) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ListView(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.only(left: 15, right: 15),
                              children: [
                                ...viewModel.tokens
                                    .map((Token token) => TokenTile(
                                          token: token,
                                        ))
                                    .toList()
                              ])
                        ]))
          ])),
        ]));
  }
}

class _AssetsListViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  _AssetsListViewModel({
    this.walletAddress,
    this.tokens,
  });

  static _AssetsListViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: false))
                .compareTo(0) ==
            1)
        .toList();

    List<Token> homeTokens = communities
        .map((Community community) => community.token
            .copyWith(imageUrl: getIPFSImageUrl(community.metadata.image)))
        .toList();
    return _AssetsListViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: [...homeTokens, ...foreignTokens]..sort((tokenA, tokenB) {
          if (tokenB.amount != null && tokenA?.amount != null) {
            return tokenB?.amount?.compareTo(tokenA?.amount);
          }
          return tokenA.hashCode.compareTo(tokenB.hashCode);
        }),
    );
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}
