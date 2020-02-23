import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/widgets/bottombar.dart';
import 'package:fusecash/widgets/main_scaffold.dart';
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

class _DaiExplainedScreenState extends State<DaiExplainedScreen> {
  @override
  Widget build(BuildContext _context) {
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
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                decoration: BoxDecoration(
                    color: Color(0xFFF7FFF8),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                    border: Border.all(color: Color(0xFFECF7EF))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/dai_points_logo.png",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '''DAI points is the default community on Fuse wallet. Get some points to start exploring its features:''',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.secondary),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '1 DAI = \$1 = 100 DAI points',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00BE66)),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Win up to 100 points!',
                                  style: TextStyle(
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
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: InkWell(
                                  onTap: () {},
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/Prize');
                                          },
                                          child: Text(
                                            'And get a chance to win a weekly prize!',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline
                                                  .color,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset(
                                          'assets/images/arrow_black.png',
                                          width: 10,
                                          height: 9,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showDialog(builder: (context) {
                                return Dialog(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(30.0)),
                                    ),
                                    child: Text(''),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'Add DAI',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline
                                      .color,
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
                  ),
                  InkWell(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Withdrad DAI',
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
                height: 40,
              ),
              InkWell(
                onTap: () {
                  launchUrl(
                      'https://docs.fuse.io/the-mobile-wallet/what-is-dai-points');
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
