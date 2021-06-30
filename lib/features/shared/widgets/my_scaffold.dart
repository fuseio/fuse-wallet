import 'dart:core';
import 'package:flutter/material.dart';

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
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
      ),
      body: body,
    );
  }
}
