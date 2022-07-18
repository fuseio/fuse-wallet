import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/features/shared/widgets/gradient_button.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/warn_send.dart';

class WarnSendDialog extends StatefulWidget {
  const WarnSendDialog({Key? key}) : super(key: key);

  @override
  WarnSendDialogState createState() => WarnSendDialogState();
}

class WarnSendDialogState extends State<WarnSendDialog>
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
        content: StoreConnector<AppState, WarnSendDialogViewModel>(
          distinct: true,
          converter: WarnSendDialogViewModel.fromStore,
          builder: (_, viewModel) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      I10n.of(context).address_on_fuse,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                          ),
                    ),
                    const SizedBox(height: 20.0),
                    CheckboxListTile(
                      checkColor: Theme.of(context).canvasColor,
                      activeColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: viewModel.warnSendDialogShowed,
                      title: Text(
                        I10n.of(context).dont_show_next_time,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onChanged: (value) {
                        viewModel.updateWarnSendDialogShowed(value!);
                      },
                    ),
                    GradientButton(
                      text: I10n.of(context).continue_button,
                      textColor: Theme.of(context).canvasColor,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(top: 10),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          I10n.of(context).close,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

extension WarnSendDialogExtension on WarnSendDialog {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => this,
    );
  }
}
