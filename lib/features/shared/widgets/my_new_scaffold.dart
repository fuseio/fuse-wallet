import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:customizable_space_bar/customizable_space_bar.dart';

class MyNewScaffold extends StatelessWidget {
  const MyNewScaffold({
    required this.title,
    required this.body,
    Key? key,
    this.automaticallyImplyLeading = true,
    this.resizeToAvoidBottomInset = true,
    this.actions,
    this.hasScrollBody = true,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;
  final Widget body;
  final bool automaticallyImplyLeading;
  final bool resizeToAvoidBottomInset;
  final bool hasScrollBody;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      sized: false,
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              surfaceTintColor: Theme.of(context).canvasColor,
              actions: actions,
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 120,
              backgroundColor: Theme.of(context).canvasColor,
              flexibleSpace: CustomizableSpaceBar(
                builder: (context, scrollingRate) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 20 + 1 * scrollingRate,
                      bottom: 17,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              title,
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
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: hasScrollBody,
              child: Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: body),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
