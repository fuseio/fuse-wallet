import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeFrame extends StatefulWidget {
  const WelcomeFrame({
    Key key,
    this.title,
    this.subTitle,
    this.lottieImagePath,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final String lottieImagePath;

  @override
  _WelcomeFrameState createState() => _WelcomeFrameState();
}

class _WelcomeFrameState extends State<WelcomeFrame>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Lottie.asset(
                widget.lottieImagePath,
                // options: LottieOptions(enableMergePaths: true),
                // addRepaintBoundary: false,
                // frameRate: FrameRate.max,
                // controller: _controller,
                // onLoaded: (composition) {
                //   // Configure the AnimationController with the duration of the
                //   // Lottie file and start the animation.
                //   _controller
                //     ..duration = composition.duration
                //     ..forward();
                // },
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 18, color: Color(0xFF808080)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.subTitle,
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
