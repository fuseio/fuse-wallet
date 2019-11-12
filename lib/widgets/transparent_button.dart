import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  TransparentButton({this.onPressed, this.label, this.width, this.height});
  final GestureTapCallback onPressed;
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new InkWell(
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: new Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Text(label,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        ),
      ),
      color: Colors.transparent,
    );
  }
}