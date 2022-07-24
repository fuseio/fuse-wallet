import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';

import 'package:fusecash/features/shared/widgets/gradient_button.dart';

class WalletUpgradeSuccessDialog extends StatefulWidget {
  const WalletUpgradeSuccessDialog({Key? key}) : super(key: key);

  @override
  WalletUpgradeSuccessDialogState createState() =>
      WalletUpgradeSuccessDialogState();
}

class WalletUpgradeSuccessDialogState extends State<WalletUpgradeSuccessDialog>
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
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text(
          I10n.of(context).thats_it,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        content: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${I10n.of(context).thank_you_for_your_patience}!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20.0),
                Text(
                  '😍',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20.0),
                GradientButton(
                  textColor: Theme.of(context).canvasColor,
                  text: I10n.of(context).close,
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension WalletUpgradeSuccessDialogExtension on WalletUpgradeSuccessDialog {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}
