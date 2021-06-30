import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fusecash/features/shared/widgets/my_app_bar.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold({
    required this.title,
    required this.body,
    this.automaticallyImplyLeading = true,
    this.resizeToAvoidBottomInset = true,
  });
  final String title;
  final Widget body;
  final bool automaticallyImplyLeading;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: MyAppBar(
        height: kToolbarHeight,
        backgroundColor: Colors.white,
        child: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context)
                .colorScheme
                .onSurface, //change your color here
          ),
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Europa',
              color: Theme.of(context).colorScheme.onSurface,
            ),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
