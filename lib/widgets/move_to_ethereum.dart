import 'package:auto_route/auto_route.dart';
import 'package:curadai/constans/keys.dart';
import 'package:curadai/models/tokens/token.dart';
import 'package:flutter/material.dart';
import 'package:curadai/generated/i18n.dart';
import 'package:curadai/models/community/community.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:curadai/screens/contacts/send_amount_arguments.dart';
import 'package:curadai/screens/routes.gr.dart';
import 'dart:core';

import 'package:curadai/utils/constans.dart';

class TokenActionsDialog extends StatefulWidget {
  TokenActionsDialog({this.token, this.community, this.logo});
  final String logo;
  final Token token;
  final Community community;
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
    final bool isFuseToken = ![null, ''].contains(widget.token.originNetwork);
    final String accountAddress = widget.community.isMultiBridge
        ? isFuseToken
            ? getBridgeMediator(
                networkType: widget.token.originNetwork, bridgeType: 'home')
            : getBridgeMediator(networkType: widget.token.originNetwork)
        : isFuseToken
            ? widget.community.homeBridgeAddress
            : widget.community.foreignBridgeAddress;
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/${isFuseToken ? 'move_from_fuse.svg' : 'move_to_ethereum.svg'}',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        widget.community == null
                            ? SizedBox.shrink()
                            : InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    color: Theme.of(context).backgroundColor,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      isFuseToken
                                          ? I18n.of(context).move_to +
                                              ' Ethereum'
                                          : I18n.of(context).move_to + ' Fuse',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  ExtendedNavigator.root.pushSendAmountScreen(
                                      pageArgs: SendAmountArguments(
                                          tokenToSend: widget.token,
                                          isMultiBridge:
                                              widget.community.isMultiBridge,
                                          accountAddress: accountAddress,
                                          useBridge: true,
                                          name:
                                              isFuseToken ? 'Ethereum' : 'Fuse',
                                          avatar: AssetImage(
                                            'assets/images/ethereume_icon.png',
                                          )));
                                },
                              ),
                        widget.community == null
                            ? SizedBox.shrink()
                            : Padding(
                                padding: EdgeInsets.all(8.0),
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
                            width: MediaQuery.of(context).size.width * .55,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                color: Theme.of(context).backgroundColor,
                                shape: BoxShape.rectangle),
                            child: Center(
                              child: Text(I18n.of(context).send_to_address,
                                  style: TextStyle(fontSize: 14)),
                            ),
                          ),
                          onTap: () {
                            final BottomNavigationBar navigationBar =
                                AppKeys.bottomBarKey.currentWidget;
                            Navigator.of(context).pop();
                            navigationBar.onTap(1);
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
