import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  final Color textColor;
  final Widget rightIcon;
  final Function() rightButtonFn;
  final Widget leftIcon;
  final Function() leftButtonFn;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;
  final double? height;

  const NumericKeyboard({
    Key? key,
    required this.onKeyboardTap,
    this.textColor = Colors.black,
    required this.rightButtonFn,
    required this.rightIcon,
    required this.leftButtonFn,
    required this.leftIcon,
    this.height,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
  }) : super(key: key);

  @override
  State<NumericKeyboard> createState() => _NumericKeyboardState();
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              InkWell(
                splashColor: Theme.of(context).canvasColor,
                hoverColor: Theme.of(context).canvasColor,
                focusColor: Theme.of(context).canvasColor,
                highlightColor: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(45),
                onTap: widget.leftButtonFn,
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: widget.leftIcon,
                ),
              ),
              _calcButton('0'),
              InkWell(
                splashColor: Theme.of(context).canvasColor,
                hoverColor: Theme.of(context).canvasColor,
                focusColor: Theme.of(context).canvasColor,
                highlightColor: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(45),
                onTap: widget.rightButtonFn,
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: widget.rightIcon,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
      splashColor: Theme.of(context).canvasColor,
      hoverColor: Theme.of(context).canvasColor,
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        widget.onKeyboardTap(value);
      },
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 60,
        child: AutoSizeText(
          value,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: widget.textColor,
              ),
        ),
      ),
    );
  }
}
