import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/redux/actions/cash_wallet_actions.dart';
import 'package:fusecash/screens/home/widgets/transaction_tile.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

class Feed extends StatefulWidget {
  Feed({this.withTitle = true});
  final bool withTitle;
  @override
  createState() => new FeedState();
}

class FeedState extends State<Feed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    return new StoreConnector<AppState, _FeedModel>(
        converter: _FeedModel.fromStore,
        distinct: true,
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
          final Transfer generateWallet = Transfer(
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
          return RefreshIndicator(
              onRefresh: () async {
                viewModel.refreshFeed();
                await Future.delayed(Duration(milliseconds: 1000));
                return 'success';
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  child: Column(
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
                            itemBuilder: (BuildContext ctxt, int index) =>
                                TransactionTile(transfer: feedList[index])),
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height *
                      (widget.withTitle ? .65 : .565),
                ),
              ));
        });
  }
}

class _FeedModel extends Equatable {
  final List<Transaction> feedList;
  final String walletStatus;
  final Function() startTransfersFetching;
  final Function() startProcessingJobs;
  final Function() refreshFeed;

  _FeedModel({
    this.feedList,
    this.walletStatus,
    this.startTransfersFetching,
    this.startProcessingJobs,
    this.refreshFeed,
  });

  static _FeedModel fromStore(Store<AppState> store) {
    List<Transaction> tokensTxs = store.state.cashWalletState.tokens?.values
        ?.fold(
            [],
            (List<Transaction> previousValue, Token token) =>
                previousValue..addAll(token?.transactions?.list ?? []));

    List<Transaction> erc20TokensTxs =
        store.state.proWalletState.erc20Tokens?.values?.fold(
            [],
            (List<Transaction> previousValue, Token token) =>
                previousValue..addAll(token?.transactions?.list ?? []));
    List<Transaction> feedList = [...tokensTxs, ...erc20TokensTxs]
      ..sort((a, b) => (b?.timestamp ?? 0).compareTo((a?.timestamp ?? 0)));
    return _FeedModel(
        feedList: feedList,
        walletStatus: store.state.userState.walletStatus,
        startTransfersFetching: () {
          store.dispatch(startTransfersFetchingCall());
        },
        startProcessingJobs: () {
          store.dispatch(startProcessingJobsCall());
        },
        refreshFeed: () {
          store.dispatch(fetchListOfTokensByAddress());
          store.dispatch(ResetTokenTxs());
        });
  }

  @override
  List<Object> get props => [feedList];
}
