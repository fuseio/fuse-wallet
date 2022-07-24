import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:fusecash/features/shared/widgets/bounce.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.width,
    this.icon,
    this.textColor,
    this.preload = false,
    this.disabled = false,
    this.height = 42,
    this.padding = const EdgeInsets.only(
      top: 5,
      bottom: 5,
    ),
    this.style,
    this.centerContent = true,
    this.trailing,
    this.boxShadow,
  }) : super(key: key);
  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Widget? icon;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final bool preload;
  final bool disabled;
  final bool centerContent;
  final Widget? trailing;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisAlignment:
          centerContent ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon != null ? icon! : const SizedBox.shrink(),
        icon != null
            ? const SizedBox(
                width: 10,
              )
            : const SizedBox.shrink(),
        Flexible(
          child: AutoSizeText(
            text,
            style: (style ??
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor,
                    )),
          ),
        ),
      ],
    );

    return Bounce(
      duration: const Duration(milliseconds: 200),
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              25.0,
            ),
          ),
          color: backgroundColor ??
              (disabled
                  ? Theme.of(context).colorScheme.primary.withOpacity(.6)
                  : Theme.of(context).colorScheme.primary),
        ),
        height: height,
        width: width ?? MediaQuery.of(context).size.width * .425,
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
