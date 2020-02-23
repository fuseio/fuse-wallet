import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paywise/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DaiExplainedScreen extends StatefulWidget {
  @override
  _DaiExplainedScreenState createState() => _DaiExplainedScreenState();
}

launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false);
  } else {
    throw 'Could not launch $url';
  }
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
  void dispose() {
    controller?.dispose();
    super.dispose();
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
                        Image.asset("assets/images/dai_points_cover.png"),
                        Positioned(
                            bottom: -35,
                            child: Image.asset(
                              "assets/images/dai-point-community-logo.png",
                            ))
                      ],
                    ),
                    const SizedBox(height: 50.0),
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
                                'Welcome to DAI points community!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '''DAI points is the default community on Fuse wallet. Get some points to start exploring its features:''',
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, right: 10),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                          'assets/images/v_sign.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'Get 10 points for installing the app',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                          'assets/images/v_sign.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'Get 10 points after sending money to a friend',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                          'assets/images/v_sign.svg'),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          'Get 10 points for backing-up your wallet',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Text(
                                '1 DAI = \$1 = 100 DAI points',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00BE66)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                launchUrl(
                                    'https://docs.fuse.io/the-mobile-wallet/what-is-dai-points');
                              },
                              child: Text(
                                '''Learn more''',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
