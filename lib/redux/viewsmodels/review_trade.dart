import 'package:flutter/material.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/actions/pro_mode_wallet_actions.dart';
import 'package:redux/redux.dart';
import 'package:equatable/equatable.dart';

class ReviewTradeScreenViewModel extends Equatable {
  final String walletAddress;
  final Function(
      Token fromToken,
      Token toToken,
      String tokenAddress,
      num tokensAmount,
      num tokensAmountIn,
      String swapContractAddress,
      String swapData,
      VoidCallback sendSuccessCallback,
      VoidCallback sendFailureCallback) swap;

  ReviewTradeScreenViewModel({this.walletAddress, this.swap});

  static ReviewTradeScreenViewModel fromStore(Store<AppState> store) {
    return ReviewTradeScreenViewModel(
      walletAddress: store.state.userState.walletAddress,
      swap: (
        Token fromToken,
        Token toToken,
        String tokenAddress,
        num tokensAmount,
        num tokensAmountIn,
        String swapContractAddress,
        String swapData,
        VoidCallback sendSuccessCallback,
        VoidCallback sendFailureCallback,
      ) {
        store.dispatch(swapHandler(
          fromToken,
          toToken,
          tokenAddress,
          tokensAmount,
          tokensAmountIn,
          swapContractAddress,
          swapData,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      },
    );
  }

  @override
  List<Object> get props => [walletAddress];
}
