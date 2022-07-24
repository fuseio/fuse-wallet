import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/onboard/base_strategy.dart';

class SimpleStrategy implements IOnBoardStrategy {
  @override
  OnboardStrategy strategy;
  SimpleStrategy({this.strategy = OnboardStrategy.none});

  @override
  Future login(
    store,
    phoneNumber,
    Function onSuccess,
    Function(dynamic error) onError,
  ) async {
    final String accountAddress = store.state.userState.accountAddress;
    final jwtToken = await chargeApi.requestToken(
      phoneNumber,
      accountAddress,
    );
    store.dispatch(LoginVerifySuccess(jwtToken));
    Analytics.track(
      eventName: AnalyticsEvents.verify,
      properties: {
        AnalyticsProps.status: AnalyticsProps.success,
      },
    );
    rootRouter.push(const UserNameRoute());
    onSuccess();
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    // No need
  }
}
