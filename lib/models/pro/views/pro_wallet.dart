import 'package:equatable/equatable.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class ProWalletViewModel extends Equatable {
  final String walletAddress;
  final List<Token> tokens;

  ProWalletViewModel({
    this.walletAddress,
    this.tokens
  });

  static ProWalletViewModel fromStore(Store<AppState> store) {
    return ProWalletViewModel(
      walletAddress: store.state.userState.walletAddress,
      tokens: store.state.proWalletState?.tokens ?? []
    );
  }

  @override
  List<Object> get props => [
    walletAddress,
    tokens
  ];
}