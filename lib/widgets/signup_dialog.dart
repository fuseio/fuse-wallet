import 'package:flutter/material.dart';
import 'package:gooddollar/generated/i18n.dart';
import 'dart:core';

import 'package:gooddollar/widgets/primary_button.dart';

class SignupDialog extends StatefulWidget {
  SignupDialog();

  @override
  createState() => new SignupDialogState();
}

class SignupDialogState extends State<SignupDialog>
    with SingleTickerProviderStateMixin {
  SignupDialogState();

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
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(I18n.of(context).why_do_we_need_this,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.0),
                    Text(
                        "The GoodDollar stores private information locally on the device. Only the phone number is used to be able to verify your identity and reduce friction when sending money to phone contacts.",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 20.0),
                    Text(
                        "Fuse will never share this information with 3rd party.",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 20.0),
                    Text("For more information: ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                    InkWell(
                        onTap: () {
                          // TODO - link to privacy policy
                        },
                        child: Text("Fuse.io/privacy",
                            style: TextStyle(
                                color: Color(0xFF0076FF),
                                fontSize: 18,
                                fontWeight: FontWeight.normal))),
                    SizedBox(height: 40.0),
                    Center(
                        child: PrimaryButton(
                      label: "OK Thanks",
                      fontSize: 16,
                      width: 120,
                      labelFontWeight: FontWeight.normal,
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
