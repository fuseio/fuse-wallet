import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_gen/gen_l10n/I10n.dart';

class WarnBeforeReCreation extends StatefulWidget {
  const WarnBeforeReCreation({Key? key}) : super(key: key);

  @override
  State<WarnBeforeReCreation> createState() => _WarnBeforeReCreationState();
}

class _WarnBeforeReCreationState extends State<WarnBeforeReCreation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool isPreloading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
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
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Center(
          child: SvgPicture.asset(
            'assets/images/important.svg',
            width: 35,
            height: 35,
          ),
        ),
        content: Text(I10n.of(context).reset_account),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: Text(
              I10n.of(context).yes,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text(
              I10n.of(context).no,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

extension WarnBeforeReCreationExtension on WarnBeforeReCreation {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => this,
    );
  }
}
