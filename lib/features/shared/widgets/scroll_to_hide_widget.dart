import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  const ScrollToHideWidget({
    Key? key,
    required this.child,
    required this.controller,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;
  bool showBottomBar = false;

  void show() {
    if (!isVisible) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void hide() {
    if (isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: widget.duration.inMilliseconds * 5),
        () {
      if (mounted) {
        setState(() {
          showBottomBar = true;
        });
      }
    });
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return showBottomBar
        ? AnimatedContainer(
            height: isVisible ? 60 : 0,
            duration: widget.duration,
            child: Wrap(
              children: [
                widget.child,
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
