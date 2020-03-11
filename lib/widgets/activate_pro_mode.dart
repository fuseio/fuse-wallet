import 'package:flutter/material.dart';
import 'package:fusecash/screens/routes.gr.dart';
import 'package:fusecash/widgets/activate_pro_mode2.dart';
import 'dart:core';

class ActivateProModeDialog extends StatefulWidget {
  @override
  createState() => new ActivateProModeDialogState();
}

class ActivateProModeDialogState extends State<ActivateProModeDialog>
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

  Widget activateButton() {
    return Container(
        width: 260.0,
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            border: Border.all(
                color: Theme.of(context).primaryColor.withAlpha(14))),
        child: InkWell(
          onTap: () {
            Router.navigator.pop();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ActivateProMode2Dialog();
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Activate pro mode',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                        "In order to witdraw DAI to Ethereum we first need to transfer it from Fuse to Ethereum mainnet.",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20.0),
                    Text(
                        "Click on Activate pro mode to enable Ethereum support in your wallet:",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20.0),
                    activateButton()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
