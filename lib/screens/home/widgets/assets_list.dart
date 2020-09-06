import 'package:digitalrand/screens/home/widgets/token_tile.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/services.dart';
import 'package:digitalrand/models/app_state.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/constans/exchangable_tokens.dart';

String getTokenUrl(tokenAddress) {
  return tokenAddress == zeroAddress
      ? 'https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/info/logo.png'
      : "https://raw.githubusercontent.com/trustwallet/assets/master/blockchains/ethereum/assets/$tokenAddress/logo.png";
}

class AssetsList extends StatefulWidget {
  @override
  _AssetsListState createState() => _AssetsListState();
}

class _AssetsListState extends State<AssetsList> {
  double dzarQuate;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TokensListViewModel>(
      distinct: true,
      converter: TokensListViewModel.fromStore,
      onInit: (store) async {
        String currency = store.state.userState.currency;
        final Map<String, dynamic> dzarInfo =
            await marketApi.getCoinInfoByAddress(dzarToken.address);
        final String coinId = dzarInfo['id'];
        final Map<String, dynamic> response =
            await marketApi.getCurrentPriceOfToken(coinId, currency);
        double price = response[coinId][currency];
        if (!this.mounted) return;
        setState(() {
          dzarQuate = price;
        });
      },
      builder: (_, viewModel) {
        return Scaffold(
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
                  itemBuilder: (context, index) => TokenTile(
                      token: viewModel.tokens[index],
                      dzarQuate: viewModel.tokens[index].originNetwork ==
                                  null ||
                              viewModel.tokens[index].symbol == dzarToken.symbol
                          ? dzarQuate
                          : null))),
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
    Map communitiesR = store.state.cashWalletState.communities
      ..removeWhere((key, Community community) =>
          [null, ''].contains(community?.token) ||
          [null, ''].contains(community?.name) ||
          [null, ''].contains(community?.address));
    List<Community> communities = communitiesR.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) =>
            num.parse(formatValue(token.amount, token.decimals,
                    withPrecision: true))
                .compareTo(0) ==
            1)
        .toList();

    List<Token> homeTokens = communities
        .map((Community community) => community?.token
            ?.copyWith(imageUrl: community?.metadata?.getImageUri()))
        .toList();
    return TokensListViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: [...homeTokens, ...foreignTokens]..sort((tokenA, tokenB) =>
          (tokenB?.amount ?? BigInt.zero)
              ?.compareTo(tokenA?.amount ?? BigInt.zero)),
    );
  }

  @override
  List<Object> get props => [walletAddress, tokens];
}
