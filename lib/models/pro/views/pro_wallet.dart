import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community.dart';
import 'package:fusecash/models/jobs/swap_token_job.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:wallet_core/wallet_core.dart' show EtherAmount, EtherUnit;

class ProWalletViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final List<SwapTokenJob> swapActions;
  final bool hasTrasnferdToForeign;

  ProWalletViewModel(
      {this.walletAddress,
      this.hasTrasnferdToForeign,
      this.tokens,
      this.swapActions});

  static ProWalletViewModel fromStore(Store<AppState> store) {
    List<Token> tokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .where((Token token) => EtherAmount.inWei(token.amount).getValueInUnit(EtherUnit.ether) > 0)
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
        !store.state.proWalletState.erc20Tokens.containsKey(daiTokenAddress);

    List<SwapTokenJob> swaps = List<SwapTokenJob>.from(
        store.state.proWalletState.swapActions?.values ?? Iterable.empty());
    return ProWalletViewModel(
        hasTrasnferdToForeign: hasTrasnferdToForeign,
        walletAddress: store.state.userState.walletAddress,
        tokens: tokens..sort((tokenA, tokenB) => tokenB.amount.compareTo(tokenA.amount)),
        swapActions: swaps);
  }

  @override
  List<Object> get props =>
      [walletAddress, tokens, hasTrasnferdToForeign, swapActions];
}
