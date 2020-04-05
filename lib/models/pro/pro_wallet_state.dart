import 'package:flutter/material.dart';
import 'package:fusecash/models/pro/token.dart';
import 'package:wallet_core/wallet_core.dart' as wallet_core;
import 'package:json_annotation/json_annotation.dart';

part 'pro_wallet_state.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class ProWalletState {
  final List<Token> tokens;
  final num blockNumber;
  // @JsonKey(
  //     name: 'erc20Tokens',
  //     fromJson: _erc20TokensFromJson,
  //     toJson: _erc20TokensToJson)
  final Map<String, Token> erc20Tokens;

  @JsonKey(ignore: true)
  final wallet_core.Web3 web3;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isBalanceFetchingStarted;
  @JsonKey(ignore: true, defaultValue: false)
  final bool isListenToTransferEvents;


  // static Map<String, Token> _erc20TokensFromJson(
  //     Map<String, dynamic> tokens) {
  //   if (tokens == null) {
  //     return Map<String, Token>();
  //   } else {
  //     Map<String, Token> erc20Tokens = new Map<String, Token>();
  //     Iterable<MapEntry<String, Token>> entries =
  //         List.from(tokens['erc20Tokens']).map((token) => new MapEntry(
  //             (token['address'] as String).toLowerCase(),
  //             Token.fromJson(token)));
  //     erc20Tokens.addEntries(entries);
  //     return erc20Tokens;
  //   }
  // }

  // static Map<String, dynamic> _erc20TokensToJson(
  //         Map<String, Token> erc20Tokens) =>
  //     new Map<String, dynamic>.from({
  //       "erc20Tokens": List<Token>.from(erc20Tokens.values)
  //           .map((token) => token.toJson())
  //           .toList()
  //     });

  ProWalletState(
      {this.web3,
      this.blockNumber,
      this.tokens,
      this.isBalanceFetchingStarted,
      this.erc20Tokens,
      this.isListenToTransferEvents,
      });

  factory ProWalletState.initial() {
    return new ProWalletState(
      web3: null,
      blockNumber: 0,
      erc20Tokens: new Map<String, Token>(),
      tokens: new List<Token>(),
      isBalanceFetchingStarted: false,
      isListenToTransferEvents: false,
    );
  }

  ProWalletState copyWith({
    wallet_core.Web3 web3,
    bool isBalanceFetchingStarted,
    bool isListenToTransferEvents,
    bool isJobProcessingStarted,
    String walletAddress,
    List<Token> tokens,
    num blockNumber,
    Map<String, Token> erc20Tokens,
  }) {
    return ProWalletState(
      blockNumber: blockNumber ?? this.blockNumber,
        web3: web3 ?? this.web3,
        tokens: tokens ?? this.tokens,
        erc20Tokens: erc20Tokens ?? this.erc20Tokens,
        isBalanceFetchingStarted:
            isBalanceFetchingStarted ?? this.isBalanceFetchingStarted,
        isListenToTransferEvents:
            isListenToTransferEvents ?? this.isListenToTransferEvents,
        );
  }

  dynamic toJson() => _$ProWalletStateToJson(this);

  static ProWalletState fromJson(dynamic json) =>
      _$ProWalletStateFromJson(json);
}
