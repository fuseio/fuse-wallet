import 'dart:core';
import 'package:seedbed/screens/home/widgets/drawer.dart';
import 'package:seedbed/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NetworkExplainedScreen extends StatefulWidget {
  final String network;
  NetworkExplainedScreen({this.network});
  @override
  _NetworkExplainedScreenState createState() => _NetworkExplainedScreenState();
}

class _NetworkExplainedScreenState extends State<NetworkExplainedScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimatoin;
  bool isPreloading = false;

  @override
  void initState() {
    super.initState();

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
                      "assets/images/${widget.network}-logo.svg",
                      width: 85,
                      height: 85,
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
                              '''This page shows your assets on the ${widget.network == 'fuse' ? capitalize(widget.network) : 'Ethereum'} network''',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              '''It’s possible to move assets between Ethereum and Fuse network.''',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            SizedBox(height: 15.0),
                            Column(
                              children: <Widget>[
                                Text(
                                  'What is the difference between Ethereum and Fuse?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  '''
On Fuse you can send assets for free to anybody and on Ethereum you can trade them''',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            Center(
                                child: PrimaryButton(
                              fontSize: 15,
                              width: 100,
                              preload: isPreloading,
                              labelFontWeight: FontWeight.normal,
                              label: "Ok",
                              onPressed: () async {
                                Navigator.of(context).pop();
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
