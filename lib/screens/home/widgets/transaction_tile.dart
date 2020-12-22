import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:roost/models/tokens/token.dart';
import 'package:roost/screens/home/router/home_router.gr.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roost/generated/i18n.dart';
import 'package:roost/models/app_state.dart';
import 'package:roost/models/community/community.dart';
import 'package:roost/models/transactions/transfer.dart';
import 'package:roost/utils/addresses.dart';
import 'package:roost/utils/transaction_util.dart';
import 'package:roost/utils/format.dart';

class TransactionTile extends StatefulWidget {
  final Transfer transfer;
  final Token token;

  TransactionTile({
    this.transfer,
    this.token,
  });

  @override
  _TransactionTileState createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _TransactionTileViewModel>(
        distinct: true,
        converter: _TransactionTileViewModel.fromStore,
        builder: (_, viewModel) {
          final Contact contact = getContact(
              widget.transfer,
              viewModel.reverseContacts,
              viewModel.contacts,
              viewModel.countryCode);
          Community community =
              viewModel.communitiesMap[widget.transfer?.tokenAddress];
          Token token = widget.token ??
              viewModel.tokens[widget.transfer?.tokenAddress?.toLowerCase()];
          bool isSendingToForeign = (community?.homeBridgeAddress != null &&
                  widget.transfer.to != null &&
                  widget.transfer.to?.toLowerCase() ==
                      community?.homeBridgeAddress?.toLowerCase()) ??
              false;
          bool isWalletCreated = 'created' == viewModel.walletStatus;
          bool isZeroAddress = widget.transfer.from == zeroAddress;
          ImageProvider<dynamic> image = getTransferImage(
              widget.transfer, contact, community,
              isZeroAddress: isZeroAddress);
          String displayName = widget.transfer.isJoinBonus()
              ? (widget.transfer.text ?? I18n.of(context).join_bonus)
              : ![null, ''].contains(widget.transfer.receiverName)
                  ? widget.transfer.receiverName
                  : ![null, ''].contains(widget.transfer.text)
                      ? widget.transfer.text
                      : contact != null
                          ? contact.displayName
                          : deducePhoneNumber(
                              widget.transfer, viewModel.reverseContacts,
                              businesses: community?.businesses);
          String amount = formatValue(widget.transfer?.value, token?.decimals);
          List<Widget> rightColumn = <Widget>[
            widget.transfer.isGenerateWallet() ||
                    widget.transfer.isJoinCommunity()
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
                                    text: " ${token?.symbol}",
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
                                  : deduceTransferIcon(widget.transfer),
                            ],
                          ),
                          Positioned(
                              bottom: -20,
                              child: widget.transfer.isPending()
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
                  border:
                      Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))), //
              child: ListTile(
                contentPadding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
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
                                    radius: 30,
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
                                  //     radius: 30,
                                  //     backgroundImage: image,
                                  //   ),
                                  //   tag: widget.transfer.isGenerateWallet()
                                  //       ? 'GenerateWallet'
                                  //       : widget.transfer.isPending()
                                  //           ? "contactSent"
                                  //           : "transaction" +
                                  //               (widget.transfer.txHash ??
                                  //                   widget.transfer?.timestamp
                                  //                       .toString()),
                                  // ),
                                  widget.transfer.isPending()
                                      ? Container(
                                          width: 60,
                                          height: 60,
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
                                  community?.metadata?.isDefaultImage != null &&
                                          community?.metadata?.isDefaultImage ==
                                              true &&
                                          widget.transfer.isJoinCommunity()
                                      ? Text(
                                          token?.symbol ?? '',
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
                                  widget.transfer.isJoinCommunity()
                                      ? RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: widget.transfer
                                                              .isJoinCommunity() &&
                                                          widget.transfer
                                                              .isPending()
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
                                  widget.transfer.isGenerateWallet() &&
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
                          child: widget.transfer.isFailed()
                              ? InkWell(
                                  onTap: () {
                                    // TODO - Resend fail job
                                  },
                                  child: Column(
                                      mainAxisAlignment:
                                          widget.transfer.isPending()
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          widget.transfer.isPending()
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.center,
                                      children: rightColumn),
                                )
                              : Column(
                                  mainAxisAlignment: widget.transfer.isPending()
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      widget.transfer.isPending()
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.center,
                                  children: rightColumn),
                        ))
                  ],
                ),
                onTap: () {
                  if (!widget.transfer.isGenerateWallet() &&
                      !widget.transfer.isJoinCommunity()) {
                    ExtendedNavigator.of(context).pushTransactionDetailsScreen(
                        transfer: widget.transfer,
                        contact: contact,
                        displayName: displayName,
                        image: image,
                        token: token);
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
  final Map<String, Token> tokens;
  final Map<String, Community> communitiesMap;
  _TransactionTileViewModel(
      {this.reverseContacts,
      this.walletStatus,
      this.countryCode,
      this.erc20Tokens,
      this.tokens,
      this.contacts,
      this.communitiesMap});

  static _TransactionTileViewModel fromStore(Store<AppState> store) {
    List<Community> communities =
        store.state.cashWalletState.communities.values.toList();
    List<Token> foreignTokens = List<Token>.from(
            store.state.proWalletState.erc20Tokens?.values ?? Iterable.empty())
        .toList();
    List<Token> homeTokens = store.state.cashWalletState.tokens.values
        .map((Token token) => token?.copyWith(
            imageUrl: store.state.cashWalletState.communities
                    .containsKey(token.communityAddress)
                ? store.state.cashWalletState
                    .communities[token.communityAddress].metadata
                    .getImageUri()
                : null))
        .toList();
    Map<String, Token> tokens =
        [...foreignTokens, ...homeTokens].fold(Map(), (previousValue, element) {
      previousValue.putIfAbsent(element.address.toLowerCase(), () => element);
      return previousValue;
    });

    Map<String, Community> communitiesMap =
        communities.fold(Map(), (previousValue, element) {
      previousValue.putIfAbsent(element.homeTokenAddress, () => element);
      return previousValue;
    });
    return _TransactionTileViewModel(
        tokens: tokens,
        reverseContacts: store.state.userState.reverseContacts,
        contacts: store.state.userState.contacts,
        walletStatus: store.state.userState.walletStatus,
        countryCode: store.state.userState.countryCode,
        erc20Tokens: store.state.proWalletState.erc20Tokens,
        communitiesMap: communitiesMap);
  }

  @override
  List<Object> get props => [
        reverseContacts,
        walletStatus,
        countryCode,
        contacts,
        erc20Tokens,
        tokens,
        communitiesMap
      ];
}
