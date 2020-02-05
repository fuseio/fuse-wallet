import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/screens/splash/create_wallet.dart';

Widget introPage(BuildContext context, String title, String subTitle) {
  return Container(
      color: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    subTitle,
                    style:
                        TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.secondary,),
                    textAlign: TextAlign.center,
                  ))
            ],
          )),
    );
}

List<Widget> getPages(BuildContext context) {
  return <Widget>[
    introPage(context, I18n.of(context).simple, I18n.of(context).intro_text_one),
    introPage(context, I18n.of(context).useful, I18n.of(context).intro_text_two),
    introPage(context, I18n.of(context).smart, I18n.of(context).intro_text_three),
    CreateWallet()
  ];
}
