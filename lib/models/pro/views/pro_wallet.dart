import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/community.dart';
import 'package:digitalrand/models/pro/token.dart';
import 'package:digitalrand/models/transactions/transfer.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';

class ProWalletViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final bool hasTrasnferdToForeign;

  ProWalletViewModel(
      {this.walletAddress,
      this.hasTrasnferdToForeign,
      this.tokens,});

  static ProWalletViewModel fromStore(Store<AppState> store) {
    List<Token> tokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) => num.parse(formatValue(token.amount, token.decimals, withPrecision: false)).compareTo(0) == 1)
        .toList()
        .reversed
        .toList();
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    bool hasTrasnferdToForeign = community.transactions.list.any((item) {
          Transfer transfer = item as Transfer;
          return (transfer?.to?.toLowerCase() ==
                  community?.homeBridgeAddress?.toLowerCase()) ??
              false;
        }) &&
        !store.state.proWalletState.erc20Tokens.containsKey(daiTokenAddress.toLowerCase());

    return ProWalletViewModel(
        hasTrasnferdToForeign: hasTrasnferdToForeign,
        walletAddress: store.state.userState.walletAddress,
        tokens: tokens..sort((tokenA, tokenB) => tokenB.amount.compareTo(tokenA.amount)),);
  }

  @override
  List<Object> get props =>
      [walletAddress, tokens, hasTrasnferdToForeign];
}
