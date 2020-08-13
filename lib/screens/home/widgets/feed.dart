import 'package:flutter_redux/flutter_redux.dart';
import 'package:curadai/generated/i18n.dart';
import 'package:curadai/models/transactions/transaction.dart';
import 'package:curadai/models/transactions/transfer.dart';
import 'package:curadai/models/app_state.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:curadai/redux/actions/cash_wallet_actions.dart';
import 'package:curadai/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';
import 'package:curadai/models/views/home.dart';
import 'package:curadai/screens/home/widgets/transaction_tile.dart';

class Feed extends StatefulWidget {
  Feed({this.withTitle = true});
  final bool withTitle;
  @override
  createState() => new FeedState();
}

class FeedState extends State<Feed> {
  FeedState();

  @override
  void initState() {
    super.initState();
  }

  void onInit(Store<AppState> store) {
    final bool isCommunityFetched =
        store.state.cashWalletState.isCommunityFetched ?? false;
    final bool isBranchDataReceived =
        store.state.cashWalletState.isBranchDataReceived ?? false;
    final bool isCommunityLoading =
        store.state.cashWalletState.isCommunityLoading ?? false;
    final String walletAddress = store.state.userState.walletAddress ?? false;
    final String communityAddress =
        store.state.cashWalletState?.communityAddress;
    final branchAddress = store.state.cashWalletState.branchAddress;
    final String isoCode = store.state.userState.isoCode;
    final String identifier = store.state.userState.identifier;

    if ([null, ''].contains(identifier)) {
      store.dispatch(setDeviceId(true));
    }
    if ([null, ''].contains(isoCode)) {
      Locale myLocale = Localizations.localeOf(context);
      Map localeData = codes.firstWhere(
          (Map code) => code['code'] == myLocale.countryCode,
          orElse: () => null);
      store.dispatch(setCountryCode(CountryCode(
          dialCode: localeData['dial_code'], code: localeData['code'])));
    }

    if (!isCommunityLoading &&
        !isBranchDataReceived &&
        !isCommunityFetched &&
        walletAddress != null &&
        walletAddress != '') {
      store.dispatch(switchCommunityCall(communityAddress));
    }

    if (!isCommunityLoading &&
        !isBranchDataReceived &&
        !isCommunityFetched &&
        ![null, ''].contains(branchAddress) &&
        ![null, ''].contains(walletAddress)) {
      store.dispatch(switchCommunityCall(branchAddress));
    }
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, HomeViewModel>(
        converter: HomeViewModel.fromStore,
        onInit: onInit,
        onInitialBuild: (viewModel) {
          viewModel.startProcessingJobs();
          viewModel.startTransfersFetching();
        },
        onWillChange: (prevViewModel, nextViewModel) {
          nextViewModel.startProcessingJobs();
          nextViewModel.startTransfersFetching();
        },
        builder: (_, viewModel) {
          final bool isWalletCreated = 'created' == viewModel.walletStatus;
          final Transfer generateWallet = new Transfer(
              type: 'RECEIVE',
              text: !isWalletCreated
                  ? I18n.of(context).generating_wallet
                  : I18n.of(context).generated_wallet,
              status: !isWalletCreated ? 'PENDING' : 'CONFIRMED',
              jobId: 'generateWallet');
          final List<Transaction> feedList = [
            ...viewModel.feedList,
            generateWallet,
          ];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.withTitle
                  ? Container(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      child: Text(I18n.of(context).transactions,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 13.0,
                              fontWeight: FontWeight.normal)))
                  : SizedBox.shrink(),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(top: 10),
                    itemCount: feedList?.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return TransactionTile(transfer: feedList[index]);
                    }),
              )
            ],
          );
        });
  }
}
