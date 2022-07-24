// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flash/flash.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FlashHelper {
  Completer<BuildContext> _buildCompleter = Completer<BuildContext>();

  void init(BuildContext context) {
    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.complete(context);
    }
  }

  void dispose() {
    if (_buildCompleter.isCompleted == false) {
      _buildCompleter.completeError(FlutterError('disposed'));
    }

    _buildCompleter = Completer<BuildContext>();
  }

  Color _backgroundColor(BuildContext context) {
    final theme = Theme.of(context);

    return theme.dialogTheme.backgroundColor ?? theme.dialogBackgroundColor;
  }

  TextStyle _titleStyle(BuildContext context, [Color? color]) {
    final theme = Theme.of(context);

    return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.headline6)!
        .copyWith(color: color);
  }

  TextStyle _contentStyle(BuildContext context, [Color? color]) {
    final theme = Theme.of(context);

    return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyText2)!
        .copyWith(color: color);
  }

  Future<T?> toast<T>(String message) async {
    final context = await _buildCompleter.future;

    return showFlash<T>(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          alignment: const Alignment(0, 0.5),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          backgroundColor: Colors.black87,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(message),
            ),
          ),
        );
      },
    );
  }

  Future<T?> snackBar<T>(
    BuildContext context, {
    required String message,
    String? title,
    Widget? primaryAction,
    ActionCallback? onPrimaryActionTap,
    HorizontalDismissDirection horizontalDismissDirection =
        HorizontalDismissDirection.horizontal,
    Color backgroundColor = Colors.black87,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    Duration? duration,
    WillPopCallback? onWillPop,
    Function(FlashController<T> controller)? flashControllerCb,
  }) {
    final _margin = margin ?? const EdgeInsets.only(bottom: 0);
    final _borderRadius =
        borderRadius ?? const BorderRadius.all(Radius.circular(0));
    final _duration = duration ?? const Duration(seconds: 3);

    return showFlash<T>(
      context: context,
      duration: _duration,
      onWillPop: onWillPop ?? onWillPop!,
      persistent: false,
      builder: (context, controller) {
        if (flashControllerCb != null) {
          flashControllerCb(controller);
        }

        return Flash(
          controller: controller,
          horizontalDismissDirection: horizontalDismissDirection,
          backgroundColor: backgroundColor,
          margin: _margin,
          borderRadius: _borderRadius,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            primaryAction: onPrimaryActionTap == null
                ? ElevatedButton(
                    onPressed: onPrimaryActionTap == null
                        ? null
                        : () => onPrimaryActionTap(controller),
                    child: primaryAction == null ? primaryAction! : Container(),
                  )
                : null,
          ),
        );
      },
    );
  }

  Future<T?> simpleDialog<T>(
    BuildContext context, {
    String? title,
    required String message,
    Widget? negativeAction,
    ActionCallback? negativeActionTap,
    Widget? positiveAction,
    ActionCallback? positiveActionTap,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      builder: (context, controller) {
        return Flash.dialog(
          controller: controller,
          backgroundColor: _backgroundColor(context),
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: FlashBar(
            title:
                title == null ? null : Text(title, style: _titleStyle(context)),
            content: Text(message, style: _contentStyle(context)),
            actions: [
              if (negativeAction != null)
                ElevatedButton(
                  onPressed: negativeActionTap == null
                      ? null
                      : () => negativeActionTap(controller),
                  child: negativeAction,
                ),
              if (positiveAction != null)
                ElevatedButton(
                  onPressed: positiveActionTap == null
                      ? null
                      : () => positiveActionTap(controller),
                  child: positiveAction,
                ),
            ],
          ),
        );
      },
    );
  }

  Future<T?> successBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration? duration,
  }) {
    final _duration = duration ?? const Duration(seconds: 3);

    return showFlash<T>(
      context: context,
      duration: _duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.check_circle, color: Colors.green[300]),
            indicatorColor: Colors.green[300],
          ),
        );
      },
    );
  }

  Future<T?> informationBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration? duration,
  }) {
    final _duration = duration ?? const Duration(seconds: 3);

    return showFlash<T>(
      context: context,
      duration: _duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.info_outline, color: Colors.blue[300]),
            indicatorColor: Colors.blue[300],
          ),
        );
      },
    );
  }

  Future<T?> errorBar<T>(
    BuildContext context, {
    String? title,
    required String message,
    Duration? duration,
  }) {
    final _duration = duration ?? const Duration(seconds: 3);

    return showFlash<T>(
      context: context,
      duration: _duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          backgroundColor: Colors.black87,
          child: FlashBar(
            title: title == null
                ? null
                : Text(title, style: _titleStyle(context, Colors.white)),
            content: Text(message, style: _contentStyle(context, Colors.white)),
            icon: Icon(Icons.warning, color: Colors.red[300]),
            indicatorColor: Colors.red[300],
          ),
        );
      },
    );
  }

  Future<T?> blockDialog<T>(
    BuildContext context, {
    required Completer<T> dismissCompleter,
  }) {
    return showFlash<T>(
      context: context,
      persistent: false,
      onWillPop: () => Future.value(false),
      builder: (context, FlashController<T> controller) {
        dismissCompleter.future.then((value) => controller.dismiss(value));
        return Flash.dialog(
          controller: controller,
          barrierDismissible: false,
          backgroundColor: Colors.black87,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      },
    );
  }
}

typedef ActionCallback = void Function(FlashController controller);
