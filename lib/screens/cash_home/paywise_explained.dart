import 'dart:core';
import 'package:flutter/material.dart';
import 'package:paywise/widgets/primary_button.dart';

class PaywiseExplainedScreen extends StatefulWidget {
  @override
  _PaywiseExplainedScreenState createState() => _PaywiseExplainedScreenState();
}

class _PaywiseExplainedScreenState extends State<PaywiseExplainedScreen>
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
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: <Widget>[
                        Image.asset("assets/images/paywise_points_cover.png"),
                        Positioned(
                            bottom: -65,
                            child: Image.asset(
                              "assets/images/icon-paywize_logo.png",
                              width: 150,
                              height: 150,
                            ))
                      ],
                    ),
                    const SizedBox(height: 60.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 10, left: 15, right: 15),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Welcome to PayWise points program!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '''With this app you can earn points and use them in stores around you. Each point is worth 0.50 TTD and the first 100 users get 10 points for creating an account!''',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    '''You can also invite your friends or backup your account to get 10 more points!''',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Center(
                                child: PrimaryButton(
                              fontSize: 15,
                              preload: isPreloading,
                              labelFontWeight: FontWeight.normal,
                              label: "Ok",
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            )),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ]),
            )));
  }
}
