import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SwapIcon extends StatelessWidget {
  final void Function()? onTap;
  final bool isSwapped;
  const SwapIcon({
    Key? key,
    this.onTap,
    required this.isSwapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      onTap: onTap,
      child: isSwapped
          ? SvgPicture.asset(
              'assets/images/swap_icon2.svg',
              fit: BoxFit.fill,
              width: 70,
              height: 70,
            )
          : Image.asset(
              'assets/images/swap.png',
              width: 70,
              height: 70,
            ),
    );
  }
}
