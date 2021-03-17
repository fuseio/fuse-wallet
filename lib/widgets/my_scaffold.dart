import 'dart:core';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  MyScaffold({
    this.title,
    this.body,
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
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Container(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              fontFamily: 'Europa',
            ),
            softWrap: true,
          ),
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
