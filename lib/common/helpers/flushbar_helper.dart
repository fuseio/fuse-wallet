// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FlushbarHelper {
  Flushbar buildSnackbar({
    BuildContext? context,
    required String title,
    required String message,
    bool? isDismissible,
    Duration? duration,
    Color? backgroundColor,
    void Function(FlushbarStatus?)? onStatusChanged,
  }) {
    final _isDismissible = isDismissible ?? true;
    final _duration = duration ?? const Duration(milliseconds: 2000);
    final _backgroundColor = backgroundColor ?? Colors.black;
    ThemeData themeData = Theme.of(
      context ?? getIt<RootRouter>().root.navigatorKey.currentContext!,
    );
    final _flushbarInstance = Flushbar(
      onStatusChanged: onStatusChanged,
      titleText: Text(
        title,
        style: themeData.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: themeData.canvasColor,
        ),
      ),
      messageText: Text(
        message,
        style: themeData.textTheme.bodyMedium?.copyWith(
          color: themeData.canvasColor,
        ),
      ),
      icon: Icon(
        Icons.info_outline,
        color: themeData.colorScheme.primary,
      ),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: _backgroundColor,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0.5, 0.5),
          blurRadius: 5,
        ),
      ],
      isDismissible: _isDismissible,
      duration: _duration,
    );

    if (context == null) {
      return _flushbarInstance;
    }

    return _flushbarInstance..show(context);
  }

  Flushbar buildErrorSnackbar({
    BuildContext? context,
    required String title,
    required String message,
    required Duration? duration,
    void Function(FlushbarStatus?)? onStatusChanged,
  }) {
    return buildSnackbar(
      context: context,
      title: title,
      message: message,
      duration: duration,
      onStatusChanged: onStatusChanged,
    );
  }
}
