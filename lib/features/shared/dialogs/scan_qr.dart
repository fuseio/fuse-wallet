import 'package:flutter/material.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/widgets/primary_button.dart';
import 'package:scan/scan.dart';

class ScanQRDialog extends StatefulWidget {
  @override
  _ScanQRDialogState createState() => _ScanQRDialogState();
}

class _ScanQRDialogState extends State<ScanQRDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimatoin;
  bool isPreloading = false;
  ScanController scanController = ScanController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
      scale: scaleAnimatoin,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
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
                      width: 250,
                      height: 250,
                      child: ScanView(
                        controller: scanController,
                        scanLineColor: Theme.of(context).primaryColor,
                        onCapture: (data) {
                          Navigator.of(context).pop(data);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: PrimaryButton(
                      label: I10n.of(context).close,
                      onPressed: () {
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
