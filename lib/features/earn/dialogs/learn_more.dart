import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/utils/url.dart';
import 'dart:core';

import 'package:span_builder/span_builder.dart';

class LearnMoreDialog extends StatefulWidget {
  @override
  createState() => new LearnMoreDialogState();
}

class LearnMoreDialogState extends State<LearnMoreDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    final spans = SpanBuilder(I10n.of(context).peg_explained).apply(
      TextSpan(
        text: "circle.com",
        style: TextStyle(color: Color(0xFF006CFF)),
      ),
      onTap: () {
        launchUrl('https://circle.com');
      },
    ).apply(
      TextSpan(
        text: "fuse.io",
        style: TextStyle(color: Color(0xFF006CFF)),
      ),
      onTap: () {
        launchUrl('https://fuse.io');
      },
    ).build();
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        )),
        insetPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFB1FDC0),
                          Color(0xFFFEFD86),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Container(),
                  ),
                  Positioned(
                    bottom: -50,
                    child: Image.asset(
                      "assets/images/fuse-dollar.png",
                      width: 100,
                      // width: 150,
                      // height: 150,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 0,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.0),
                    Center(
                      child: Text(
                        I10n.of(context).fuse_dollar,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      I10n.of(context).fuse_dollar_explained,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      I10n.of(context).how_peg,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: spans,
                        style: TextStyle(
                          fontFamily: 'Europa',
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // InkWell(
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) => LearnMoreDialog(),
                    //     );
                    //   },
                    //   focusColor: Theme.of(context).canvasColor,
                    //   highlightColor: Theme.of(context).canvasColor,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         I10n.of(context).go_to_token_page,
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 5,
                    //       ),
                    //       SvgPicture.asset(
                    //         'assets/images/deposit_arrow.svg',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}