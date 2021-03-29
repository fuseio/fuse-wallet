import 'package:flutter/material.dart';

class DefaultLogo extends StatelessWidget {
  final String symbol;
  final double width;
  final double height;

  const DefaultLogo({
    this.height,
    this.width,
    this.symbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            shape: BoxShape.circle,
            border: Border.all(
                color: Theme.of(context).colorScheme.onSurface, width: 2)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ],
        ));
  }
}
