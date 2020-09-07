import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/generated/i18n.dart';
import 'package:supervecina/screens/misc/about.dart';
import 'package:supervecina/widgets/main_scaffold.dart';

class FusePointsExplainedScreen extends StatefulWidget {
  @override
  _FusePointsExplainedScreenState createState() =>
      _FusePointsExplainedScreenState();
}

class _FusePointsExplainedScreenState extends State<FusePointsExplainedScreen> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        automaticallyImplyLeading: false,
        title: I18n.of(context).fuse_volts,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFECF0F5),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(15.0)),
                      border: Border.all(color: Color(0xFFE4E9F0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/images/fuse-logo.svg",
                            width: 75,
                            height: 75,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '''Fuse Volts was created by the studio as a featured community. Get some Volts for exploring the wallet features:''',
                            style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).colorScheme.secondary),
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
                                    'Win up to 30 points!',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        'assets/images/v_sign.svg'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('10 points for installing the app',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        'assets/images/v_sign.svg'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        '10 points after sending money to a friend',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                        'assets/images/v_sign.svg'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('10 points for backing-up your wallet',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB1FDC0),
                        Color(0xFFFEFD86),
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      launchUrl('https://studio.fuse.io');
                    },
                    child: Container(
                      child: SvgPicture.asset(
                          'assets/images/lanuch_community.svg'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]);
  }
}
