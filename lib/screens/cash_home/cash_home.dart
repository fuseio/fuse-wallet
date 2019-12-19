import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/widgets/main_scaffold2.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'cash_header.dart';
import 'cash_transactions.dart';
import 'package:fusecash/models/views/cash_wallet.dart';


import 'package:contacts_service/contacts_service.dart';  
import 'package:permission_handler/permission_handler.dart';

class CashHomeScreen extends StatefulWidget {
  @override
  _CashHomeScreenState createState() => _CashHomeScreenState();
}


  Future<List<Contact>> loadContacts(CashWalletViewModel viewModel) async {
    PermissionStatus permission = (await PermissionHandler().requestPermissions([PermissionGroup.contacts]))[PermissionGroup.contacts];
    if (permission != PermissionStatus.granted) {
      logger.w('Permission to get the contracts denied');
      return null;
    }
    List<Contact> contacts = (await ContactsService.getContacts(withThumbnails: true)).toList();
    viewModel.syncContacts(contacts);
    return contacts;
  }


void onChange(CashWalletViewModel viewModel) {
  if (!viewModel.isListeningToBranch) {
    viewModel.listenToBranch();
  }
  if (viewModel.walletStatus == null && viewModel.accountAddress != '') {
    viewModel.createWallet(viewModel.accountAddress);
  }
  if (!viewModel.isCommunityLoading &&
      !viewModel.isCommunityFetched &&
      viewModel.isListeningToBranch &&
      viewModel.walletAddress != '') {
    viewModel.switchCommunity(viewModel.communityAddress);
    loadContacts(viewModel);
  }
  if (viewModel.token != null) {
    if (!viewModel.isBalanceFetchingStarted) {
      viewModel.startBalanceFetching();
    }
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, CashWalletViewModel>(
        distinct: true,
        converter: (Store<AppState> store) {
          return CashWalletViewModel.fromStore(store);
        },
        onInitialBuild: (viewModel) {
          onChange(viewModel);
        },
        onWillChange: (viewModel) {
          onChange(viewModel);
        },
        builder: (_, viewModel) {
          return MainScaffold(
            header: CashHeader(),
            children: <Widget>[CashTransactios(viewModel: viewModel)],
          );
        });
  }
}
