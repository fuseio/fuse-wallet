import 'package:flutter/material.dart';
import 'dart:core';

import 'package:fusecash/widgets/primary_button.dart';

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
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Why do we need this?",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    Text(
                        "The roost wallet stores private information locally on the device. Only the phone number is used to be able to verify your identity and reduce friction when sending money to phone contacts.",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20.0),
                    Text(
                        "Roost will never share this information with 3rd party.",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20.0),
                    Text("For more information: ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                    InkWell(
                        onTap: () {
                          // TODO - link to privacy policy
                        },
                        child: Text("Fuse.io/privacy",
                            style: TextStyle(
                                color: Color(0xFF0076FF),
                                fontSize: 14,
                                fontWeight: FontWeight.normal))),
                    const SizedBox(height: 20.0),
                    PrimaryButton(
                      label: "OK Thanks",
                      fontSize: 14,
                      width: 140,
                      labelFontWeight: FontWeight.normal,
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class BonusLetter extends StatelessWidget {
  const BonusLetter(this._letter);

  final String _letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(_letter,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.w500)),
    );
  }
}
