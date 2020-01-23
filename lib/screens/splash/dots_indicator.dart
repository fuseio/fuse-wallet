import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  // static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  // static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Container(
          width: 9.0,
          height: 9.0,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(100.0),
            color: index == controller.page?.round()
                ? const Color(0xFF696B6D)
                : const Color(0xFF969899),
          ),
          child: new InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
