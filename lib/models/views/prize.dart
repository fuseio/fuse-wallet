import 'package:equatable/equatable.dart';
import 'package:fusecash/models/draw_info.dart';
import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community.dart';

class PrizeViewModel extends Equatable {
  final Community community;
  final Function() firstName;
  final DrawInfo drawInfo;

  PrizeViewModel({this.community, this.firstName, this.drawInfo});

  static PrizeViewModel fromStore(Store<AppState> store) {
    String communityAddres = store.state.cashWalletState.communityAddress;
    Community community = store.state.cashWalletState.communities[communityAddres] ?? new Community.initial();
    return PrizeViewModel(
      community: community,
      drawInfo: store.state.cashWalletState.drawInfo,
      firstName: () {
        String fullName = store.state.userState.displayName ?? '';
        return fullName.split(' ')[0];
      });
  }

  @override
  List<Object> get props => [community];
}