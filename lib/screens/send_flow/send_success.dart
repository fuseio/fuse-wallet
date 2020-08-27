import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:ceu_do_mapia/constans/keys.dart';
import 'package:ceu_do_mapia/generated/i18n.dart';
import 'package:ceu_do_mapia/screens/routes.gr.dart';
import 'package:ceu_do_mapia/screens/contacts/send_amount_arguments.dart';
import 'package:ceu_do_mapia/widgets/main_scaffold.dart';

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
      final BottomNavigationBar navigationBar =
          AppKeys.bottomBarKey.currentWidget;
      Navigator.of(context).pop();
      navigationBar.onTap(0);
      ExtendedNavigator.root.popUntilPath(Routes.homePage);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: this.widget.pageArgs?.avatar ??
                    AssetImage('assets/images/anom.png'),
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
