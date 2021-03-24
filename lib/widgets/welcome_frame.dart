import 'package:flutter/material.dart';
import 'package:fusecash/features/onboard/widegts/sign_up_buttons.dart';
import 'package:lottie/lottie.dart';

class ScreenTitle extends StatelessWidget {
  final String text;

  const ScreenTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.fastOutSlowIn,
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: Color(0xFF808080)),
      ),
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (BuildContext context, double _val, Widget child) => Opacity(
        opacity: _val,
        child: child,
      ),
    );
  }
}

class ScreenSubTitle extends StatelessWidget {
  final String text;

  const ScreenSubTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      curve: Curves.fastOutSlowIn,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 27,
          fontFamily: 'Europa',
          fontWeight: FontWeight.bold,
        ),
      ),
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 1000),
      builder: (BuildContext context, double _val, Widget child) => Opacity(
        opacity: _val,
        child: Padding(
          padding: EdgeInsets.only(top: _val * 30),
          child: child,
        ),
      ),
    );
  }
}

class WelcomeFrame extends StatefulWidget {
  const WelcomeFrame({
    Key key,
    this.title,
    this.subTitle,
    this.showButtons = false,
    this.lottieImagePath,
  }) : super(key: key);

  final String title;
  final bool showButtons;
  final String subTitle;
  final String lottieImagePath;

  @override
  _WelcomeFrameState createState() => _WelcomeFrameState();
}

class _WelcomeFrameState extends State<WelcomeFrame>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int cont = 0;
  int targetCount = 10;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('Animation ${cont + 1} completed. ');
        cont++;
        if (cont == 1) {}
        if (cont < double.maxFinite) {
          _controller.reset();
          _controller.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Lottie.asset(
                widget.lottieImagePath,
                frameRate: FrameRate.max,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: !widget.showButtons
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    !widget.showButtons
                        ? ScreenTitle(
                            text: widget.title,
                          )
                        : SizedBox.shrink(),
                    !widget.showButtons
                        ? ScreenSubTitle(
                            text: widget.subTitle,
                          )
                        : SizedBox.shrink(),
                    widget.showButtons
                        ? Center(child: SignUpButtons())
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
