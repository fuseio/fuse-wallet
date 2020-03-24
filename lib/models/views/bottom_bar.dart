import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:localdollarmx/models/app_state.dart';
import 'package:localdollarmx/utils/addresses.dart' as util;

class BottomBarViewModel extends Equatable {
  final String communityAddres;
  final bool isDefaultCommunity;
  BottomBarViewModel({this.communityAddres, this.isDefaultCommunity});

  static BottomBarViewModel fromStore(Store<AppState> store) {
    String communityAddress = store.state.cashWalletState.communityAddress;
    return BottomBarViewModel(
        communityAddres: communityAddress,
        isDefaultCommunity: util.isDefaultCommunity(communityAddress));
  }

  @override
  List<Object> get props => [communityAddres];
}
