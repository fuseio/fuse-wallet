import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';

import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';

class ReviewSwapViewModel extends Equatable {
  final String walletAddress;
  final Function(
    TradeRequestBody swapRequestBody,
    Trade tradeInfo,
    VoidCallback sendSuccessCallback,
    void Function(dynamic) sendFailureCallback,
  ) swap;

  const ReviewSwapViewModel({
    required this.walletAddress,
    required this.swap,
  });

  static ReviewSwapViewModel fromStore(Store<AppState> store) {
    return ReviewSwapViewModel(
      walletAddress: store.state.userState.walletAddress,
      swap: (
        TradeRequestBody swapRequestBody,
        Trade tradeInfo,
        VoidCallback sendSuccessCallback,
        void Function(dynamic) sendFailureCallback,
      ) {
        store.dispatch(swapHandler(
          swapRequestBody,
          tradeInfo,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }

  @override
  List<Object?> get props => [walletAddress];
}
