import 'package:flutter/widgets.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/utils/alerts/alerts.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';

abstract class SlWidget<S extends StatelessWidget> {
  Alerts get _alerts => getIt<Alerts>();

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
}
