import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_fgbg/flutter_fgbg.dart';

class BackgroundDetector extends StatefulWidget {
  final Duration allowedDurationOnBackground;
  final VoidCallback onAllowedDurationExpired;

  final Widget child;

  const BackgroundDetector({
    required this.child,
    this.allowedDurationOnBackground = Duration.zero,
    required this.onAllowedDurationExpired,
    Key? key,
  }) : super(key: key);

  @override
  State<BackgroundDetector> createState() => _BackgroundDetectorState();
}

class _BackgroundDetectorState extends State<BackgroundDetector> {
  Timer? _timer;

  void _onGoToForegroundOrBackground(FGBGType value) {
    if (value == FGBGType.background) {
      _timer = Timer.periodic(widget.allowedDurationOnBackground, (_) {
        widget.onAllowedDurationExpired();
        _timer!.cancel();
      });
    } else if (value == FGBGType.foreground) {
      if (_timer != null) _timer!.cancel();
    }
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FGBGNotifier(
      onEvent: _onGoToForegroundOrBackground,
      child: widget.child,
    );
  }
}
