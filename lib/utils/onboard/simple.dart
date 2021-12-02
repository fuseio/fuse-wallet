import 'package:supervecina/common/router/routes.dart';
import 'package:supervecina/constants/enums.dart';
import 'package:supervecina/constants/strings.dart';
import 'package:supervecina/redux/actions/user_actions.dart';
import 'package:supervecina/services.dart';
import 'package:supervecina/utils/onboard/Istrategy.dart';

class SimpleStrategy implements IOnBoardStrategy {
  @override
  final OnboardStrategy strategy;
  SimpleStrategy({this.strategy = OnboardStrategy.none});

  @override
  Future login(
    store,
    phoneNumber,
    Function onSuccess,
    Function(dynamic error) onError,
  ) async {
    final String accountAddress = store.state.userState.accountAddress;
    final jwtToken = await walletApi.requestToken(
      phoneNumber,
      accountAddress,
      appName: Strings.appName,
    );
    store.dispatch(LoginVerifySuccess(jwtToken));
    rootRouter.push(UserNameScreen());
    onSuccess();
  }

  @override
  Future verify(store, verificationCode, onSuccess) async {
    // No need
  }
}
