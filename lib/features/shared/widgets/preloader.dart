import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  Preloader({
    this.width = 60,
    this.height = 60,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(left: 28, right: 28),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
