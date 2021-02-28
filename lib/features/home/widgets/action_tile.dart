import 'package:auto_route/auto_route.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/redux/viewsmodels/transfer_tile.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/transfer.dart';
import 'package:fusecash/features/home/router/home_router.gr.dart';

class ActionTile extends StatelessWidget {
  final WalletAction action;

  ActionTile({
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, TransferTileViewModel>(
      distinct: true,
      converter: TransferTileViewModel.fromStore,
      builder: (_, viewModel) {
        final String accountAddress = action.map(
          createWallet: (value) => null,
          fiatProcess: (value) => null,
          joinCommunity: (value) => null,
          fiatDeposit: (value) => value.from,
          bonus: (value) => value.from,
          send: (value) => value.to,
          receive: (value) => value.from,
        );

        final Contact contact = getContact(
          accountAddress,
          viewModel.reverseContacts,
          viewModel.contacts,
          viewModel.countryCode,
        );
        final Community community = action.map(
          createWallet: (value) => null,
          fiatProcess: (value) => null,
          joinCommunity: (value) =>
              viewModel.communities[value.communityAddress.toLowerCase()],
          fiatDeposit: (value) => null,
          bonus: (value) => null,
          send: (value) => null,
          receive: (value) => null,
        );
        final ImageProvider<dynamic> image = ImageUrl.getActionImage(
          action,
          contact,
          community,
          accountAddress,
        );
        final String displayName = action.map(
          createWallet: (value) => value.getText(),
          fiatProcess: (value) => value.getText(),
          joinCommunity: (value) => value.getText(),
          fiatDeposit: (value) => value.getText(),
          bonus: (value) => value.getText(),
          send: (value) => contact != null
              ? contact.displayName
              : deducePhoneNumber(
                        accountAddress,
                        viewModel.reverseContacts,
                        businesses: community?.businesses,
                      ) !=
                      null
                  ? deducePhoneNumber(
                      accountAddress,
                      viewModel.reverseContacts,
                      businesses: community?.businesses,
                    )
                  : action.getText(),
          receive: (value) => contact != null
              ? contact.displayName
              : deducePhoneNumber(
                        accountAddress,
                        viewModel.reverseContacts,
                        businesses: community?.businesses,
                      ) !=
                      null
                  ? deducePhoneNumber(
                      accountAddress,
                      viewModel.reverseContacts,
                      businesses: community?.businesses,
                    )
                  : action.getText(),
        );
        final String symbol = action.map(
          createWallet: (value) => '',
          fiatProcess: (value) => '',
          joinCommunity: (value) => '',
          fiatDeposit: (value) => value.tokenSymbol,
          bonus: (value) =>
              viewModel?.tokens[value?.tokenAddress?.toLowerCase()]?.symbol ??
              '',
          send: (value) => value.tokenSymbol,
          receive: (value) => value.tokenSymbol,
        );

        final Widget rightColumn = Flexible(
          flex: 3,
          child: Container(
            child: Column(
              mainAxisAlignment: action.isPending()
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: action.isPending()
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.center,
              children: <Widget>[
                action.isGenerateWallet() || action.isJoinCommunity()
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
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: action.getAmount(),
                                          style: TextStyle(
                                            color: Color(0xFF696969),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: symbol,
                                          style: TextStyle(
                                            color: Color(0xFF696969),
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  action.getActionIcon()
                                ],
                              ),
                              Positioned(
                                bottom: -20,
                                child: action.isPending()
                                    ? Padding(
                                        child: Text(
                                          I18n.of(context).pending,
                                          style: TextStyle(
                                            color: Color(0xFF8D8D8D),
                                            fontSize: 10,
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                          top: 10,
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              )
                            ],
                          )
                        ],
                      )
              ],
            ),
          ),
        );

        return ListTile(
          contentPadding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: 15,
            right: 15,
          ),
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
                            Hero(
                              child: CircleAvatar(
                                backgroundColor: Color(0xFFE0E0E0),
                                radius: 30,
                                backgroundImage: image,
                              ),
                              tag: action.hashCode,
                            ),
                            action.isPending()
                                ? Container(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color(0xFF49D88D).withOpacity(0),
                                      strokeWidth: 3,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF49D88D).withOpacity(1),
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            community?.metadata?.isDefaultImage != null &&
                                    community?.metadata?.isDefaultImage ==
                                        true &&
                                    action.isJoinCommunity()
                                ? Text(
                                    action.map(
                                      createWallet: (value) => '',
                                      fiatProcess: (value) => '',
                                      joinCommunity: (value) =>
                                          viewModel
                                              .tokens[value?.tokenAddress
                                                  ?.toLowerCase()]
                                              .symbol ??
                                          '',
                                      fiatDeposit: (value) => value.tokenSymbol,
                                      bonus: (value) => value.tokenSymbol,
                                      send: (value) => value.tokenSymbol,
                                      receive: (value) => value.tokenSymbol,
                                    ),
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
                            action.isJoinCommunity()
                                ? RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: action.isJoinCommunity() &&
                                                  action.isPending()
                                              ? I18n.of(context).joining
                                              : I18n.of(context).joined,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                        action.getText() != null
                                            ? TextSpan(
                                                text:
                                                    ' \‘${action.getText()}\’ ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.onSurface,
                                                ),
                                              )
                                            : SizedBox.shrink(),
                                        TextSpan(
                                          text: I18n.of(context).community,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Text(
                                    displayName,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 15,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  )),
              // rightColumn widget
              action.isFiatProccesing() ? SizedBox.shrink() : rightColumn
            ],
          ),
          onTap: () {
            if (!action.isGenerateWallet() && !action.isJoinCommunity()) {
              ExtendedNavigator.of(context).pushActionDetailsScreen(
                accountAddress: accountAddress,
                contact: contact,
                displayName: displayName,
                action: action,
                image: image,
                symbol: symbol,
              );
            }
          },
        );
      },
    );
  }
}
