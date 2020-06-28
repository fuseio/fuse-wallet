import 'package:equatable/equatable.dart';
import 'package:paywise/models/community.dart';
import 'package:paywise/models/pro/token.dart';
import 'package:paywise/models/transactions/transfer.dart';
import 'package:paywise/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:paywise/models/app_state.dart';

class ProWalletViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;
  final bool hasTrasnferdToForeign;

  ProWalletViewModel({
    this.walletAddress,
    this.hasTrasnferdToForeign,
    this.tokens
  });

  static ProWalletViewModel fromStore(Store<AppState> store) {
    List<Token> tokens = List<Token>.from(store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty());
    Community community = store.state.cashWalletState.communities[defaultCommunityAddress];
    bool hasTrasnferdToForeign = community.transactions.list.any((item) {
        Transfer transfer = item as Transfer;
        return (transfer?.to?.toLowerCase() == community?.homeBridgeAddress?.toLowerCase()) ?? false;
      }) && !store.state.proWalletState.erc20Tokens.containsKey(daiTokenAddress);
    return ProWalletViewModel(
      hasTrasnferdToForeign: hasTrasnferdToForeign,
      walletAddress: store.state.userState.walletAddress,
      tokens: tokens,
    );
  }

  @override
  List<Object> get props => [
    walletAddress,
    tokens,
    hasTrasnferdToForeign
  ];
}