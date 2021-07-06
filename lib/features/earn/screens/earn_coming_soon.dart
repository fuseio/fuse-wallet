import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/earn/dialogs/learn_more.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';

class EarnComingSoonScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MyScaffold(
      title: I10n.of(context).earn,
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: SvgPicture.asset(
                'assets/images/green_fusd.svg',
              ),
            ),
            Positioned(
              top: 50,
              right: 10,
              child: SvgPicture.asset(
                'assets/images/white_fusd.svg',
              ),
            ),
            Positioned(
              bottom: 80,
              left: -50,
              child: SvgPicture.asset(
                'assets/images/white_fusd.svg',
              ),
            ),
            Positioned(
              bottom: 50,
              right: -30,
              child: SvgPicture.asset(
                'assets/images/green_fusd.svg',
              ),
            ),
            Positioned(
              bottom: 30,
              child: OutlinedButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * .7, 50),
                  primary: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  I10n.of(context).coming_soon + '!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/earn_header.svg',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Text(
                      I10n.of(context).earn_description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => LearnMoreDialog(),
                      );
                    },
                    focusColor: Theme.of(context).canvasColor,
                    highlightColor: Theme.of(context).canvasColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          I10n.of(context).learn_about_fuse_dollar,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          'assets/images/deposit_arrow.svg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
