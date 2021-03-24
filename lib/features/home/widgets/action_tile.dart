import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:flutter/material.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/community/community.dart';
import 'package:fusecash/redux/viewsmodels/transfer_tile.dart';
import 'package:fusecash/utils/addresses.dart';
import 'package:fusecash/utils/images.dart';
import 'package:fusecash/utils/transfer.dart';
import 'package:fusecash/common/router/routes.gr.dart';

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
        final Contact contact = getContact(
          action.getSender(),
          viewModel.reverseContacts,
          viewModel.contacts,
          viewModel.countryCode,
        );
        final Community community = action.map(
          createWallet: (value) => null,
          fiatProcess: (value) => null,
          joinCommunity: (value) =>
              viewModel.communities[value.communityAddress.toLowerCase()],
          fiatDeposit: (value) =>
              viewModel.communities[defaultCommunityAddress.toLowerCase()],
          bonus: (value) => null,
          send: (value) => null,
          receive: (value) => null,
          swap: (value) => null,
        );
        final bool isCommunityToken = ![false, null].contains(
          community?.metadata?.isDefaultImage,
        );
        final ImageProvider<dynamic> image = ImageUrl.getActionImage(
          action,
          contact,
          community,
          action.getSender(),
          viewModel.tokensImages,
        );
        final String displayName = action.map(
          createWallet: (value) => value.getText(),
          fiatProcess: (value) => value.getText(),
          joinCommunity: (value) => value.getText(),
          fiatDeposit: (value) => value.getText(),
          bonus: (value) => value.getText(),
          swap: (value) => value.getText(),
          send: (value) => contact != null
              ? contact.displayName
              : deducePhoneNumber(
                        action.getSender(),
                        viewModel.reverseContacts,
                        businesses: community?.businesses,
                      ) !=
                      null
                  ? deducePhoneNumber(
                      action.getSender(),
                      viewModel.reverseContacts,
                      businesses: community?.businesses,
                    )
                  : action.getText(),
          receive: (value) => contact != null
              ? contact.displayName
              : deducePhoneNumber(
                        action.getSender(),
                        viewModel.reverseContacts,
                        businesses: community?.businesses,
                      ) !=
                      null
                  ? deducePhoneNumber(
                      action.getSender(),
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
          swap: (value) => value.tradeInfo.outputToken,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  AutoSizeText.rich(
                                    TextSpan(
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
                                          text: ' $symbol ',
                                          style: TextStyle(
                                            color: Color(0xFF696969),
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
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
                          ),
                        ],
                      ),
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
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          isCommunityToken && action.isJoinCommunity()
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
                                    swap: (value) => '',
                                  ),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              : SizedBox.shrink(),
                          isCommunityToken
                              ? Text(
                                  symbol,
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
                                    style: TextStyle(
                                      fontFamily: 'Europa',
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: action.isJoinCommunity() &&
                                                action.isPending()
                                            ? I18n.of(context).joining
                                            : I18n.of(context).joined,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                      action.getText() != null
                                          ? TextSpan(
                                              text: ' \‘${action.getText()}\’ ',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      TextSpan(
                                        text: I18n.of(context).community,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : action.isSwapAction()
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          action.map(
                                            createWallet: (value) => '',
                                            fiatProcess: (value) => '',
                                            joinCommunity: (value) => '',
                                            fiatDeposit: (value) => '',
                                            bonus: (value) => '',
                                            send: (value) => '',
                                            receive: (value) => '',
                                            swap: (value) =>
                                                value.tradeInfo.inputToken,
                                          ),
                                          style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: SvgPicture.asset(
                                            'assets/images/swap_arrow.svg',
                                            width: 19,
                                            height: 8,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                            action.map(
                                              createWallet: (value) => '',
                                              fiatProcess: (value) => '',
                                              joinCommunity: (value) => '',
                                              fiatDeposit: (value) => '',
                                              bonus: (value) => '',
                                              send: (value) => '',
                                              receive: (value) => '',
                                              swap: (value) =>
                                                  value.tradeInfo.outputToken,
                                            ),
                                            style: TextStyle(
                                              color: Color(0xFF333333),
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : AutoSizeText(
                                      displayName,
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                      ),
                                    ),
                          action.isGenerateWallet() && action.isPending()
                              ? Positioned(
                                  bottom: -20,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      I18n.of(context).up_to_10,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // rightColumn widget
              action.isFiatProcessing() ? SizedBox.shrink() : rightColumn
            ],
          ),
          onTap: () {
            if (!action.isGenerateWallet() && !action.isJoinCommunity()) {
              ExtendedNavigator.root.pushActionDetailsScreen(
                accountAddress: action.getSender(),
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
