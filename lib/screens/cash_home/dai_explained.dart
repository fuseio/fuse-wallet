import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fusecash/widgets/primary_button.dart';

class DaiExplainedScreen extends StatefulWidget {
  @override
  _DaiExplainedScreenState createState() => _DaiExplainedScreenState();
}

class _DaiExplainedScreenState extends State<DaiExplainedScreen>
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
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    overflow: Overflow.visible,
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Image.asset("assets/images/dai_points_cover.png"),
                      Positioned(
                          bottom: -35,
                          child: Image.asset(
                            "assets/images/dai-point-community-logo.png",
                          ))
                    ],
                  ),
                  const SizedBox(height: 80.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 10, left: 15, right: 15),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '''Fuse wallet lets you join and interact with communities on Fuse and DAI is the best place to start your exploration:''',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 30),
                            child: Text(
                              '1 DAI = \$1 = 100 DAI points',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00BE66)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    '''DAI is a dollar based stable coin, click here to learn more about it. Every holder DAI points automatically joins a weekly airdrop of DAI points that you can spend!''',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                )
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
                ])));
  }
}
