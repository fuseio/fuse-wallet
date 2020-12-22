import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/screens/splash/create_wallet.dart';

Widget introPage(
    BuildContext context, String title, String subTitle, String img) {
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/' + img,
                width: MediaQuery.of(context).size.width * .8),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 30),
              child: Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: AutoSizeText.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: subTitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ]),
                  minFontSize: 16,
                  maxFontSize: 20,
                  textAlign: TextAlign.center,
                ))
          ],
        )),
  );
}

List<Widget> getPages(BuildContext context) {
  return <Widget>[
    introPage(context, I18n.of(context).intro_title_one,
        I18n.of(context).intro_text_one, '1-cake.png'),
    introPage(context, I18n.of(context).intro_title_two,
        I18n.of(context).intro_text_two, '2-rewards.png'),
    introPage(context, I18n.of(context).intro_title_three,
        I18n.of(context).intro_text_three, '3-wallet.png'),
    introPage(context, I18n.of(context).intro_title_four,
        I18n.of(context).intro_text_four, '4-enjoy.png'),
    CreateWallet()
  ];
}
