import 'package:equatable/equatable.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/pro/pro_wallet_state.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/utils/format.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';

class CashHeaderViewModel extends Equatable {
  final Function() firstName;
  final String walletStatus;
  final bool hasErc20Tokens;
  final Community community;
  final String dzarValue;

  CashHeaderViewModel(
      {this.dzarValue,
      this.firstName,
      this.walletStatus,
      this.hasErc20Tokens,
      this.community});

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
            new Community.initial();
    num dzarValue = store.state.userState?.totalBalance ?? 0;
    return CashHeaderViewModel(
        community: community,
        dzarValue: reduce(dzarValue),
        hasErc20Tokens: erc20Tokens.isNotEmpty,
        walletStatus: store.state.userState.walletStatus,
        firstName: () {
          String fullName = store.state.userState.displayName ?? '';
          return fullName.split(' ')[0];
        });
  }

  @override
  List<Object> get props =>
      [community, walletStatus, dzarValue, hasErc20Tokens];
}
