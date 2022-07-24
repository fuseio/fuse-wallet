import 'dart:core';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';

import 'package:fusecash/features/shared/widgets/back_btn.dart';

class InnerScaffold extends StatelessWidget {
  const InnerScaffold({
    Key? key,
    this.title,
    required this.body,
    this.automaticallyImplyLeading = true,
    this.resizeToAvoidBottomInset = true,
    this.hasScrollBody = true,
    this.bottomContent,
    this.actions,
    this.backgroundColor,
    this.padding = const EdgeInsets.only(
      bottom: 20,
    ),
    this.expandedHeight = 120,
  }) : super(key: key);
  final String? title;
  final List<Widget>? actions;
  final Widget body;
  final Widget? bottomContent;
  final bool automaticallyImplyLeading;
  final bool resizeToAvoidBottomInset;
  final bool hasScrollBody;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Theme.of(context).canvasColor,
            actions: actions,
            leading: MyBackBtn(
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            pinned: true,
            expandedHeight: expandedHeight,
            backgroundColor: backgroundColor ?? Theme.of(context).canvasColor,
            flexibleSpace: (title != null)
                ? CustomizableSpaceBar(
                    builder: (context, scrollingRate) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 17,
                          left: 20 + 20 * scrollingRate,
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 1 + 10 * scrollingRate,
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  title!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28 - 10 * scrollingRate,
                                      ),
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : null,
          ),
          SliverFillRemaining(
            hasScrollBody: hasScrollBody,
            child: Container(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: body),
                  bottomContent != null
                      ? bottomContent!
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
