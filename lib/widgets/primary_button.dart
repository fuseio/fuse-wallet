import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    this.fontSize,
    this.onPressed,
    this.label,
    this.width,
    this.height,
    this.preload,
    this.opacity = 0.4,
    this.disabled = false,
    this.labelColor,
  });
  final double opacity;
  final GestureTapCallback onPressed;
  final String label;
  final double width;
  final double height;
  final bool preload;
  final bool disabled;
  final double fontSize;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 255.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        color: disabled
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(11.0)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? () {} : onPressed,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          highlightColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
          splashColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
          child: Center(
            child: (preload == null || preload == false)
                ? AutoSizeText(
                    label,
                    style: TextStyle(
                      color: disabled
                          ? Color(0xFF797979)
                          : Theme.of(context).textTheme.button.color,
                      fontSize: this.fontSize ?? 20,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 1,
                  )
                : Container(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    width: 21.0,
                    height: 21.0,
                    margin: EdgeInsets.only(left: 28, right: 28),
                  ),
          ),
        ),
      ),
    );
  }
}
