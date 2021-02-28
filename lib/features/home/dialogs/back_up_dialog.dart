import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/constants/keys.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';
import 'dart:core';

import 'package:fusecash/widgets/primary_button.dart';

class BackUpDialog extends StatefulWidget {
  BackUpDialog();

  @override
  createState() => new BackUpDialogState();
}

class BackUpDialogState extends State<BackUpDialog>
    with SingleTickerProviderStateMixin {
  BackUpDialogState();

  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
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
          content: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(I18n.of(context).protect_wallet,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    Text(I18n.of(context).we_notice,
                        style: TextStyle(
                            color: Color(0xFF696969),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20.0),
                    Text(I18n.of(context).to_protect,
                        style: TextStyle(
                            color: Color(0xFF696969),
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20.0),
                    PrimaryButton(
                      label: I18n.of(context).back_up_now,
                      fontSize: 16,
                      width: 170,
                      labelFontWeight: FontWeight.normal,
                      onPressed: () async {
                        final BottomNavigationBar navigationBar =
                            AppKeys.bottomBarKey.currentWidget;
                        Navigator.of(context).pop();
                        navigationBar.onTap(0);
                        ExtendedNavigator.named('homeRouter')
                            .pushShowMnemonic();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class BonusLetter extends StatelessWidget {
  const BonusLetter(this._letter);

  final String _letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(_letter,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
    );
  }
}
