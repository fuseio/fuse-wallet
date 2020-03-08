import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/themes/app_theme.dart';
import 'package:fusecash/themes/custom_theme.dart';
import 'package:fusecash/utils/contacts.dart';
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
          communityAddress.toLowerCase();
}

void updateTheme(String communityAddress, Function _changeTheme, BuildContext context) {
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

void onChange(CashWalletViewModel viewModel, BuildContext context) async {
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
  if (viewModel.walletStatus != 'deploying' && viewModel.walletStatus != 'created' && viewModel.accountAddress != '') {
    viewModel.createWallet(viewModel.accountAddress);
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

class CashHomeScreen extends StatelessWidget {

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInit: (store) async {
          bool isPermitted = await Contacts.checkPermissions();
          if (isPermitted) {
            List<Contact> contacts = await ContactController.getContacts();
            store.dispatch(syncContactsCall(contacts));
          }
        },
        onInitialBuild: (viewModel) async {
          onChange(viewModel, context);
        },
        onWillChange: (prevViewModel, nextViewModel) async {
          if (prevViewModel.communityAddress != nextViewModel.communityAddress) {
            updateTheme(nextViewModel.communityAddress, _changeTheme, context);
          }
          onChange(nextViewModel, context);
        },
        builder: (_, viewModel) {
          bool isWalletCreated = 'created' == viewModel.walletStatus;
          return MainScaffold(
              showFooter: isWalletCreated,
              header: CashHeader(),
              children: <Widget>[CashTransactios(viewModel: viewModel)]);
        });
  }
}
