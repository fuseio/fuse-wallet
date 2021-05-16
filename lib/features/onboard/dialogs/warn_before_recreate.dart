import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';

class WarnBeforeReCreation extends StatefulWidget {
  @override
  _WarnBeforeReCreationState createState() => _WarnBeforeReCreationState();
}

class _WarnBeforeReCreationState extends State<WarnBeforeReCreation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimatoin;
  bool isPreloading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
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
            'assets/images/important.svg',
            width: 35,
            height: 35,
          ),
        ),
        content: Text(I10n.of(context).reset_account),
        actions: <Widget>[
          FlatButton(
            textColor: Color(0xFF009DFF),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(true);
            },
            child: Text(I10n.of(context).yes, style: TextStyle(fontSize: 16)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(false);
            },
            child: Text(
              I10n.of(context).no,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
