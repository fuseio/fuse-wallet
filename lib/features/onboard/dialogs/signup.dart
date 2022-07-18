import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({Key? key}) : super(key: key);

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

  Widget get spacer => const SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    final TextStyle? runTextStyle =
        Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 18,
            );
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: 300,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                children: [
                  Text(
                    I10n.of(context).why_do_we_need_this,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  spacer,
                  Text(
                    I10n.of(context).stores_private,
                    style: runTextStyle,
                  ),
                  spacer,
                  Text(
                    I10n.of(context).will_never_share,
                    style: runTextStyle,
                  ),
                  spacer,
                  Text(
                    I10n.of(context).for_more_info,
                    style: runTextStyle,
                  ),
                  InkWell(
                    focusColor: Theme.of(context).canvasColor,
                    highlightColor: Theme.of(context).canvasColor,
                    onTap: () {
                      AutoRouter.of(context).push(
                        Webview(
                          title: I10n.of(context).legal,
                          url: Variables.privacyPolicyPage,
                        ),
                      );
                    },
                    child: Text(
                      I10n.of(context).privacy,
                      style: runTextStyle?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  spacer,
                  spacer,
                  Center(
                    child: GradientButton(
                      width: MediaQuery.of(context).size.width * .9,
                      text: I10n.of(context).ok_thanks,
                      textColor: Theme.of(context).canvasColor,
                      onPressed: Navigator.of(context).pop,
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

extension SignUpDialogExtension on SignUpDialog {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}
