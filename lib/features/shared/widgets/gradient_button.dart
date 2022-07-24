import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fusecash/constants/theme.dart';
import 'package:fusecash/features/shared/widgets/bounce.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    this.trailing,
    this.boxShadow = const [
      BoxShadow(
        color: Color(0xFFD0FBE5),
        offset: Offset(0, 6),
        blurRadius: 10,
      )
    ],
    this.padding = const EdgeInsets.only(
      top: 5,
      bottom: 5,
    ),
    this.centerContent = true,
    this.icon,
    this.textColor,
    this.preload = false,
    this.disabled = false,
    this.height = 42,
    required this.text,
    this.width,
    required this.onPressed,
    this.style,
    Key? key,
  }) : super(key: key);
  final String text;
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final TextStyle? style;
  final bool preload;
  final bool disabled;
  final Widget? icon;
  final Color? textColor;
  final bool centerContent;
  final List<BoxShadow>? boxShadow;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Widget content = Row(
      mainAxisAlignment:
          centerContent ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon != null ? icon! : const SizedBox.shrink(),
        icon != null
            ? const SizedBox(
                width: 5,
              )
            : const SizedBox.shrink(),
        Flexible(
          child: AutoSizeText(
            text,
            style: (style ?? Theme.of(context).textTheme.titleMedium)?.copyWith(
              color: textColor,
            ),
          ),
        ),
      ],
    );
    return Bounce(
      duration: const Duration(milliseconds: 200),
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: width ?? MediaQuery.of(context).size.width * .425,
        height: height,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          gradient: disabled
              ? null
              : const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.0, 1.0],
                  colors: buttonsGradients,
                ),
          color: disabled
              ? Theme.of(context).colorScheme.primary.withOpacity(.6)
              : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: preload
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 21.0,
                    height: 21.0,
                    margin: const EdgeInsets.only(left: 28, right: 28),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                padding: centerContent
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: centerContent
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: content),
                    if (trailing != null)
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [trailing!],
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
