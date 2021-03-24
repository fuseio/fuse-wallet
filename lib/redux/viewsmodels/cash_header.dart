import 'package:equatable/equatable.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/pro_wallet_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/utils/format.dart';
import 'package:number_display/number_display.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/utils/addresses.dart' as util;

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final String usdValue;
  final bool hasErc20Tokens;
  final Community community;
  final Token token;

  CashHeaderViewModel({
    this.usdValue,
    this.firstName,
    this.hasErc20Tokens,
    this.community,
    this.token,
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
            Community();
    num usdValue = store.state.userState?.totalBalance ?? 0;
    final bool isDefaultCommunity = util.isDefaultCommunity(communityAddress);
    final Token token = isDefaultCommunity
        ? store.state.cashWalletState.tokens[community?.homeTokenAddress]
            ?.copyWith(symbol: '\$')
        : store.state.cashWalletState.tokens[community?.homeTokenAddress];
    final display = createDisplay(
      length: 5,
      decimal: 2,
    );
    return CashHeaderViewModel(
      community: community,
      token: token,
      hasErc20Tokens: erc20Tokens.isNotEmpty,
      usdValue: display(usdValue),
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      },
    );
  }

  @override
  List<Object> get props => [
        community,
        usdValue,
        hasErc20Tokens,
        token,
      ];
}
