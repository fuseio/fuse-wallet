import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:roost/models/app_state.dart';

class BottomBarViewModel extends Equatable {
  final String walletAddress;
  BottomBarViewModel({this.walletAddress});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    return BottomBarViewModel(
        walletAddress: store.state.cashWalletState.walletAddress);
  }

  @override
  List<Object> get props => [walletAddress];
}
