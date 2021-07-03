import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/widgets/show_up.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({
    Key? key,
    required this.title,
    this.delay = 500,
    required this.subTitle,
  }) : super(key: key);
  final int delay;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ShowUp(
            delay: delay,
            child: Text(
              title,
              style: TextStyle(fontSize: 18, color: Color(0xFF808080)),
            ),
          ),
          ShowUp(
            delay: delay + 50,
            child: AutoSizeText(
              subTitle,
              maxLines: 3,
              minFontSize: 25,
              maxFontSize: 27,
              style: TextStyle(
                fontFamily: 'Europa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
