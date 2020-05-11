import 'package:flutter/material.dart';
import 'package:digitalrand/screens/splash/create_wallet.dart';

Widget introPage(
    BuildContext context, String title, String subTitle, String img) {
  return Container(
    color: Colors.transparent,
    child: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/' + img,
                width: MediaQuery.of(context).size.width),
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
                child: Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ))
          ],
        )),
  );
}

List<Widget> getPages() => <Widget>[CreateWallet()];
