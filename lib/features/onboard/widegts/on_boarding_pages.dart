import 'package:flutter/material.dart';

class WelcomeFrame extends StatelessWidget {
  const WelcomeFrame({
    Key key,
    this.title,
    this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        bottom: 80,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondaryVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
