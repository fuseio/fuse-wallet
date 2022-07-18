import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

class BottomBarViewModel {
  final Function getSwapListBalances;
  final Function scrollToTop;

  BottomBarViewModel({
    required this.getSwapListBalances,
    required this.scrollToTop,
  });

  static BottomBarViewModel fromStore(Store<AppState> store) {
    return BottomBarViewModel(
      getSwapListBalances: () {
        store.dispatch(fetchSwapBalances());
      },
      scrollToTop: () {
        store.dispatch(ScrollToTop(true));
        Future.delayed(const Duration(milliseconds: 300), () {
          store.dispatch(ScrollToTop(false));
        });
      },
    );
  }
}
