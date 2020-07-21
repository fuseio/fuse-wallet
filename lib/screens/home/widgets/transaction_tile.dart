import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/screens/home/router/home_router.gr.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/transactions/transfer.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/transaction_util.dart';
import 'package:fusecash/utils/format.dart';

class TransactionTile extends StatelessWidget {
  final Transfer transfer;

  TransactionTile({
    this.transfer,
  });

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _TransactionTileViewModel>(
        distinct: true,
        converter: _TransactionTileViewModel.fromStore,
        builder: (_, viewModel) {
          final Contact contact = getContact(
              transfer,
              viewModel.reverseContacts,
              viewModel.contacts,
              viewModel.countryCode);
          Community community =
              getTCommunity(transfer?.tokenAddress, viewModel.communities);
          Token token;
          if (transfer.tokenAddress == null) {
            token = community.token;
          } else {
            token = getToken(transfer.tokenAddress.toLowerCase(),
                viewModel.communities, viewModel.erc20Tokens);
          }
          // Community community = getTCommunity(
          //     token.address ?? transfer.tokenAddress, viewModel.communities);

          bool isSendingToForeign = (community.homeBridgeAddress != null &&
                  transfer.to != null &&
                  transfer.to?.toLowerCase() ==
                      community.homeBridgeAddress?.toLowerCase()) ??
              false;
          bool isWalletCreated = 'created' == viewModel.walletStatus;
          bool isZeroAddress = transfer.from == zeroAddress;
          ImageProvider<dynamic> image = isZeroAddress
              ? AssetImage(
                  'assets/images/ethereume_icon.png',
                )
              : getTransferImage(transfer, contact, community);
          String displayName = transfer.isJoinBonus()
              ? (transfer.text ?? I18n.of(context).join_bonus)
              : (transfer.receiverName != null && transfer.receiverName != '')
                  ? transfer.receiverName
                  : transfer.text != null
                      ? transfer.text
                      : contact != null
                          ? contact.displayName
                          : deducePhoneNumber(
                              transfer, viewModel.reverseContacts,
                              businesses: community.businesses);
          String amount = formatValue(transfer.value, token.decimals);
          List<Widget> rightColumn = <Widget>[
            transfer.isGenerateWallet() || transfer.isJoinCommunity()
                ? SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        overflow: Overflow.visible,
                        alignment: AlignmentDirectional.bottomEnd,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: amount,
                                    style: TextStyle(
                                        color: Color(0xFF696969),
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: " ${token.symbol}",
                                    style: TextStyle(
                                        color: Color(0xFF696969),
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.normal)),
                              ])),
                              SizedBox(
                                width: 5,
                              ),
                              isZeroAddress || isSendingToForeign
                                  ? SvgPicture.asset(
                                      'assets/images/bridge_icon.svg',
                                      width: 8,
                                      height: 8,
                                    )
                                  : deduceTransferIcon(transfer),
                            ],
                          ),
                          Positioned(
                              bottom: -20,
                              child: (transfer.isPending() &&
                                      !transfer.isGenerateWallet() &&
                                      !transfer.isJoinCommunity())
                                  ? Padding(
                                      child: Text(I18n.of(context).pending,
                                          style: TextStyle(
                                              color: Color(0xFF8D8D8D),
                                              fontSize: 10)),
                                      padding: EdgeInsets.only(top: 10))
                                  : SizedBox.shrink())
                        ],
                      )
                    ],
                  )
          ];

          return Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: const Color(0xFFDCDCDC)))),
              child: ListTile(
                contentPadding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 0),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        flex: 11,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            // image widget
                            Flexible(
                              flex: 4,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Color(0xFFE0E0E0),
                                    radius: 27,
                                    backgroundImage: image,
                                  ),
                                  // Positioned(
                                  //   bottom: 0,
                                  //   right: 0,
                                  //   child: SvgPicture.asset(
                                  //     'assets/images/${isFuseTxs ? 'fuse' : 'ethereum'}_network.svg',
                                  //     fit: BoxFit.contain,
                                  //     width: 20,
                                  //     height: 20,
                                  //   ),
                                  // ),
                                  // Hero(
                                  //   child: CircleAvatar(
                                  //     backgroundColor: Color(0xFFE0E0E0),
                                  //     radius: 27,
                                  //     backgroundImage: image,
                                  //   ),
                                  //   tag: transfer.isGenerateWallet()
                                  //       ? 'GenerateWallet'
                                  //       : transfer.isPending()
                                  //           ? "contactSent"
                                  //           : "transaction" +
                                  //               (transfer.txHash ??
                                  //                   transfer?.timestamp
                                  //                       .toString()),
                                  // ),
                                  transfer.isPending()
                                      ? Container(
                                          width: 55,
                                          height: 55,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Color(0xFF49D88D)
                                                .withOpacity(0),
                                            strokeWidth: 3,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xFF49D88D)
                                                        .withOpacity(1)),
                                          ))
                                      : SizedBox.shrink(),
                                  community.metadata.isDefaultImage != null &&
                                          community.metadata.isDefaultImage &&
                                          transfer.isJoinCommunity()
                                      ? Text(
                                          token.symbol,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        )
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            // text widget
                            Flexible(
                              flex: 10,
                              child: Stack(
                                overflow: Overflow.visible,
                                alignment: AlignmentDirectional.bottomStart,
                                children: <Widget>[
                                  transfer.isJoinCommunity()
                                      ? RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: transfer
                                                              .isJoinCommunity() &&
                                                          transfer.isPending()
                                                      ? I18n.of(context).joining
                                                      : I18n.of(context).joined,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text:
                                                      ' \‘${community?.name ?? ''}\’ ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              TextSpan(
                                                  text: I18n.of(context)
                                                      .community,
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          isZeroAddress
                                              ? I18n.of(context)
                                                  .received_from_ethereum
                                              : isSendingToForeign
                                                  ? I18n.of(context)
                                                      .sent_to_ethereum
                                                  : displayName,
                                          style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 15)),
                                  transfer.isGenerateWallet() &&
                                          !isWalletCreated
                                      ? Positioned(
                                          bottom: -20,
                                          child: Padding(
                                              child: Text('(up to 10 seconds)',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary)),
                                              padding:
                                                  EdgeInsets.only(top: 10)))
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          ],
                        )),
                    // rightColumn widget
                    Flexible(
                        flex: 3,
                        child: Container(
                          child: transfer.isFailed()
                              ? InkWell(
                                  onTap: () {
                                    // TODO - Resend fail job
                                  },
                                  child: Column(
                                      mainAxisAlignment: transfer.isPending()
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.center,
                                      crossAxisAlignment: transfer.isPending()
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.center,
                                      children: rightColumn),
                                )
                              : Column(
                                  mainAxisAlignment: transfer.isPending()
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                                  crossAxisAlignment: transfer.isPending()
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.center,
                                  children: rightColumn),
                        ))
                  ],
                ),
                onTap: () {
                  if (!transfer.isGenerateWallet() &&
                      !transfer.isJoinCommunity()) {
                    ExtendedNavigator.of(context)
                        .push(HomeRoutes.transactionDetailsScreen,
                            arguments: TransactionDetailsScreenArguments(
                              transfer: transfer,
                              contact: contact,
                              from: displayName,
                              image: image,
                              token: token,
                              amount: [
                                Text(
                                  amount,
                                  style: TextStyle(
                                      color: Color(0xFF696969),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " ${token.symbol}",
                                  style: TextStyle(
                                      color: Color(0xFF696969),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ));
                  }
                },
              ));
        });
  }
}

class _TransactionTileViewModel extends Equatable {
  final Map<String, String> reverseContacts;
  final String walletStatus;
  final List<Contact> contacts;
  final String countryCode;
  final Map<String, Token> erc20Tokens;
  final Map<String, Community> communities;

  _TransactionTileViewModel(
      {this.reverseContacts,
      this.walletStatus,
      this.countryCode,
      this.communities,
      this.erc20Tokens,
      this.contacts});

  static _TransactionTileViewModel fromStore(Store<AppState> store) {
    return _TransactionTileViewModel(
      reverseContacts: store.state.userState.reverseContacts,
      contacts: store.state.userState.contacts,
      walletStatus: store.state.userState.walletStatus,
      countryCode: store.state.userState.countryCode,
      erc20Tokens: store.state.proWalletState.erc20Tokens,
      communities: store.state.cashWalletState.communities,
    );
  }

  @override
  List<Object> get props => [
        reverseContacts,
        walletStatus,
        communities,
        countryCode,
        contacts,
        erc20Tokens
      ];
}
