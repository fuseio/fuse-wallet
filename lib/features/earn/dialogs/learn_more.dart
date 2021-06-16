import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'dart:core';

class LearnMoreDialog extends StatefulWidget {
  @override
  createState() => new LearnMoreDialogState();
}

class LearnMoreDialogState extends State<LearnMoreDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;

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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
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
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Stack(
                  clipBehavior: Clip.none,
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
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListView(
                    shrinkWrap: true,
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
                        I10n.of(context).what_is_fuse_dollar,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        I10n.of(context).fuse_dollar_explain,
                        style: TextStyle(
                          fontFamily: 'Europa',
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // what_is_peg
                      Text(
                        I10n.of(context).what_is_peg,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        I10n.of(context).peg_explain,
                        style: TextStyle(
                          fontFamily: 'Europa',
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        I10n.of(context).how_to_use_fusd,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        I10n.of(context).use_fusd_explain,
                        style: TextStyle(
                          fontFamily: 'Europa',
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        I10n.of(context).future_stablecoins,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        I10n.of(context).fusd_stablecoins_explain,
                        style: TextStyle(
                          fontFamily: 'Europa',
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: I10n.of(context).visit_fuseio,
                            ),
                          ],
                          style: TextStyle(
                            fontFamily: 'Europa',
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
