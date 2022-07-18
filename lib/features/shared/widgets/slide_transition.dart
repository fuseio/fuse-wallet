import 'dart:async';

import 'package:flutter/material.dart';

class MySlideTransition extends StatefulWidget {
  final Widget child;
  final int delay;
  final Offset? begin;
  final Offset? end;
  final Duration? animationDuration;

  const MySlideTransition({
    Key? key,
    required this.child,
    required this.delay,
    this.begin = Offset.zero,
    this.end = const Offset(0.0, 0.35),
    this.animationDuration = const Duration(
      milliseconds: 300,
    ),
  }) : super(key: key);

  @override
  State<MySlideTransition> createState() => _MySlideTransitionState();
}

class _MySlideTransitionState extends State<MySlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    _animController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset = Tween<Offset>(
      begin: widget.begin,
      end: widget.end,
    ).animate(curve);

    Timer(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _animController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animOffset,
      child: widget.child,
    );
  }
}
