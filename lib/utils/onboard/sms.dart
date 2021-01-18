import 'package:auto_route/auto_route.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';
import 'package:fusecash/common/router/routes.gr.dart';

class SmsStrategy extends IOnBoardStrategy {
  SmsStrategy({strategy}) : super(strategy: strategy ?? OnboardStatergy.sms);

  @override
  Future login(store, phoneNumber) async {
    await api.loginWithSMS(phoneNumber);
    store.dispatch(SetIsLoginRequest(isLoading: false));
    ExtendedNavigator.root.pushVerifyScreen();
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    final String phoneNumber = store.state.userState.phoneNumber;
    final String accountAddress = store.state.userState.accountAddress;
    final String jwtToken = await api.verifySMS(
      verificationCode,
      phoneNumber,
      accountAddress,
    );
    onSuccess(jwtToken);
  }
}
