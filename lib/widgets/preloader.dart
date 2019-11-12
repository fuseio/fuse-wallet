import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  Preloader({this.width, this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor)),
        width: width ?? 60.0,
        height: height ?? 60.0,
        margin: EdgeInsets.only(left: 28, right: 28),
      ),
    );
  }
}