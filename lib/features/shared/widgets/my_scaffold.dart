import 'dart:core';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold({
    required this.title,
    required this.body,
    this.automaticallyImplyLeading = true,
    this.resizeToAvoidBottomInset = true,
    this.actions,
  });
  final String title;
  final List<Widget>? actions;
  final Widget body;
  final bool automaticallyImplyLeading;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        actions: actions,
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Europa',
          ),
          softWrap: true,
        ),
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).colorScheme.onSurface,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(
            4.0,
          ),
        ),
      ),
      body: body,
    );
  }
}
