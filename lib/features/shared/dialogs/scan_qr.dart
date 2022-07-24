import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:scan/scan.dart';

class ScanQRDialog extends StatefulWidget {
  const ScanQRDialog({Key? key}) : super(key: key);

  @override
  State<ScanQRDialog> createState() => _ScanQRDialogState();
}

class _ScanQRDialogState extends State<ScanQRDialog>
    with SingleTickerProviderStateMixin {
  final BorderRadius _borderRadius = const BorderRadius.vertical(
    top: Radius.circular(20),
  );

  late AnimationController controller;
  late Animation<double> scaleAnimation;
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

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: ScanView(
                    controller: scanController,
                    scanLineColor: Theme.of(context).colorScheme.primary,
                    onCapture: (data) => Navigator.of(context).pop(data),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    iconSize: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: _borderRadius,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            I10n.of(context).send_funds,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 18,
                                    ),
                          ),
                          subtitle: Text(
                            I10n.of(context).scan_address,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            I10n.of(context).connect_to_apps,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 18,
                                    ),
                          ),
                          subtitle: Text(
                            I10n.of(context).scan_wallet_connect,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                child: Image.asset(
                                  'assets/images/wallet_connect.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
