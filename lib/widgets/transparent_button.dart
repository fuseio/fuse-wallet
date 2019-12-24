import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  TransparentButton({this.onPressed, this.label, this.width, this.height, this.preload});
  final GestureTapCallback onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;

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
                  fontSize: 18,
                  fontWeight: FontWeight.normal)),
                  // Container(
                  //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  //     child: Text(
                  //     label,
                  //     style: TextStyle(
                  //         color: Theme.of(context).textTheme.button.color,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w700),
                  //   ))
                 ) : Container(
                      child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)),
                      width: 21.0,
                      height: 21.0,
                      margin: EdgeInsets.only(left: 28, right: 28),
                    ),
        // child: new Container(
        //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        //   child: Text(label,
        //       style: TextStyle(
        //           color: Theme.of(context).primaryColor,
        //           fontSize: 18,
        //           fontWeight: FontWeight.normal)),
        // ),
      ),
      color: Colors.transparent,
    );
  }
}