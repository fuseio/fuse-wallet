import 'package:digitalrand/models/tokens/token.dart';
import 'package:digitalrand/screens/routes.gr.dart';
import 'package:digitalrand/screens/send/send_amount.dart';
import 'package:digitalrand/screens/send/send_amount_arguments.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/generated/i18n.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'dart:core';

class TokenActionsDialog extends StatefulWidget {
  TokenActionsDialog({this.token, this.canMoveToOtherChain});
  final bool canMoveToOtherChain;
  final Token token;
  @override
  createState() => TokenActionsDialogState();
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
                          SizedBox(height: 20.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              !widget.canMoveToOtherChain
                                  ? SizedBox.shrink()
                                  : InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .55,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color:
                                              Theme.of(context).backgroundColor,
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
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SendAmountScreen(
                                                          pageArgs:
                                                              SendAmountArguments(
                                                                  avatar:
                                                                      AssetImage(
                                                                    'assets/images/ethereume_icon.png',
                                                                  ),
                                                                  name:
                                                                      'ethereum',
                                                                  accountAddress:
                                                                      vm.homeBridgeAddress))));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SendAmountScreen(
                                                          pageArgs:
                                                              SendAmountArguments(
                                                                  avatar:
                                                                      AssetImage(
                                                                    'assets/images/ethereume_icon.png',
                                                                  ),
                                                                  name: 'fuse',
                                                                  accountAddress:
                                                                      vm.foreignBridgeAddress))));
                                        }
                                      },
                                    ),
                              !widget.canMoveToOtherChain
                                  ? SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        I18n.of(context).or,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                      ),
                                    ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      color: Theme.of(context).backgroundColor,
                                      shape: BoxShape.rectangle),
                                  child: Center(
                                    child: Text(
                                        I18n.of(context).send_to_address,
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                                onTap: () {
                                  Router.navigator.pushNamedAndRemoveUntil(
                                      Router.cashHomeScreen,
                                      (Route<dynamic> route) => false,
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
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  TokenActionsDialogViewModel({
    this.homeBridgeAddress,
    this.foreignBridgeAddress,
  });

  static TokenActionsDialogViewModel fromStore(Store<AppState> store) {
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return TokenActionsDialogViewModel(
      homeBridgeAddress: community.homeBridgeAddress,
      foreignBridgeAddress: community.foreignBridgeAddress,
    );
  }

  @override
  List<Object> get props => [homeBridgeAddress, foreignBridgeAddress];
}
