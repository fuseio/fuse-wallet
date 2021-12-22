import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/generated/l10n.dart';
import 'dart:core';

import 'package:fusecash/features/shared/widgets/primary_button.dart';

class SignUpDialog extends StatefulWidget {
  SignUpDialog();

  @override
  SignUpDialogState createState() => SignUpDialogState();
}

class SignUpDialogState extends State<SignUpDialog>
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
        content: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    I10n.of(context).why_do_we_need_this,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    I10n.of(context).stores_private,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    I10n.of(context).will_never_share,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    I10n.of(context).for_more_info,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  InkWell(
                    focusColor: Theme.of(context).canvasColor,
                    highlightColor: Theme.of(context).canvasColor,
                    onTap: () {
                      AutoRouter.of(context).push(
                        Webview(
                          title: I10n.of(context).legal,
                          url: 'https://fuse.cash/privacy',
                        ),
                      );
                    },
                    child: Text(
                      I10n.of(context).privacy,
                      style: TextStyle(
                        color: Color(0xFF0076FF),
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: PrimaryButton(
                      label: I10n.of(context).ok_thanks,
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
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
