import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Button extends StatelessWidget {
  const Button({
    Key key,
    this.onPressed,
    this.text,
    this.icon,
    this.width,
  }) : super(key: key);
  final void Function() onPressed;
  final String text;
  final String icon;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * .425,
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12.0,
            ),
          ),
        ),
        color: Theme.of(context).colorScheme.secondary,
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/$icon.svg',
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: AutoSizeText(
                text,
                style: TextStyle(
                  letterSpacing: 0.3,
                  // fontSize: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 1,
                presetFontSizes: [
                  20,
                  17,
                  // 15,
                  // 12,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}