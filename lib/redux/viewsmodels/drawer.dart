// import 'package:equatable/equatable.dart';
// import 'package:fusecash/models/app_state.dart';
// import 'package:fusecash/models/plugins/plugins.dart';
// import 'package:redux/redux.dart';
// import 'package:fusecash/models/community/community.dart';
// import 'package:fusecash/redux/actions/user_actions.dart';
// import 'package:fusecash/utils/addresses.dart' as util;

// class DrawerViewModel extends Equatable {
//   final Function() logout;
//   final String walletAddress;
//   final String avatarUrl;
//   final bool isBackup;
//   final Plugins plugins;
//   final Function() firstName;
//   final bool isFuseDollarCommunity;

//   DrawerViewModel({
//     this.logout,
//     this.plugins,
//     this.isBackup,
//     this.walletAddress,
//     this.avatarUrl,
//     this.firstName,
//     this.isFuseDollarCommunity,
//   });

//   static DrawerViewModel fromStore(Store<AppState> store) {
//     String communityAddress = store.state.cashWalletState.communityAddress;
//     Community community =
//         store.state.cashWalletState.communities[communityAddress]!;
//     return DrawerViewModel(
//       isBackup: store.state.userState.backup,
//       walletAddress: store.state.userState.walletAddress,
//       plugins: community.plugins ?? Plugins(),
//       avatarUrl: store.state.userState.avatarUrl,
//       isFuseDollarCommunity: util.isFuseDollarCommunity(communityAddress),
//       logout: () {
//         store.dispatch(logoutCall());
//       },
//       firstName: () {
//         String fullName = store.state.userState.displayName ?? '';
//         return fullName.split(' ')[0];
//       },
//     );
//   }

//   @override
//   List get props => [
//         walletAddress,
//         plugins,
//         isFuseDollarCommunity,
//       ];
// }
