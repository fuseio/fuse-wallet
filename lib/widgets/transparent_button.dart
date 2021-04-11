import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  TransparentButton({
    this.fontSize,
    this.onPressed,
    this.label,
    this.width,
    this.height,
    this.preload,
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
        child: (preload == null || preload == false)
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Text(label,
                    style: TextStyle(
                      fontSize: this.fontSize ?? 18,
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
                width: 21.0,
                height: 21.0,
                margin: EdgeInsets.only(left: 28, right: 28),
              ),
      ),
    );
  }
}
