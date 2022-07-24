import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:after_layout/after_layout.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/utils/alerts/alerts.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';

abstract class SfWidget<S extends StatefulWidget> extends State<S>
    with AfterLayoutMixin<S> {
  final _alerts = getIt<Alerts>();

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
  }

  @override
  @override
  @mustCallSuper
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onWidgetUpdate();
    });
  }

  @protected
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    onInitApp();
  }

  @protected
  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
  }

  @protected
  @mustCallSuper
  void throwException(
    BuildContext context,
    Exception exception, {
    StackTrace? stackTrace,
  }) =>
      _alerts.setException(
        context,
        exception,
        stackTrace: stackTrace,
      );

  @protected
  @mustCallSuper
  void throwAlert(
    BuildContext context,
    String message, {
    AlertsTypeEnum? type,
    AlertsPopupEnum? popupType,
    StackTrace? stackTrace,
    Duration? duration,
  }) =>
      _alerts.setAlert(
        context,
        message,
        type: type,
        stackTrace: stackTrace,
        popupType: popupType,
        duration: duration,
      );

  Future<void> onInitApp() async {}

  Future<void> onWidgetUpdate() async {}
}
