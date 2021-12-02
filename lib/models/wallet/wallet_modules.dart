import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_modules.freezed.dart';
part 'wallet_modules.g.dart';

@immutable
@freezed
class WalletModules with _$WalletModules {
  @JsonSerializable()
  factory WalletModules({
    @JsonKey(name: 'GuardianManager') required String guardianManager,
    @JsonKey(name: 'LockManager') required String lockManager,
    @JsonKey(name: 'RecoveryManager') required String recoveryManager,
    @JsonKey(name: 'ApprovedTransfer') required String approvedTransfer,
    @JsonKey(name: 'TokenExchanger') required String tokenExchanger,
    @JsonKey(name: 'CommunityManager') required String communityManager,
    @JsonKey(name: 'WalletOwnershipManager')
        required String walletOwnershipManager,
    @JsonKey(name: 'DAIPointsManager') required String daiPointsManager,
    @JsonKey(name: 'TransferManager') required String transferManager,
  }) = _WalletModules;

  factory WalletModules.fromJson(Map<String, dynamic> json) =>
      _$WalletModulesFromJson(json);
}
