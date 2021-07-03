import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'dart:core';

import 'package:fusecash/features/shared/widgets/primary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveDialog extends StatefulWidget {
  ReceiveDialog(
    this.barcodeData,
  );
  final String barcodeData;
  @override
  createState() => new ReceiveDialogState();
}

class ReceiveDialogState extends State<ReceiveDialog>
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
                  Center(
                    child: Container(
                      width: 200,
                      child: QrImage(
                        data: widget.barcodeData,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: PrimaryButton(
                      label: I10n.of(context).close,
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
