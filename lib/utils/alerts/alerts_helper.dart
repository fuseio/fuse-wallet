import 'package:flutter/widgets.dart';
import 'package:fusecash/common/exceptions/exceptions.dart';
import 'package:fusecash/constants/errors.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AlertsHelper {
  AlertsModel getAlert(
    BuildContext context,
    String body, {
    AlertsTypeEnum? alertType,
    AlertsPopupEnum? alertTypePopupType,
    StackTrace? stackTrace,
    Duration? duration,
  }) {
    String title;
    final type = alertType ?? AlertsTypeEnum.ERROR;
    final popupType = alertTypePopupType ?? AlertsPopupEnum.FLUSHBAR;

    switch (type) {
      case AlertsTypeEnum.INFO:
        title = 'Info!';

        log.info(title, error: body, stackTrace: stackTrace);
        break;
      case AlertsTypeEnum.WARNING:
        title = 'Warning!';

        log.warn(title, error: body, stackTrace: stackTrace);
        break;
      case AlertsTypeEnum.SUCCESS:
        title = 'Great!';
        break;
      case AlertsTypeEnum.ERROR:
      default:
        title = 'Oops... Some error occurred!';

        log.error(title, error: body, stackTrace: stackTrace);
        break;
    }

    return AlertsModel(
      context: context,
      body: body,
      title: title,
      type: type,
      popupType: popupType,
      duration: duration,
    );
  }

  AlertsModel getException(
    BuildContext context,
    Exception exception, {
    required StackTrace? stackTrace,
  }) {
    String body;

    if (exception is BadNetworkException) {
      body = Errors.BAD_NETWORK_MESSAGE;
    } else if (exception is UnauthenticatedException) {
      body = Errors.INVALID_UNAUTHENTICATED_MESSAGE;
    } else if (exception is ApiException) {
      body = Errors.INVALID_API_MESSAGE;
    } else if (exception is InternalServerException) {
      body = Errors.INTERNAL_SERVER_MESSAGE;
    } else if (exception is CacheException) {
      body = Errors.CACHE_FAILURE_MESSAGE;
    } else if (exception is ApiErrorMessageException &&
        exception.errorMessage != null) {
      body = exception.errorMessage!;
    } else {
      body = Errors.UNKNOWN_FAILURE_MESSAGE;
    }

    return getAlert(context, body);
  }
}
