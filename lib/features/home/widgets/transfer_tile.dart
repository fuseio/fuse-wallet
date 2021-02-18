import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/models/transactions/transaction.dart';
import 'package:fusecash/redux/viewsmodels/transfer_tile.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/transfer.dart';
import 'package:fusecash/utils/format.dart';

class TransferTile extends StatelessWidget {
  final Transaction transfer;
  final Token token;

  TransferTile({
    this.transfer,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, TransferTileViewModel>(
      distinct: true,
      converter: TransferTileViewModel.fromStore,
      builder: (_, viewModel) {
        final accountAddress =
            transfer.type == 'SEND' ? transfer.to : transfer.from;
        final Contact contact = getContact(
          accountAddress,
          viewModel.reverseContacts,
          viewModel.contacts,
          viewModel.countryCode,
        );
        Community community = viewModel.communitiesMap[transfer?.tokenAddress];
        Token token1 =
            token ?? viewModel.tokens[transfer?.tokenAddress?.toLowerCase()];
        ImageProvider<dynamic> image = ImageUrl.getTransferImage(
          transfer,
          contact,
          community,
        );
        String displayName = transfer.getText() != null
            ? transfer.getText()
            : contact != null
                ? contact.displayName
                : deducePhoneNumber(
                    accountAddress,
                    viewModel.reverseContacts,
                    businesses: community?.businesses,
                  );
        String amount = formatValue(transfer?.value, token1?.decimals);
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
                                  text: " ${token1?.symbol}",
                                  style: TextStyle(
                                      color: Color(0xFF696969),
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.normal)),
                            ])),
                            SizedBox(
                              width: 5,
                            ),
                            // isZeroAddress || isSendingToForeign
                            //     ? SvgPicture.asset(
                            //         'assets/images/bridge_icon.svg',
                            //         width: 8,
                            //         height: 8,
                            //       )
                            //     :
                            deduceTransferIcon(transfer),
                          ],
                        ),
                        Positioned(
                            bottom: -20,
                            child: transfer.isPending()
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
              border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))), //
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
                              transfer.isPending()
                                  ? Container(
                                      width: 60,
                                      height: 60,
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Color(0xFF49D88D).withOpacity(0),
                                        strokeWidth: 3,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Color(0xFF49D88D).withOpacity(1)),
                                      ))
                                  : SizedBox.shrink(),
                              community?.metadata?.isDefaultImage != null &&
                                      community?.metadata?.isDefaultImage ==
                                          true &&
                                      transfer.isJoinCommunity()
                                  ? Text(
                                      token1?.symbol ?? '',
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
                                              text:
                                                  transfer.isJoinCommunity() &&
                                                          transfer.isPending()
                                                      ? I18n.of(context).joining
                                                      : I18n.of(context).joined,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          TextSpan(
                                              text:
                                                  ' \‘${community?.name ?? ''}\’ ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: I18n.of(context).community,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    )
                                  : Text(displayName,
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 15)),
                            ],
                          ),
                        ),
                      ],
                    )),
                // rightColumn widget
                transfer.isFiatProccesing()
                    ? SizedBox.shrink()
                    : Flexible(
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
                        ),
                      )
              ],
            ),
            onTap: () {
              if (!transfer.isGenerateWallet() && !transfer.isJoinCommunity()) {
                ExtendedNavigator.of(context).pushTransactionDetailsScreen(
                    transfer: transfer,
                    contact: contact,
                    displayName: displayName,
                    image: image,
                    token: token1);
              }
            },
          ),
        );
      },
    );
  }
}
