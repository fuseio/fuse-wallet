import 'package:equatable/equatable.dart';
import 'package:peepl/models/community/community.dart';
import 'package:peepl/models/pro/pro_wallet_state.dart';
import 'package:peepl/models/tokens/token.dart';
import 'package:peepl/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:peepl/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final String walletStatus;
  final String usdValue;
  final bool hasErc20Tokens;
  final Community community;
  final Token token;
  final Token secondaryToken;

  CashHeaderViewModel({
    this.usdValue,
    this.firstName,
    this.walletStatus,
    this.hasErc20Tokens,
    this.community,
    this.token,
    this.secondaryToken,
  });

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
    String communityAddress = store.state.cashWalletState.communityAddress;
    Community community =
        store.state.cashWalletState.communities[communityAddress] ??
            Community.initial();
    num usdValue = store.state.userState?.totalBalance ?? 0;

    final Token token = store.state.cashWalletState.tokens
            .containsKey(community?.homeTokenAddress?.toLowerCase())
        ? store.state.cashWalletState
            .tokens[community?.homeTokenAddress?.toLowerCase()]
        : store.state.cashWalletState.tokens[community?.homeTokenAddress];

    final Token secondaryToken = store.state.cashWalletState.tokens
            .containsKey(community?.secondaryTokenAddress?.toLowerCase())
        ? store.state.cashWalletState
            .tokens[community?.secondaryTokenAddress?.toLowerCase()]
        : store.state.cashWalletState.tokens[community?.secondaryTokenAddress];

    return CashHeaderViewModel(
      community: community,
      token: token,
      secondaryToken: secondaryToken,
      hasErc20Tokens: erc20Tokens.isNotEmpty,
      usdValue: reduce(usdValue),
      walletStatus: store.state.userState.walletStatus,
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      },
    );
  }

  @override
  List<Object> get props => [
        secondaryToken,
        token,
        community,
        walletStatus,
        usdValue,
        hasErc20Tokens,
      ];
}
