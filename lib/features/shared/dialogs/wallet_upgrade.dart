import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:fusecash/features/shared/dialogs/wallet_upgrade_success.dart';
import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/features/shared/widgets/preloader.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/wallet_upgrade.dart';

class WalletUpgradeDialog extends StatefulWidget {
  const WalletUpgradeDialog({Key? key}) : super(key: key);

  @override
  WalletUpgradeDialogState createState() => WalletUpgradeDialogState();
}

class WalletUpgradeDialogState extends State<WalletUpgradeDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> scaleAnimation;
  bool isUpgrading = false;

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
    return StoreConnector<AppState, WalletUpgradeDialogViewModel>(
      distinct: true,
      converter: WalletUpgradeDialogViewModel.fromStore,
      onWillChange: (previousViewModel, newViewModel) {
        if ((previousViewModel?.hasUpgrade != newViewModel.hasUpgrade) &&
            !newViewModel.hasUpgrade) {
          Navigator.of(context).pop();
          const WalletUpgradeSuccessDialog().showSheet(context);
        }
      },
      builder: (_, viewModel) {
        return ScaleTransition(
          scale: scaleAnimation,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            title: Text(
              isUpgrading
                  ? I10n.of(context).update_process
                  : I10n.of(context).important_update,
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
                      isUpgrading
                          ? I10n.of(context).dont_close_the_app
                          : '${I10n.of(context).upgrade_wallet_text}.\n${I10n.of(context).upgrade_wallet_time}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    isUpgrading
                        ? const SizedBox(height: 20.0)
                        : const SizedBox.shrink(),
                    isUpgrading
                        ? const Preloader()
                        : const SizedBox(height: 20.0),
                    isUpgrading
                        ? const SizedBox.shrink()
                        : GradientButton(
                            textColor: Theme.of(context).canvasColor,
                            text: I10n.of(context).update,
                            width: MediaQuery.of(context).size.width,
                            onPressed: () {
                              setState(() {
                                isUpgrading = true;
                              });
                              viewModel.performWalletUpgrade(
                                () {},
                                () {
                                  setState(() {
                                    isUpgrading = true;
                                  });
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

extension WalletUpgradeExtension on WalletUpgradeDialog {
  Future<T?> showSheet<T>(
    BuildContext context,
  ) {
    return Future.delayed(
      const Duration(milliseconds: 200),
      () => showDialog(
        context: context,
        builder: (_) => this,
      ),
    );
  }
}
