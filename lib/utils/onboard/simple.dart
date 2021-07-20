import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';

class SimpleStrategy implements IOnBoardStrategy {
  final OnboardStrategy strategy;
  SimpleStrategy({this.strategy = OnboardStrategy.none});

  @override
  Future login(store, phoneNumber) async {
    final String accountAddress = store.state.userState.accountAddress;
    final jwtToken = await api.requestToken(phoneNumber, accountAddress);
    store.dispatch(LoginVerifySuccess(jwtToken));
    store.dispatch(SetIsVerifyRequest(isLoading: false));
    Segment.track(
      eventName: 'Sign up: VerificationCode_NextBtn_Press',
    );
    rootRouter.push(UserNameScreen());
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    // No need
  }
}
