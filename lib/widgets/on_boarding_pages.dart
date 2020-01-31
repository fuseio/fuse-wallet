import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/screens/splash/create_wallet.dart';

List<Widget> getPages(context) {
  return <Widget>[
    Container(
      color: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.only(bottom: 135),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  I18n.of(context).simple,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    I18n.of(context).intro_text_one,
                    style:
                        TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary,),
                    textAlign: TextAlign.center,
                  ))
            ],
          )),
    ),
    Container(
      color: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.only(bottom: 135),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  I18n.of(context).useful,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    I18n.of(context).intro_text_two,
                    style:
                        TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ))
            ],
          )),
    ),
    Container(
      color: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.only(bottom: 135),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  I18n.of(context).smart,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    I18n.of(context).intro_text_three,
                    style:
                        TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ))
            ],
          )),
    ),
    Container(
      color: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child:
              Align(alignment: Alignment.bottomCenter, child: CreateWallet())),
    )
  ];
}
