import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/screens/cash_home/webview_page.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
import 'package:flushbar/flushbar.dart';

class DaiExplainedScreen extends StatefulWidget {
  @override
  _DaiExplainedScreenState createState() => _DaiExplainedScreenState();
}

class _DaiExplainedScreenState extends State<DaiExplainedScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        title: I18n.of(context).dai_points,
        titleFontSize: 15,
        footer: bottomBar(context),
        withPadding: false,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFF7FFF8),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                    border: Border.all(color: Color(0xFFECF7EF))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/dai_points_logo.png",
                          width: 75,
                          height: 75,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '''DAI points is the default token of the Fuse wallet. Get some points to start exploring the features:''',
                          style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).colorScheme.secondary),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '1 DAI = \$1 = 100 DAI points',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00BE66)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Win up to 100 points!',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline
                                          .color),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  SvgPicture.asset('assets/images/v_sign.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Get 20 points for installing the app',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset('assets/images/v_sign.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      'Get 40 points after sending money to a friend',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset('assets/images/v_sign.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      'Get 40 points for backing-up your wallet',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary)),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                  width: 260.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Theme.of(context).primaryColorLight,
                                          Theme.of(context).primaryColorDark,
                                        ],
                                      ),
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(30.0)),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withAlpha(14))),
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pushNamed(context, '/Prize');
                                      await Segment.track(
                                          eventName: "User open prize page");
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('Win a weekly prize!',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .button
                                                      .color,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          SvgPicture.asset(
                                            'assets/images/gift_black.svg',
                                          ),
                                        ]),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                              messageText: new Text(
                                "Coming soon",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            )..show(context);
                          },
                          child: Text(
                            'Add DAI',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).textTheme.headline.color,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/arrow_black.png',
                          width: 15,
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Flushbar(
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                        messageText: new Text(
                          "Coming soon",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )..show(context);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Withdraw DAI',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).textTheme.headline.color,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            'assets/images/arrow_black.png',
                            width: 15,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/WebPage',
                      arguments: WebViewPageArguments(
                          url:
                              'https://docs.fuse.io/the-mobile-wallet/what-is-dai-points',
                          title: 'What is dai points?'));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Still have question?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).colorScheme.secondary)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '''Learn more''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              )
            ],
          )
        ]);
  }
}
