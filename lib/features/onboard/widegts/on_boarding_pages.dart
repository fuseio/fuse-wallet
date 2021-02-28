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
      padding: EdgeInsets.only(bottom: 80, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, color: Color(0xFF808080)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              subTitle,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
