import 'package:flutter/material.dart';

class CustomRectangle extends StatelessWidget {
  final Widget child;
  final double height;
  final double borderSize;
  final double borderRadius;
  final Color borderColor;

  const CustomRectangle({
    Key key,
    @required this.height,
    @required this.borderSize,
    @required this.borderRadius,
    @required this.child,
    @required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(borderRadius)),
          child: Container(
            height: height + borderSize,
            decoration: BoxDecoration(
              color: borderColor,
            ),
          ),
        ),
        ClipRRect(
          borderRadius:
              BorderRadius.only(bottomRight: Radius.circular(borderRadius)),
          child: Container(
            height: height + borderSize,
            child: child,
          ),
        ),
      ],
    );
  }
}
