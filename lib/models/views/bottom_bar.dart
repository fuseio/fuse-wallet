import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';

class BottomBarViewModel extends Equatable {
  final String communityAddres;
  BottomBarViewModel({this.communityAddres});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    return BottomBarViewModel(
        communityAddres: store.state.cashWalletState.communityAddress);
  }

  @override
  List<Object> get props => [communityAddres];
}
