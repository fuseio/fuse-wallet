import 'package:equatable/equatable.dart';
import 'package:farmly_ledger/models/community.dart';
import 'package:farmly_ledger/models/pro/token.dart';
import 'package:farmly_ledger/models/transactions/transfer.dart';
import 'package:farmly_ledger/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:farmly_ledger/models/app_state.dart';

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
    List<Token> tokens = store.state.proWalletState?.tokens ?? [];
    Community community = store.state.cashWalletState.communities[defaultCommunityAddress];
    bool hasTrasnferdToForeign = community.transactions.list.any((item) {
        Transfer transfer = item as Transfer;
        return (transfer?.to?.toLowerCase() == community?.homeBridgeAddress?.toLowerCase()) ?? false;
      }) && !tokens.any((token) => token?.address == daiTokenAddress);
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