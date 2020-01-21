import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';

class BusinessRouteArguments {
  final Business business;
  final Token token;

  BusinessRouteArguments({this.token, this.business});
}

class BusinessPage extends StatefulWidget {
  BusinessPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BusinessPageState createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  GlobalKey<ScaffoldState> scaffoldState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BusinessRouteArguments businessArgs =
        ModalRoute.of(context).settings.arguments;
    return new Scaffold(
        key: scaffoldState,
        body: SafeArea(
          top: false,
          minimum: EdgeInsets.zero,
          child: Stack(
            children: <Widget>[
              Container(
                //My container or any other widget
                margin: EdgeInsets.only(top: 0),
                child: ListView(children: <Widget>[
                  Stack(
                    children: <Widget>[
                      businessArgs.business.metadata.coverPhoto == null ||
                              businessArgs.business.metadata.coverPhoto == ''
                          ? Image.network(
                              'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png',
                            )
                          : Image.network(
                              DotEnv().env['IPFS_BASE_URL'] +
                                  '/image/' +
                                  businessArgs.business.metadata.coverPhoto,
                              fit: BoxFit.cover,
                              //width: 50.0,
                              //height: 50.0,
                            )
                    ],
                  ),
                  Container(
                    //color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(20.0),
                    //height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(businessArgs.business.name ?? '',
                              style: TextStyle(
                                  //color: const Color(0xFFFFFFFF),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(businessArgs.business.metadata.address ?? '',
                            style: TextStyle(
                                //color: const Color(0xFFFFFFFF),
                                fontSize: 14,
                                fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        businessArgs.business.metadata.description ?? '',
                        style: TextStyle(
                            color: const Color(0xFF666666),
                            height: 1.3,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0, bottom: 0, left: 100, right: 100),
                    child: Container(
                        width: 100,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Color(0xFFB1FDC0),
                          padding: EdgeInsets.all(0),
                          child: Text(
                            I18n.of(context).pay,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/SendAmount',
                                arguments: SendAmountArguments(
                                  accountAddress: businessArgs.business.account,
                                  avatar:
                                      new AssetImage('assets/images/anom.png'),
                                  name: businessArgs.business.name ?? '',
                                ));
                          },
                        )),
                  ),
                ]),
              ),
              new Positioned(
                //Place it at the top, and not use the entire screen
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  backgroundColor: Colors.transparent, //No more green
                  elevation: 0.0, //Shadow gone
                ),
              ),
            ],
          ),
        ));
  }
}
