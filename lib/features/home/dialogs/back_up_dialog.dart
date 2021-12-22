import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/generated/l10n.dart';
import 'dart:core';

import 'package:fusecash/features/shared/widgets/primary_button.dart';

class BackUpDialog extends StatefulWidget {
  BackUpDialog();

  @override
  BackUpDialogState createState() => BackUpDialogState();
}

class BackUpDialogState extends State<BackUpDialog>
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
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
          child: SvgPicture.asset(
            'assets/images/back_up_icon.svg',
            width: 35,
            height: 35,
          ),
        ),
        content: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(I10n.of(context).protect_wallet,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20.0),
                  Text(I10n.of(context).we_notice,
                      style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 20.0),
                  Text(I10n.of(context).to_protect,
                      style: TextStyle(
                          color: Color(0xFF696969),
                          fontSize: 16,
                          fontWeight: FontWeight.normal)),
                  SizedBox(height: 20.0),
                  PrimaryButton(
                    label: I10n.of(context).back_up_now,
                    onPressed: () {
                      context.router.push(ShowMnemonic());
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
