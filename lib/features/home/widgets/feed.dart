import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/features/home/widgets/transfer_tile.dart';
import 'package:fusecash/redux/viewsmodels/feed.dart';

class Feed extends StatelessWidget {
  Feed({this.withTitle = true});
  final bool withTitle;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, FeedViewModel>(
        converter: FeedViewModel.fromStore,
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
          final Transfer generateWallet = Transfer(
            type: 'RECEIVE',
            text: !viewModel.isWalletCreated
                ? I18n.of(context).generating_wallet
                : I18n.of(context).generated_wallet,
            status: !viewModel.isWalletCreated ? 'PENDING' : 'CONFIRMED',
            jobId: 'generateWallet',
          );
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
                    withTitle
                        ? Container(
                            padding: EdgeInsets.only(left: 15, top: 20),
                            child: Text(
                              I18n.of(context).transactions,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(top: 10),
                        itemCount: feedList?.length,
                        itemBuilder: (BuildContext ctxt, int index) =>
                            TransferTile(
                          transfer: feedList[index],
                        ),
                      ),
                    )
                  ],
                ),
                height: MediaQuery.of(context).size.height *
                    (withTitle ? .66 : .576),
              ),
            ),
          );
        });
  }
}
