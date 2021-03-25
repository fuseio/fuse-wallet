import 'package:flutter/material.dart';

class TopUpFailed extends StatefulWidget {
  @override
  _TopUpFailedState createState() => _TopUpFailedState();
}

class _TopUpFailedState extends State<TopUpFailed>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  bool isPreloading = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimation,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          content: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Aww Snap 😑',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Transaction Failed.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Please check with your financial provider, or use a different card.',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
