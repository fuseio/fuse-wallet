import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:core';

class SignupDialog extends StatefulWidget {
  SignupDialog();

  @override
  createState() => new SignupDialogState();
}

class SignupDialogState extends State<SignupDialog> with SingleTickerProviderStateMixin {
  SignupDialogState();

  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  @override
  void initState() {
    super.initState();

     controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
          scale: scaleAnimatoin,
          child: AlertDialog(
          contentPadding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Stack(
            children: <Widget>[
              Container(
                //height: 400,
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Why do we need this?",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                             Text("The fuse wallet stores private information locally on the device. Only the phone number is used to be able to verify your identity and reduce friction when sending money to phone contacts.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                            Text("Fuse will never share this information with 3rd party.",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                            Text("For more information: Fuse.io\privacy",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Theme.of(context).primaryColor,
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 70, right: 70),
                        child: Text(
                          "Start",
                          style: TextStyle(
                              color: const Color(0xFFfae83e),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
);
  }
}

class BonusLetter extends StatelessWidget {
  const BonusLetter(this._letter);

  final String _letter;

  @override
  Widget build(BuildContext context) {
    return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 5),
                            decoration: new BoxDecoration(
                                border: new Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Text(_letter,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500)),
                          );
  }
}