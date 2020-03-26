import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:roost/models/community.dart';
import 'package:roost/models/pro/token.dart';
import 'package:roost/models/transactions/transfer.dart';
import 'package:roost/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:roost/models/app_state.dart';

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
    String communityAddres = DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'].toLowerCase();
    Community community = store.state.cashWalletState.communities[communityAddres];
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