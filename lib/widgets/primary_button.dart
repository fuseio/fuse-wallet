import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {this.fontSize, this.labelFontWeight, this.onPressed, this.label, this.width, this.height, this.preload});
  final GestureTapCallback onPressed;
  final String label;
  final FontWeight labelFontWeight;
  final double width;
  final double height;
  final bool preload;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 255.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColorDark,
            ],
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
          border: Border.all(color: Colors.black.withAlpha(14))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            //hoverColor: Colors.red,
            //focusColor: Colors.red,
            highlightColor: Colors.white.withOpacity(0.3),
            splashColor: Colors.white.withOpacity(0.6),
            child: Center(
              child: (preload == null || preload == false)
                  ? Text(
                      label,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                          fontSize: this.fontSize ?? 18,
                          fontWeight: this.labelFontWeight ?? FontWeight.w700),
                    )
                  : Container(
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)),
                      width: 21.0,
                      height: 21.0,
                      margin: EdgeInsets.only(left: 28, right: 28),
                    ),
            )),
      ),
    );
  }
}