import 'package:auto_route/auto_route.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/common/router/routes.gr.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';

class SimpleStrategy implements IOnBoardStrategy {
  final OnboardStrategy strategy;
  SimpleStrategy({this.strategy = OnboardStrategy.none});

  @override
  Future login(store, phoneNumber) async {
    final String accountAddress = store.state.userState.accountAddress;
    final jwtToken = await api.requestToken(phoneNumber, accountAddress);
    log.info('jwtToken $jwtToken');
    store.dispatch(LoginVerifySuccess(jwtToken));
    store.dispatch(SetIsVerifyRequest(isLoading: false));
    store.dispatch(segmentTrackCall("Wallet: verified phone number"));
    ExtendedNavigator.root.pushUserNameScreen();
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    // No need
  }
}
