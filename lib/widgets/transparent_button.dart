import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  TransparentButton({this.fontSize, this.onPressed, this.label, this.width, this.height, this.preload});
  final GestureTapCallback onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new InkWell(
        highlightColor: Colors.transparent,
        onTap: onPressed,
              child: (preload == null || preload == false)
                  ? 
                          Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Text(label,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: this.fontSize ?? 18,
                  fontWeight: FontWeight.normal)),
                 ) : Container(
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)),
                      width: 21.0,
                      height: 21.0,
                      margin: EdgeInsets.only(left: 28, right: 28),
                    ),
      ),
      color: Colors.transparent,
    );
  }
}