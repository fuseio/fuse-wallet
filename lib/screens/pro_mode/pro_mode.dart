import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/screens/pro_mode/pro_header.dart';
import 'package:fusecash/screens/pro_mode/pro_mode_main_scaffold.dart';
import 'package:fusecash/utils/contacts.dart';
// import 'package:fusecash/widgets/main_scaffold2.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/views/cash_wallet.dart';

void onChange(CashWalletViewModel viewModel, BuildContext context,
    {bool initial = false}) async {
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
  if (initial) {
    bool isPermitted = await Contacts.checkPermissions();
    if (isPermitted) {
      List<Contact> contacts = await ContactController.getContacts();
      viewModel.syncContacts(contacts);
    }
  }
}

class ProModeHomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: CashWalletViewModel.fromStore,
        onInitialBuild: (viewModel) async {
          onChange(viewModel, context, initial: true);
        },
        onWillChange: (prevViewModel, nextViewModel) async {
          onChange(nextViewModel, context);
        },
        builder: (_, viewModel) {
          return MainScaffold(
              isProMode: true,
              showFooter: true,
              header: ProHeader(),
              children: <Widget>[]);
        });
  }
}
