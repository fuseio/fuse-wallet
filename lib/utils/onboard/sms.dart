import 'package:auto_route/auto_route.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';
import 'package:fusecash/common/router/routes.gr.dart';

class SmsStrategy implements IOnBoardStrategy {
  final OnboardStrategy strategy;
  SmsStrategy({this.strategy = OnboardStrategy.sms});

  @override
  Future login(store, phoneNumber) async {
    await api.loginWithSMS(phoneNumber);
    store.dispatch(SetIsLoginRequest(isLoading: false));
    // Todo - pushVerifyScreen
    // ExtendedNavigator.root.pushVerifyScreen();
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
