import 'package:flutter/material.dart';

class MyBackBtn extends StatelessWidget {
  const MyBackBtn({
    Key? key,
    this.color,
    this.onPressed,
    this.size,
  }) : super(key: key);
  final double? size;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: MyBackBtnIcon(
        size: size,
      ),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

class MyBackBtnIcon extends StatelessWidget {
  const MyBackBtnIcon({
    Key? key,
    this.size,
  }) : super(key: key);
  final double? size;

  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return Icons.arrow_back_ios;
    }
  }

  @override
  Widget build(BuildContext context) => Icon(
        _getIconData(Theme.of(context).platform),
        size: size,
      );
}
