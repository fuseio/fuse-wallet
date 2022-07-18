import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/widgets/fade_slide_transition.dart';

class WelcomeFrame extends StatelessWidget {
  const WelcomeFrame({
    Key? key,
    required this.title,
    this.delay = 500,
    required this.subTitle,
  }) : super(key: key);

  final int delay;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyFadeSlideTransition(
            delay: delay,
            end: const Offset(0.0, 0.5),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    color: const Color(0xFF808080),
                  ),
            ),
          ),
          MyFadeSlideTransition(
            delay: delay + 50,
            child: AutoSizeText(
              subTitle,
              maxLines: 3,
              minFontSize: 25,
              maxFontSize: 27,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
