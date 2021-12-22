// import 'dart:core';
// import 'package:auto_route/auto_route.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_segment/flutter_segment.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fusecash/generated/i18n.dart';
// import 'package:fusecash/models/app_state.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:fusecash/redux/viewsmodels/drawer.dart';
// import 'package:fusecash/features/home/router/home_router.gr.dart';
// import 'package:fusecash/utils/format.dart';
// import 'package:fusecash/utils/webview.dart';
// import 'package:fusecash/common/router/routes.gr.dart';

// class DrawerWidget extends StatefulWidget {
//   @override
//   _DrawerWidgetState createState() => _DrawerWidgetState();
// }

// class _DrawerWidgetState extends State<DrawerWidget> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget getListTile(
//     String label,
//     void Function() onTap, {
//     String icon,
//     Widget rightIcon,
//   }) {
//     return ListTile(
//       contentPadding: EdgeInsets.only(
//         top: 5,
//         bottom: 5,
//         left: 10,
//         right: 10,
//       ),
//       onTap: onTap,
//       title: Padding(
//         padding: EdgeInsets.only(
//           left: 10,
//         ),
//         child: Stack(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 SvgPicture.asset(
//                   'assets/images/' '$icon',
//                   width: 25,
//                   height: 25,
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 Text(
//                   label,
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//             rightIcon != null
//                 ? Positioned(
//                     right: 10,
//                     bottom: 0,
//                     child: rightIcon,
//                   )
//                 : SizedBox.shrink()
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> pluginsItems(DrawerViewModel viewModel) {
//     List<Widget> plugins = [];
//     List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
//     if (depositPlugins.isNotEmpty) {
//       plugins.add(Divider(
//         color: Color(0xFFE8E8E8),
//       ));
//       plugins.add(ListTile(
//         contentPadding: EdgeInsets.only(
//           top: 5,
//           bottom: 5,
//           left: 10,
//           right: 10,
//         ),
//         title: Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: Row(
//             children: <Widget>[
//               SvgPicture.asset(
//                 'assets/images/top_up.svg',
//                 width: 25,
//                 height: 25,
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 I18n.of(context).top_up_your_account,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         onTap: () async {
//           ExtendedNavigator.root.pop();
//           String url = depositPlugins[0].widgetUrl;
//           if (viewModel.isFuseDollarCommunity) {
//             openDepositWebview(
//               withBack: true,
//               url: url,
//               title: I18n.of(context).top_up,
//             );
//           } else {
//             ExtendedNavigator.root.pushWebview(
//               withBack: true,
//               url: url,
//               title: I18n.of(context).top_up,
//             );
//           }
//           Segment.track(eventName: 'User clicked on top up');
//         },
//       ));
//     }

//     return plugins;
//   }

//   List<Widget> menuItem(DrawerViewModel viewModel) {
//     return [
//       getListTile(I18n.of(context).switch_community, () {
//         ExtendedNavigator.root.pop();
//         ExtendedNavigator.named('homeRouter').pushSwitchCommunityScreen();
//       }, icon: 'switch_icon.svg'),
//       getListTile(I18n.of(context).backup_wallet, () {
//         ExtendedNavigator.root.pop();
//         ExtendedNavigator.named('homeRouter').pushShowMnemonic();
//       },
//           icon: 'backup_icon.svg',
//           rightIcon: !viewModel.isBackup
//               ? SvgPicture.asset(
//                   'assets/images/back_up_icon.svg',
//                   width: 17,
//                   height: 17,
//                 )
//               : null),
//       getListTile(I18n.of(context).settings, () {
//         ExtendedNavigator.root.pop();
//         ExtendedNavigator.named('homeRouter').pushSettingsScreen();
//       }, icon: 'settings_icon.svg'),
//     ];
//   }

//   Widget drawerHeader(DrawerViewModel viewModel) {
//     return DrawerHeader(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.secondary,
//         border: Border(
//           bottom: BorderSide(
//             color: Color(0xFFE8E8E8),
//           ),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           InkWell(
//             focusColor: Theme.of(context).canvasColor,
//             highlightColor: Theme.of(context).canvasColor,
//             onTap: () {
//               ExtendedNavigator.root.pop();
//               ExtendedNavigator.named('homeRouter').pushProfileScreen();
//             },
//             child: Padding(
//               padding: EdgeInsets.only(
//                 top: 10,
//                 bottom: 15,
//                 left: 10,
//                 right: 10,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: CachedNetworkImage(
//                           imageUrl: viewModel.avatarUrl,
//                           placeholder: (context, url) =>
//                               CircularProgressIndicator(),
//                           errorWidget: (context, url, error) => Image.asset(
//                             'assets/images/anom.png',
//                             width: 50,
//                             height: 50,
//                           ),
//                           imageBuilder: (context, imageProvider) => Image(
//                             image: imageProvider,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 10),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               (viewModel?.firstName() ?? ''),
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             viewModel.walletAddress != null
//                                 ? Row(
//                                     children: <Widget>[
//                                       Text(
//                                         Formatter.formatEthAddress(viewModel.walletAddress),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                     ],
//                                   )
//                                 : SizedBox.shrink()
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SvgPicture.asset(
//                     'assets/images/header_arrow.svg',
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext _context) {
//     return new StoreConnector<AppState, DrawerViewModel>(
//       distinct: true,
//       converter: DrawerViewModel.fromStore,
//       builder: (_, viewModel) {
//         return SizedBox(
//           width: MediaQuery.of(context).size.width * 0.78,
//           child: Drawer(
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                   flex: 5,
//                   child: ListView(
//                     padding: EdgeInsets.all(0),
//                     children: <Widget>[
//                       drawerHeader(viewModel),
//                       ...menuItem(viewModel),
//                       ...pluginsItems(viewModel),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
