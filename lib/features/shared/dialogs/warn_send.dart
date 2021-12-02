import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/generated/l10n.dart';
import 'dart:core';
import 'package:supervecina/features/shared/widgets/primary_button.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/redux/viewsmodels/warn_send.dart';

class WarnSendDialog extends StatefulWidget {
  WarnSendDialog();

  @override
  createState() => WarnSendDialogState();
}

class WarnSendDialogState extends State<WarnSendDialog>
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
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      I10n.of(context).address_on_fuse,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    CheckboxListTile(
                      checkColor: Theme.of(context).canvasColor,
                      activeColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: viewModel.warnSendDialogShowed,
                      title: Text(
                        I10n.of(context).dont_show_next_time,
                        style: TextStyle(fontSize: 12),
                      ),
                      onChanged: (value) {
                        viewModel.updateWarnSendDialogShowed(value!);
                      },
                    ),
                    PrimaryButton(
                      label: I10n.of(context).continue_button,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          I10n.of(context).close,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
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
