import 'package:esol/widgets/custom_rectangle.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/community/community.dart';
import 'package:esol/models/tokens/token.dart';
import 'package:esol/models/transactions/transaction.dart';
import 'package:esol/models/transactions/transfer.dart';
import 'package:esol/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:esol/redux/actions/cash_wallet_actions.dart';
import 'package:esol/screens/home/widgets/transaction_tile.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.withTitle
                  //Addtion Added For Curved Rectangle
                  ? CustomRectangle(
                      borderSize: 20,
                      borderColor: Colors.white,
                      height: 40.0,
                      borderRadius: 40.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, top: 20),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          child: Text(
                            I18n.of(context).transactions,
                          ),
                        ),
                      ),
                    )
                  //Addtion End
                  //  Container(
                  //     width: double.infinity,
                  //     padding: EdgeInsets.only(left: 15, top: 20),
                  //     child: Text(I18n.of(context).transactions,
                  //         textAlign: TextAlign.start,
                  //         style: TextStyle(
                  //             color: Color(0xFF979797),
                  //             fontSize: 13.0,
                  //             fontWeight: FontWeight.normal)))
                  : SizedBox.shrink(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  itemCount: feedList?.length,
                  itemBuilder: (BuildContext ctxt, int index) =>
                      //Added to set the Card Style of the Container
                      Container(
                    child: Column(children: [
                      Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                          child: TransactionTile(transfer: feedList[index])),
                    ]),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class DummyTile extends StatelessWidget {
  final Color text;
  DummyTile({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.w3schools.com/howto/img_avatar.png'),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          title: Text('Gustavo'),
          subtitle: Text('20/06/2020'),
          trailing: Text(
            '-5 E-SOL',
            style: TextStyle(color: text),
          ),
        ),
      ),
    );
  }
}

class _FeedModel extends Equatable {
  final List<Transaction> feedList;
  final String walletStatus;
  final Function() startTransfersFetching;
  final Function() startProcessingJobs;
  final Function() refreshFeed;
  final List<Community> communities;

  _FeedModel({
    this.feedList,
    this.walletStatus,
    this.startTransfersFetching,
    this.startProcessingJobs,
    this.refreshFeed,
    this.communities,
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
        communities: store.state.cashWalletState.communities.values.toList(),
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
  List<Object> get props => [feedList, communities, walletStatus];
}
