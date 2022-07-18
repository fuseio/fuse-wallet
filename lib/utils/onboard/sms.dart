import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/onboard/base_strategy.dart';

class SmsStrategy implements IOnBoardStrategy {
  @override
  OnboardStrategy strategy;
  SmsStrategy({this.strategy = OnboardStrategy.sms});

  @override
  Future login(
    store,
    phoneNumber,
    Function onSuccess,
    Function(dynamic error) onError,
  ) async {
    await chargeApi.loginWithSMS(phoneNumber);
    rootRouter.push(VerifyPhoneNumberRoute());
    onSuccess();
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    final String phoneNumber = store.state.userState.phoneNumber;
    final String accountAddress = store.state.userState.accountAddress;
    final String jwtToken = await chargeApi.verifySMS(
      verificationCode,
      phoneNumber,
      accountAddress,
    );
    onSuccess(jwtToken);
  }
}
