import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final void Function()? onTap;
  final Widget child;
  final Duration duration;
  final double scale;

  const Bounce({
    required this.child,
    required this.duration,
    required this.onTap,
    this.scale = 0.9,
    Key? key,
  }) : super(key: key);

  @override
  State<Bounce> createState() => _BounceState();
}

class _BounceState extends State<Bounce> {
  bool mouseDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => mouseDown = true),
      onTapUp: (_) => setState(() => mouseDown = false),
      onTapCancel: () => setState(() => mouseDown = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: mouseDown ? widget.scale : 1,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
