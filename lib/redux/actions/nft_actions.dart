import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:collection/collection.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/log/log.dart';

class AddCollectibles {
  final Map<String, Map<int, Collectible>> collectibles;

  AddCollectibles({
    required this.collectibles,
  });
}

ThunkAction handleSendERC721(
  Collectible collectible,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback, {
  String? receiverAddress,
  String? phoneNumber,
}) {
  return (Store store) async {
    try {
      final WalletModules walletModules = store.state.userState.walletModules;
      String walletAddress = store.state.userState.walletAddress;
      final Map transactionBody = Map.from({
        "from": walletAddress,
        "to": receiverAddress,
        'tokenAddress': collectible.collectionAddress,
        "status": 'pending',
        'metadata': collectible.toJson(),
      });
      if (walletModules.nftTransfer != null) {
        dynamic response;
        if (receiverAddress != null) {
          if (isValidEthereumAddress(
              checksumEthereumAddress(receiverAddress))) {
            response = await chargeApi.nftTransfer(
              getIt<Web3>(),
              walletModules.nftTransfer!,
              walletAddress,
              collectible.collectionAddress,
              receiverAddress,
              num.parse(collectible.id),
              transactionBody: transactionBody,
            );
          }
        } else if (phoneNumber != null) {
          String senderName = store.state.userState.displayName;
          final inviteRes = await chargeApi.invite(
            phoneNumber,
            name: senderName,
            symbol: collectible.collectionSymbol,
          );
          final String receiverAddress =
              inviteRes['job']['data']["walletAddress"];
          response = await chargeApi.nftTransfer(
            getIt<Web3>(),
            walletModules.nftTransfer!,
            walletAddress,
            collectible.collectionAddress,
            receiverAddress,
            num.parse(collectible.id),
            transactionBody: transactionBody,
          );
        }
        dynamic jobId = response['job']['_id'];
        log.info('Job $jobId for sending token sent to the relay service');
        store.dispatch(
          fetchJobCall(
            jobId,
            (Map jobData) {
              Analytics.track(
                eventName: AnalyticsEvents.send4Approve,
                properties: {"status": "success"},
              );
            },
            (dynamic failReason) {
              Analytics.track(
                eventName: AnalyticsEvents.send4Approve,
                properties: {
                  "status": "failed",
                  'failReason': failReason,
                },
              );
            },
          ),
        );
        sendSuccessCallback();
      }
    } catch (e, s) {
      sendFailureCallback();
      log.error(
        'ERROR - handleSendERC721',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction fetchCollectibles() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      Map<String, Map<int, Collectible>> collectibles =
          await graph.getCollectiblesByOwner(
        walletAddress,
      );
      if (!(const DeepCollectionEquality()
          .equals(collectibles, store.state.nftsState.collectibles))) {
        store.dispatch(
          AddCollectibles(
            collectibles: collectibles,
          ),
        );
      }
    } catch (e, s) {
      log.error(
        'FUSE NFT subgraph error',
        error: e,
        stackTrace: s,
      );
    }
  };
}
