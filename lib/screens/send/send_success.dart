import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/screens/send/send_amount_arguments.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

typedef OnSignUpCallback = Function(String countryCode, String phoneNumber);

class SendSuccessScreen extends StatefulWidget {
  @override
  _SendSuccessScreenState createState() => _SendSuccessScreenState();
}

class _SendSuccessScreenState extends State<SendSuccessScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.popUntil(context, ModalRoute.withName('/Cash'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final SendAmountArguments args = ModalRoute.of(context).settings.arguments;

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
                child: Transform.scale(scale: 6,
                origin: Offset(-9, 7),
                  child: FlareActor(
                  "assets/images/check.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Checkmark",
                  sizeFromArtboard: true,
                ),
                ) ,
              ),
              tag: "contactSent",
            )))
      ],
    );
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            /* transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),*/
            transitionDuration: Duration(seconds: 1));
}
