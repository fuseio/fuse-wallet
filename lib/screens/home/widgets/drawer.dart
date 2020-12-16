import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/svg.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/models/views/drawer.dart';
import 'package:esol/screens/routes.gr.dart';
import 'package:esol/utils/forks.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

class DrawerWidget extends StatefulWidget {
  final int currentIndex;
  DrawerWidget({this.currentIndex});
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final assetIdController = TextEditingController(text: "");
  String userName = "";

  @override
  void initState() {
    super.initState();
  }

  Widget getListTile(String label, void Function() onTap,
      {String icon, Widget temp}) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
      title: Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/' '$icon',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                temp != null
                    ? Positioned(
                        right: 0,
                        bottom: 0,
                        child: temp,
                      )
                    : SizedBox.shrink()
              ],
            )),
      ),
      onTap: onTap,
    );
  }

  List<Widget> pluginsItems(DrawerViewModel viewModel) {
    List<Widget> plugins = [];
    List depositPlugins = viewModel?.plugins?.getDepositPlugins() ?? [];
    if (depositPlugins.isNotEmpty) {
      plugins.add(new Divider(
        color: Color(0xFFE8E8E8),
      ));
      plugins.add(ListTile(
        contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
        title: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/top_up.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                I18n.of(context).top_up,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        onTap: () {
          ExtendedNavigator.root.pop();
          dynamic url = depositPlugins[0].generateUrl();
          ExtendedNavigator.root.push(Routes.webview,
              arguments: WebViewPageArguments(
                  withBack: true, url: url, title: I18n.of(context).top_up));
          Segment.track(eventName: 'User clicked on top up');
        },
      ));
    }

    return plugins;
  }

  List<Widget> menuItem(DrawerViewModel viewModel) {
    if (isFork()) {
      return [
        getListTile(I18n.of(context).backup_wallet, () {
          ExtendedNavigator.root.pop();
          // Navigator.push(context, HomeRoutes.showMnemonic);
          // ExtendedNavigator.named('BusinessesRoutes')
          //     .push(HomeRoutes.showMnemonic);
          ExtendedNavigator.root.push(Routes.showMnemonic);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ShowMnemonic()),
          // );
        },
            icon: 'backup_icon.svg',
            temp: !viewModel.isBackup
                ? SvgPicture.asset(
                    'assets/images/back_up_icon.svg',
                    width: 17,
                    height: 17,
                  )
                : null),
        getListTile(I18n.of(context).settings, () {
          ExtendedNavigator.root.pop();
          ExtendedNavigator.root.push(Routes.settingsScreen);
        }, icon: 'settings_icon.svg'),
      ];
    } else {
      return [
        // getListTile(I18n.of(context).switch_community, () {
        //   ExtendedNavigator.root.pop();
        //   ExtendedNavigator.named('homeRouter')
        //       .push(HomeRoutes.switchCommunityScreen);
        // }, icon: 'switch_icon.svg'),
        // getListTile(I18n.of(context).backup_wallet, () {
        //   ExtendedNavigator.root.pop();
        //   ExtendedNavigator.named('homeRouter').push(HomeRoutes.showMnemonic);
        // },
        //     icon: 'backup_icon.svg',
        //     temp: !viewModel.isBackup
        //         ? SvgPicture.asset(
        //             'assets/images/back_up_icon.svg',
        //             width: 17,
        //             height: 17,
        //           )
        //         : null),
        // getListTile(I18n.of(context).about, () {
        //   ExtendedNavigator.root.pop();
        //   ExtendedNavigator.named('homeRouter').push(HomeRoutes.settingsScreen);
        // }, icon: 'settings_icon.svg'),
        // getListTile(context, I18n.of(context).logout, () {
        //   viewModel.logout();
        //   ExtendedNavigator.root.replace(Routes.splashScreen);
        // })
        getListTile(I18n.of(context).contact_us, () {
          // launch('mailto:hello@fuse.io');
        }, icon: 'help.svg'),
        getListTile(I18n.of(context).logout, () {
          viewModel.logout();
          ExtendedNavigator.root.replace(Routes.splashScreen);
        }, icon: 'log_out.svg')
      ];
    }
  }

  // Widget drawerHeader(DrawerViewModel viewModel) {
  //   return DrawerHeader(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         InkWell(
  //           onTap: () {
  //             ExtendedNavigator.root.pop();
  //             ExtendedNavigator.named('homeRouter')
  //                 .push(HomeRoutes.profileScreen);
  //           },
  //           child: Padding(
  //               padding: EdgeInsets.only(top: 10, bottom: 15, left: 10),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: <Widget>[
  //                         SizedBox(
  //                             height: 70,
  //                             width: 70,
  //                             child: ![null, ''].contains(viewModel.avatarUrl)
  //                                 ? ClipRRect(
  //                                     borderRadius: BorderRadius.circular(50),
  //                                     child: Positioned.fill(
  //                                         child: CachedNetworkImage(
  //                                       imageUrl: viewModel.avatarUrl,
  //                                       placeholder: (context, url) =>
  //                                           CircularProgressIndicator(),
  //                                       errorWidget: (context, url, error) =>
  //                                           Image.asset(
  //                                               'assets/images/anom.png',
  //                                               width: 40,
  //                                               height: 40),
  //                                       imageBuilder:
  //                                           (context, imageProvider) => Image(
  //                                         image: imageProvider,
  //                                         fit: BoxFit.fill,
  //                                       ),
  //                                     )),
  //                                   )
  //                                 : CircleAvatar(
  //                                     backgroundImage: new AssetImage(
  //                                         'assets/images/anom.png'),
  //                                     radius: 30,
  //                                   )),
  //                         Padding(
  //                           padding: const EdgeInsets.only(left: 10),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: <Widget>[
  //                               Text(
  //                                 (viewModel?.firstName() ?? ''),
  //                                 style: TextStyle(
  //                                     color: Theme.of(context).primaryColor,
  //                                     fontSize: 22,
  //                                     fontWeight: FontWeight.normal),
  //                               ),
  //                               viewModel.walletAddress != null
  //                                   ? Row(
  //                                       children: <Widget>[
  //                                         Text(
  //                                           formatAddress(
  //                                               viewModel.walletAddress),
  //                                           style: TextStyle(
  //                                               color: Theme.of(context)
  //                                                   .colorScheme
  //                                                   .secondary),
  //                                         ),
  //                                         SizedBox(
  //                                           width: 10,
  //                                         ),
  //                                       ],
  //                                     )
  //                                   : SizedBox.shrink()
  //                             ],
  //                           ),
  //                         ),
  //                       ]),
  //                   SvgPicture.asset(
  //                     'assets/images/header_arrow.svg',
  //                   )
  //                 ],
  //               )),
  //         )
  //       ],
  //     ),
  //     decoration: BoxDecoration(
  //         color: Theme.of(context).backgroundColor,
  //         border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
  //   );
  // }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, DrawerViewModel>(
        distinct: true,
        converter: DrawerViewModel.fromStore,
        builder: (_, viewModel) {
          return SizedBox(
            // width: MediaQuery.of(context).size.width * 1,
            child: SafeArea(
              child: Stack(
                // overflow: Overflow.visible,
                children: [
                  Container(
                    width: double.infinity,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      // bottomRight: Radius.circular(50),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: Drawer(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 8),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 30,
                                ),
                                child:
                                    SvgPicture.asset('assets/images/E-SOL.svg'),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width / 8),
                              // (viewModel.avatarUrl == null)
                              //     ? Padding(
                              //         padding:
                              //             const EdgeInsets.only(right: 8.0),
                              //         child: InkWell(
                              //           onTap: () {
                              //             ExtendedNavigator.root.popUntilRoot();
                              //             ExtendedNavigator.root
                              //                 .push(Routes.profileScreen);
                              //             // if (widget.currentIndex == 0)
                              //             // if (widget.currentIndex == 1)
                              //             //   ExtendedNavigator.named(
                              //             //           'contactsRouter')
                              //             //       .push(ContactsRoutes
                              //             //           .profileScreen);
                              //             // if (widget.currentIndex == 3) {
                              //             //   ExtendedNavigator.named('BuyRouter')
                              //             //       .push(HomeRoutes.profileScreen);
                              //             // }
                              //           },
                              //           child: Container(
                              //             height: 59,
                              //             width: 250,
                              //             decoration: BoxDecoration(
                              //               color: Color.fromRGBO(
                              //                   255, 196, 23, 0.14),
                              //               borderRadius: BorderRadius.only(
                              //                 topRight: Radius.circular(20.0),
                              //                 bottomRight:
                              //                     Radius.circular(20.0),
                              //               ),
                              //             ),
                              //             child: Flexible(
                              //               child: Row(children: [
                              //                 Image.asset(
                              //                     'assets/images/title.png'),
                              //                 Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(8.0),
                              //                   child: Icon(
                              //                     Icons.error,
                              //                     color: Colors.orange,
                              //                   ),
                              //                 ),
                              //                 Column(
                              //                     mainAxisAlignment:
                              //                         MainAxisAlignment.center,
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.center,
                              //                     children: [
                              //                       Text(
                              //                         'Terminar Registrode',
                              //                         style: TextStyle(
                              //                             color: Color.fromRGBO(
                              //                                 255, 196, 23, 1),
                              //                             fontSize: 14,
                              //                             fontWeight:
                              //                                 FontWeight.bold),
                              //                       ),
                              //                       Text(
                              //                         "de mi cuenta",
                              //                         style: TextStyle(
                              //                             color: Color.fromRGBO(
                              //                                 255, 196, 23, 1),
                              //                             fontSize: 14,
                              //                             fontWeight:
                              //                                 FontWeight.bold),
                              //                         textAlign:
                              //                             TextAlign.center,
                              //                       ),
                              //                     ]),
                              //               ]),
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //     : SizedBox.shrink(),
                              // (viewModel.avatarUrl != null)
                              //     ? InkWell(
                              //         child: Padding(
                              //           padding: const EdgeInsets.only(top: 30),
                              //           child: Row(
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 30.0, right: 20.0),
                              //                 child: SvgPicture.asset(
                              //                     'assets/images/cast.svg'),
                              //               ),
                              //               Text(
                              //                 'Respaladar mi',
                              //                 style: TextStyle(fontSize: 16),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //         onTap: () {
                              //           ExtendedNavigator.root.pop();
                              //           ExtendedNavigator.root
                              //               .push(Routes.showMnemonic);
                              //           // if (widget.currentIndex == 0)
                              //           // if (widget.currentIndex == 1)
                              //           //   ExtendedNavigator.named(
                              //           //           'contactsRouter')
                              //           //       .push(
                              //           //           ContactsRoutes.showMnemonic);
                              //           // if (widget.currentIndex == 2) {
                              //           //   // ExtendedNavigator.named(
                              //           //   //         '/receive-screen')
                              //           //   //     .push(HomeRoutes.showMnemonic);
                              //           // }
                              //           // if (widget.currentIndex == 3) {
                              //           //   ExtendedNavigator.named('BuyRouter')
                              //           //       .push(HomeRoutes.showMnemonic);
                              //           // }
                              //           // ExtendedNavigator.named('homeRouter')
                              //           //     .push(HomeRoutes.showMnemonic);
                              //         },
                              //       )
                              //     : SizedBox.shrink(),

                              // (viewModel.avatarUrl != null)
                              //     ? Padding(
                              //         padding: const EdgeInsets.only(left: 72),
                              //         child: Text(
                              //           'monedero',
                              //           style: TextStyle(fontSize: 16),
                              //         ),
                              //       )
                              //     : SizedBox.shrink(),
                              viewModel.isFaceVerified
                                  ? SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                        left: 40,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .45,
                                        decoration: BoxDecoration(
                                            color: Colors.amber[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/alert-icn.png',
                                              fit: BoxFit.cover,
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text('Déjanos Conocerte'),
                                          ],
                                        ),
                                      ),
                                    ),

                              // (viewModel.avatarUrl != null)
                              //     ? InkWell(
                              //         onTap: () {
                              //           Navigator.push(
                              //             context,
                              //             MaterialPageRoute(
                              //               builder: (context) => MainProfile(),
                              //             ),
                              //           );
                              //         },
                              //         child: Padding(
                              //           padding: const EdgeInsets.only(top: 10),
                              //           child: Row(
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 30.0, right: 20.0),
                              //                 child: SvgPicture.asset(
                              //                     'assets/images/profile.svg'),
                              //               ),
                              //               Text(
                              //                 'Mi Cuenta',
                              //                 style: TextStyle(fontSize: 16),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       )
                              //     : SizedBox.shrink(),
                              Expanded(
                                child: SizedBox(),
                              ),
                              ...menuItem(viewModel),
                              // ...pluginsItems(viewModel),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    // right: 80,
                    right: 95,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        height: 50,
                        width: 50,
                        child: Icon(Icons.close),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
