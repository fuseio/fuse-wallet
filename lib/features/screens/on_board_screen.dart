import 'package:flutter/material.dart';
import 'package:supervecina/features/onboard/widegts/sign_up_buttons.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Image.asset(
                'assets/images/wikibank_logo.jpg',
                width: 350,
                // height: 300,
              ),
            ),
            Flexible(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Caja de Ahorros Digitales',
                      style: TextStyle(
                          fontFamily: 'Eras',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryVariant,
                          fontSize: 18),
                    ),
                    Text(
                      '\nde Sevilla',
                      style: TextStyle(
                        fontFamily: 'Eras',
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/2.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 100),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: SignUpButtons(),
            ),
          ],
        ),
      ),
    );
  }
}
