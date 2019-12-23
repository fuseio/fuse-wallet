import 'package:flutter/material.dart';
import 'package:fusecash/models/business.dart';
import 'dart:core';

import 'package:fusecash/screens/send/send_amount.dart';

class BusinessRouteArguments {
  final Business business;

  BusinessRouteArguments({this.business});
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
                      Image.network(
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
                    child: Text(businessArgs.business.metadata.description ?? '',
                        style: TextStyle(
                            color: const Color(0xFF666666),
                            height: 1.3,
                            fontSize: 14,
                            fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 20),
                    child: Container(
                        width: 200,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: Theme.of(context).accentColor,
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Pay",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/SendAmount',
                                arguments: SendAmountArguments(accountAddress: businessArgs.business.account));
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
