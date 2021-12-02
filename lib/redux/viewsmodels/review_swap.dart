import 'package:flutter/material.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/models/swap/swap.dart';
import 'package:supervecina/redux/actions/cash_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';

class ReviewSwapViewModel extends Equatable {
  final String walletAddress;
  final Function(
    SwapRequestBody swapRequestBody,
    SwapCallParameters swapCallParameters,
    TradeInfo tradeInfo,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) swap;

  ReviewSwapViewModel({
    required this.walletAddress,
    required this.swap,
  });

  static ReviewSwapViewModel fromStore(Store<AppState> store) {
    return ReviewSwapViewModel(
      walletAddress: store.state.userState.walletAddress,
      swap: (
        SwapRequestBody swapRequestBody,
        SwapCallParameters swapCallParameters,
        TradeInfo tradeInfo,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(swapHandler(
          swapRequestBody,
          swapCallParameters,
          tradeInfo,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }

  @override
  List<Object> get props => [walletAddress];
}
