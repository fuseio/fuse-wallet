import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {
  const Preloader({
    this.width = 60,
    this.height = 60,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(left: 28, right: 28),
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

extension PreloaderExtension on Preloader {
  Future<T?> showSheet<T>(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => this,
    );
  }
}
