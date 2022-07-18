import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:fusecash/features/wallet/send_amount_arguments.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';

class SendSuccessPage extends StatefulWidget {
  final SendFlowArguments pageArgs;
  const SendSuccessPage({
    required this.pageArgs,
    Key? key,
  }) : super(key: key);
  @override
  State<SendSuccessPage> createState() => _SendSuccessPageState();
}

class _SendSuccessPageState extends State<SendSuccessPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      context.router.popUntilRoot();
      context.navigateTo(
        const HomeTab(
          children: [
            HomeRoute(),
          ],
        ),
      );
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InnerScaffold(
      title: I10n.of(context).success,
      hasScrollBody: false,
      body: SizedBox(
        height: 1,
        child: Center(
          child: Hero(
            tag: "contactSent",
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 100,
              backgroundImage: widget.pageArgs.avatar ??
                  const AssetImage('assets/images/anom.png'),
              child: Transform.scale(
                scale: 6,
                origin: const Offset(-9, 7),
                child: const FlareActor(
                  "assets/images/check.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Checkmark",
                  sizeFromArtboard: true,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
