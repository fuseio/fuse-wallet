import 'package:digitalrand/models/plugins/fee_base.dart';
import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/plugins/plugins.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'dart:core';

class TokenActionsDialog extends StatefulWidget {
  TokenActionsDialog({this.token});
  final Token token;
  @override
  createState() => new TokenActionsDialogState();
}

class TokenActionsDialogState extends State<TokenActionsDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    bool isFuseToken = widget.token.originNetwork != null;
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Stack(
            children: <Widget>[
              StoreConnector<AppState, TokenActionsDialogViewModel>(
                  distinct: true,
                  converter: TokenActionsDialogViewModel.fromStore,
                  builder: (_, vm) {
                    return Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/move_from_fuse.svg',
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(5.0)),
                                    color: Theme.of(context).backgroundColor,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      isFuseToken
                                          ? ' Move to Ethereum account'
                                          : 'Move to Fuse',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (isFuseToken) {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                SendAmountScreen(
                                                    pageArgs:
                                                        SendAmountArguments(
                                                            avatar: AssetImage(
                                                              'assets/images/ethereume_icon.png',
                                                            ),
                                                            name: 'ethereum',
                                                            feePlugin:
                                                                vm.feePlugin,
                                                            sendType: SendType
                                                                .ETHEREUM_ADDRESS,
                                                            accountAddress: vm
                                                                .homeBridgeAddress))));
                                  } else {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                SendAmountScreen(
                                                    pageArgs:
                                                        SendAmountArguments(
                                                            avatar: AssetImage(
                                                              'assets/images/ethereume_icon.png',
                                                            ),
                                                            name: 'fuse',
                                                            feePlugin:
                                                                vm.feePlugin,
                                                            sendType: SendType
                                                                .ETHEREUM_ADDRESS,
                                                            accountAddress: vm
                                                                .foreignBridgeAddress))));
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  I18n.of(context).or,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(5.0)),
                                      color: Theme.of(context).backgroundColor,
                                      shape: BoxShape.rectangle),
                                  child: Center(
                                    child: Text('Send to an address',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                                onTap: () {
                                  Router.navigator.pushNamed(
                                      Router.cashHomeScreen,
                                      arguments: CashModeScaffoldArguments(
                                          tabIndex: 1));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

class TokenActionsDialogViewModel extends Equatable {
  final Plugins plugins;
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  final FeePlugin feePlugin;
  TokenActionsDialogViewModel({
    this.plugins,
    this.homeBridgeAddress,
    this.foreignBridgeAddress,
    this.feePlugin,
  });

  static TokenActionsDialogViewModel fromStore(Store<AppState> store) {
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return TokenActionsDialogViewModel(
      plugins: community?.plugins,
      // feePlugin: community.plugins.bridgeToForeign,
      homeBridgeAddress: community.homeBridgeAddress,
      foreignBridgeAddress: community.foreignBridgeAddress,
    );
  }

  @override
  List<Object> get props =>
      [homeBridgeAddress, foreignBridgeAddress, feePlugin, plugins];
}
