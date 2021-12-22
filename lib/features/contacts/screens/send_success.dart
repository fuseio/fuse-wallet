import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/generated/l10n.dart';

import 'package:fusecash/features/contacts/send_amount_arguments.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';

class SendSuccessScreen extends StatefulWidget {
  final SendFlowArguments pageArgs;
  SendSuccessScreen({
    required this.pageArgs,
  });
  @override
  _SendSuccessScreenState createState() => _SendSuccessScreenState();
}

class _SendSuccessScreenState extends State<SendSuccessScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      context.router.popUntilRoot();
      context.navigateTo(
        HomeTab(
          children: [
            HomeScreen(),
          ],
        ),
      );
      WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).success,
      body: Container(
        height: MediaQuery.of(context).size.height * .6,
        child: Center(
          child: Hero(
            child: CircleAvatar(
              backgroundColor: Color(0xFFE0E0E0),
              radius: 100,
              backgroundImage: widget.pageArgs.avatar ??
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
          ),
        ),
      ),
    );
  }
}
