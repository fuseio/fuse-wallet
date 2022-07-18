import 'dart:core';

import 'package:flutter/material.dart';

import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveDialog extends StatefulWidget {
  final String barcodeData;

  const ReceiveDialog(this.barcodeData, {Key? key}) : super(key: key);
  @override
  ReceiveDialogState createState() => ReceiveDialogState();
}

class ReceiveDialogState extends State<ReceiveDialog>
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
            Radius.circular(25.0),
          ),
        ),
        content: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: QrImage(
                        data: widget.barcodeData,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: GradientButton(
                      text: I10n.of(context).close,
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

extension ReceiveDialogExtension on ReceiveDialog {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}
