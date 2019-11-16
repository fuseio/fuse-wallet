import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {this.onPressed, this.label, this.width, this.height, this.preload});
  final GestureTapCallback onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;

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
          borderRadius: new BorderRadius.all(new Radius.circular(30.0))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: (preload == null || preload == false)
                  ? Text(
                      label,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
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