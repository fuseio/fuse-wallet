import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  TransparentButton({
    this.fontSize = 18,
    required this.onPressed,
    required this.label,
    this.width = 21.0,
    this.height = 21.0,
    this.preload = false,
  });

  final void Function() onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onTap: onPressed,
        child: !preload
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(label,
                    style: TextStyle(
                      fontSize: this.fontSize,
                      fontWeight: FontWeight.normal,
                    )),
              )
            : Container(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                width: width,
                height: height,
                margin: EdgeInsets.only(left: 28, right: 28),
              ),
      ),
    );
  }
}
