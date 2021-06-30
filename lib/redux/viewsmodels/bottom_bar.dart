// import 'package:equatable/equatable.dart';
// import 'package:fusecash/models/app_state.dart';
// import 'package:redux/redux.dart';
// import 'package:fusecash/utils/addresses.dart' as util;

// class BottomBarViewModel extends Equatable {
//   final bool isDefaultCommunity;

//   BottomBarViewModel({
//     required this.isDefaultCommunity,
//   });

//   static BottomBarViewModel fromStore(Store<AppState> store) {
//     String communityAddress = store.state.cashWalletState.communityAddress;
//     return BottomBarViewModel(
//       isDefaultCommunity: util.isDefaultCommunity(communityAddress),
//     );
//   }

//   @override
//   List<Object> get props => [isDefaultCommunity];
// }
