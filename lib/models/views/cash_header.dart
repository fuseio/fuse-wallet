import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:fusecash/models/pro/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/addresses.dart' as util;

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final String walletStatus;
  final String usdValue;
  final bool hasErc20Tokens;
  final Community community;
  final Plugins plugins;
  final Token token;
  final bool isDefaultCommunity;

  CashHeaderViewModel({
    this.usdValue,
    this.firstName,
    this.walletStatus,
    this.hasErc20Tokens,
    this.community,
    this.token,
    this.plugins,
    this.isDefaultCommunity,
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
    final bool isDefaultCommunity = util.isDefaultCommunity(communityAddress);
    final Token token = isDefaultCommunity
        ? store.state.cashWalletState.tokens[community?.homeTokenAddress]
            ?.copyWith(symbol: '\$')
        : store.state.cashWalletState.tokens[community?.homeTokenAddress];
    return CashHeaderViewModel(
      isDefaultCommunity: isDefaultCommunity,
      plugins: community?.plugins,
      community: community,
      token: token,
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
        community,
        walletStatus,
        plugins,
        usdValue,
        hasErc20Tokens,
        token,
        isDefaultCommunity,
      ];
}
