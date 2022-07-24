import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

class BackUpDialog extends StatefulWidget {
  const BackUpDialog({Key? key}) : super(key: key);

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

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
          child: SvgPicture.asset(
            'assets/images/back_up_icon.svg',
            width: 35,
            height: 35,
          ),
        ),
        content: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    I10n.of(context).protect_wallet,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    I10n.of(context).we_notice,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xFF696969),
                        ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    I10n.of(context).to_protect,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 20.0),
                  Button(
                    text: I10n.of(context).back_up_now,
                    textColor: Theme.of(context).canvasColor,
                    onPressed: () {
                      context.router.push(const ShowMnemonicRoute());
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
