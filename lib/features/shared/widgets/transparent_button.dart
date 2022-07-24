import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  const TransparentButton({
    this.fontSize = 16,
    required this.onPressed,
    required this.label,
    this.width = 21.0,
    this.height = 21.0,
    this.preload = false,
    Key? key,
  }) : super(key: key);

  final void Function() onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        focusColor: Theme.of(context).canvasColor,
        highlightColor: Theme.of(context).canvasColor,
        onTap: onPressed,
        child: !preload
            ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: fontSize,
                      ),
                ),
              )
            : Container(
                width: width,
                height: height,
                margin: const EdgeInsets.only(left: 28, right: 28),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
      ),
    );
  }
}
