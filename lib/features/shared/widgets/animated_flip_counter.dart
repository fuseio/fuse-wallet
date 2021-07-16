import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class AnimatedFlipCounter extends StatelessWidget {
  final int value;
  final Duration duration;
  final TextStyle? textStyle;
  final String? prefix;
  final String? suffix;
  final int fractionDigits; // how many digits to display, after decimal point

  AnimatedFlipCounter({
    Key? key,
    required double value,
    this.duration = const Duration(milliseconds: 300),
    this.textStyle,
    this.prefix,
    this.suffix,
    this.fractionDigits = 0,
  })  : assert(fractionDigits >= 0, "fractionDigits must be non-negative"),
        this.value = (value * math.pow(10, fractionDigits)).round(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(context).style.merge(textStyle);
    // Layout number "8" (probably the widest digit) to see its size
    final prototypeDigit = TextPainter(
      text: TextSpan(text: "8", style: style),
      textDirection: TextDirection.ltr,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
    )..layout();

    // Find the text color (or red as warning). This is so we can avoid using
    // `Opacity` and `AnimatedOpacity` widget, for better performance.
    final Color color = style.color ?? Color(0xffff0000);

    // Split the `value` into separate digits to draw.
    List<int> digits = value == 0 ? [0] : [];
    int v = value.abs();
    while (v > 0) {
      digits.add(v);
      v = v ~/ 10;
    }
    while (digits.length <= fractionDigits) {
      digits.add(0); // add trailing zeroes if needed
    }
    digits = digits.reversed.toList(growable: false);

    return DefaultTextStyle.merge(
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefix != null) Text(prefix!),
          ClipRect(
            child: TweenAnimationBuilder(
              // Animate the negative sign (-) appear and disappearing
              duration: duration,
              tween: Tween(end: value < 0 ? 1.0 : 0.0),
              builder: (_, double v, __) => Center(
                widthFactor: v,
                child: Text(
                  "-",
                  style: TextStyle(color: color.withOpacity(v)),
                ),
              ),
            ),
          ),
          // Draw digits before the decimal point
          for (int i = 0; i < digits.length - fractionDigits; i++)
            _SingleDigitFlipCounter(
              key: ValueKey(digits.length - i),
              value: digits[i].toDouble(),
              duration: duration,
              size: prototypeDigit.size,
              color: color,
            ),
          // Draw the decimal point
          if (fractionDigits != 0) Text("."),
          // Draw digits after the decimal point
          for (int i = digits.length - fractionDigits; i < digits.length; i++)
            _SingleDigitFlipCounter(
              key: ValueKey("decimal$i"),
              value: digits[i].toDouble(),
              duration: duration,
              size: prototypeDigit.size,
              color: color,
            ),
          if (suffix != null) Text(suffix!),
        ],
      ),
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final Size size;
  final Color color;

  const _SingleDigitFlipCounter({
    Key? key,
    required this.value,
    required this.duration,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(end: value),
      duration: duration,
      builder: (_, double value, __) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        final w = size.width;
        final h = size.height;

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: <Widget>[
              _buildSingleDigit(
                digit: whole % 10,
                offset: h * decimal,
                opacity: 1 - decimal,
              ),
              _buildSingleDigit(
                digit: (whole + 1) % 10,
                offset: h * decimal - h,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit({
    required int digit,
    required double offset,
    required double opacity,
  }) {
    return Positioned(
      bottom: offset,
      child: Text(
        "$digit",
        style: TextStyle(color: color.withOpacity(opacity)),
      ),
    );
  }
}
