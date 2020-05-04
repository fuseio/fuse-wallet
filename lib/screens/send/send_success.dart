import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:localdolarmx/generated/i18n.dart';
import 'package:localdolarmx/screens/pro_routes.gr.dart';
import 'package:localdolarmx/screens/routes.gr.dart';
import 'package:localdolarmx/screens/send/send_amount_arguments.dart';
import 'package:localdolarmx/widgets/main_scaffold.dart';

class SendSuccessScreen extends StatefulWidget {
  final SendAmountArguments pageArgs;
  SendSuccessScreen({this.pageArgs});
  @override
  _SendSuccessScreenState createState() => _SendSuccessScreenState();
}

class _SendSuccessScreenState extends State<SendSuccessScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Segment.screen(screenName: '/send-success-screen');

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (this.widget.pageArgs.isProMode) {
        ProRouter.navigator.pushNamedAndRemoveUntil(ProRouter.proModeHomeScreen, (Route<dynamic> route) => false);
      } else {
        Router.navigator.pushNamedAndRemoveUntil(Router.cashHomeScreen, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = this.widget.pageArgs;
    return MainScaffold(
      withPadding: true,
      title: I18n.of(context).success,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 140),
            child: Center(
                child: Hero(
              child: CircleAvatar(
                backgroundColor: Color(0xFFE0E0E0),
                radius: 100,
                backgroundImage: args.avatar,
                child: Transform.scale(
                  scale: 6,
                  origin: Offset(-9, 7),
                  child: FlareActor(
                    "assets/images/check.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "Checkmark",
                    sizeFromArtboard: true,
                  ),
                ),
              ),
              tag: "contactSent",
            )))
      ],
    );
  }
}
