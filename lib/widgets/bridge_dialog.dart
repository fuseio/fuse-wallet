import 'dart:core';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/community/community.dart';
import 'package:roost/models/tokens/token.dart';
import 'package:roost/widgets/move_to_ethereum.dart';
import 'package:roost/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BridgeDialog extends StatefulWidget {
  final String logo;
  final Token token;
  final bool isFuseToken;
  final Community community;
  BridgeDialog({this.logo, this.community, this.token, this.isFuseToken});
  @override
  _BridgeDialogState createState() => _BridgeDialogState();
}

class _BridgeDialogState extends State<BridgeDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimatoin;
  bool isPreloading = false;
  String network;

  @override
  void initState() {
    super.initState();
    setState(() {
      network = widget.isFuseToken != null && !widget.isFuseToken
          ? 'Ethereum'
          : 'Fuse';
    });
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/${widget.logo}",
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0, bottom: 10, left: 10, right: 10),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              I18n.of(context).bridge_to +
                                  ' ${network == 'Fuse' ? 'Ethereum' : 'Fuse'}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                                "This token is held on your account on the $network network. It's possible to use the bridge to move this token to your same account on ${network == 'Fuse' ? 'Ethereum' : 'Fuse'}. The only difference between holding this token on Ethereum and Fuse is the fees to send it are much more expensive on Ethereum."),
                            SizedBox(height: 30.0),
                            Center(
                                child: PrimaryButton(
                              fontSize: 15,
                              preload: isPreloading,
                              labelFontWeight: FontWeight.normal,
                              label: I18n.of(context).move_to +
                                  ' ${network == 'Fuse' ? 'Ethereum' : 'Fuse'}',
                              onPressed: () async {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        TokenActionsDialog(
                                            token: widget.token,
                                            community: widget.community));
                              },
                            )),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
