import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusecash/utils/log/log.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.child,
    this.height = 350.0,
    this.backgroundColor: Colors.white,
  }) : super(key: key);

  final double height;
  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    log.info('_overlayStyle ' + _overlayStyle.toString());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      sized: false,
      child: Container(
        color: Theme.of(context).canvasColor,
        child: child,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
