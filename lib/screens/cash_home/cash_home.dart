import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/themes/custom_theme.dart';
import 'package:fusecash/utils/forks.dart';
import 'package:fusecash/widgets/main_scaffold2.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_header.dart';
import 'cash_transactions.dart';
import 'package:fusecash/models/views/cash_wallet.dart';

bool isDefaultCommunity(String communityAddress) {
  return DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'] != null &&
      DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'].toLowerCase() ==
          communityAddress;
}

class CashHomeScreen extends StatefulWidget {
  @override
  _CashHomeScreenState createState() => _CashHomeScreenState();
}

void updateTheme(CashWalletViewModel viewModel, Function _changeTheme,
    BuildContext context) {
  String communityAddress = viewModel.communityAddress;
  if (isPaywise(communityAddress)) {
    _changeTheme(context, MyThemeKeys.PAYWISE);
  } else if (isGoodDollar(communityAddress)) {
    _changeTheme(context, MyThemeKeys.GOOD_DOLLAR);
  } else if (isOpenMoney(communityAddress)) {
    _changeTheme(context, MyThemeKeys.OPEN_MONEY);
  } else if (isWepy(communityAddress)) {
    _changeTheme(context, MyThemeKeys.WEPY);
  } else {
    _changeTheme(context, MyThemeKeys.DEFAULT);
  }
}

void onChange(CashWalletViewModel viewModel, BuildContext context,
    {bool initial = false}) async {
  if (initial) {
    viewModel.syncContacts([]);
  }
  if (!viewModel.isJobProcessingStarted) {
    viewModel.startProcessingJobs();
  }
  if (!viewModel.isListeningToBranch) {
    viewModel.listenToBranch();
  }
  if (!viewModel.isCommunityLoading &&
      viewModel.branchAddress != null &&
      viewModel.branchAddress != "" &&
      viewModel.walletAddress != '') {
    viewModel.branchCommunityUpdate();
  }
  if (viewModel.walletStatus == null && viewModel.accountAddress != '') {
    viewModel.createWallet(viewModel.accountAddress);
    Future.delayed(Duration(seconds: 5), () {
      viewModel.identifyCall();
    });
  }
  if (!viewModel.isCommunityLoading &&
      !viewModel.isCommunityFetched &&
      viewModel.isBranchDataReceived &&
      viewModel.walletAddress != '') {
    viewModel.switchCommunity(viewModel.communityAddress);
  }
  if (viewModel.token != null) {
    if (!viewModel.isTransfersFetchingStarted) {
      viewModel.startTransfersFetching();
    }
  }
}

class _CashHomeScreenState extends State<CashHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInitialBuild: (viewModel) async {
          onChange(viewModel, context, initial: true);
        },
        onWillChange: (viewModel) async {
          updateTheme(viewModel, _changeTheme, context);
          onChange(viewModel, context);
        },
        builder: (_, viewModel) {
          return MainScaffold(
            header: CashHeader(),
            children: <Widget>[CashTransactios(viewModel: viewModel)],
            // floatingActionButton: isDefaultCommunity(viewModel.community.address) ? FloatingActionButton(
            //   heroTag: 'winWin',
            //   backgroundColor: Color(0xFFF1EFEE),
            //   child: Image.asset(
            //     'assets/images/win.png',
            //     width: 25.0,
            //   ),
            //   onPressed: () {
            //     print('open lottery page');
            //   },
            // ): null,
          );
        });
  }
}
