import 'package:equatable/equatable.dart';
import 'package:straitsx/models/community/community.dart';
import 'package:straitsx/models/pro/pro_wallet_state.dart';
import 'package:straitsx/models/tokens/token.dart';
import 'package:straitsx/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:straitsx/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final String walletStatus;
  final String usdValue;
  final bool hasErc20Tokens;
  final Community community;
  final Token token;

  CashHeaderViewModel(
      {this.usdValue,
      this.firstName,
      this.walletStatus,
      this.hasErc20Tokens,
      this.community,
      this.token});

  static CashHeaderViewModel fromStore(Store<AppState> store) {
    ProWalletState proWalletState = store.state.proWalletState;
    List<Token> erc20Tokens =
        List<Token>.from(proWalletState.erc20Tokens?.values ?? Iterable.empty())
            .where((Token token) =>
                num.parse(formatValue(token.amount, token.decimals,
                        withPrecision: true))
                    .compareTo(0) ==
                1)
            .toList();
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddres] ??
            Community.initial();
    num usdValue = store.state.userState?.totalBalance ?? 0;
    return CashHeaderViewModel(
        community: community,
        token: store.state.cashWalletState.tokens[community?.homeTokenAddress],
        hasErc20Tokens: erc20Tokens.isNotEmpty,
        usdValue: reduce(usdValue),
        walletStatus: store.state.userState.walletStatus,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props => [community, walletStatus, usdValue, hasErc20Tokens];
}
