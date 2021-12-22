// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_modules.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletModules _$$_WalletModulesFromJson(Map<String, dynamic> json) =>
    _$_WalletModules(
      guardianManager: json['GuardianManager'] as String,
      lockManager: json['LockManager'] as String,
      recoveryManager: json['RecoveryManager'] as String,
      approvedTransfer: json['ApprovedTransfer'] as String,
      tokenExchanger: json['TokenExchanger'] as String,
      communityManager: json['CommunityManager'] as String,
      walletOwnershipManager: json['WalletOwnershipManager'] as String,
      daiPointsManager: json['DAIPointsManager'] as String,
      transferManager: json['TransferManager'] as String,
    );

Map<String, dynamic> _$$_WalletModulesToJson(_$_WalletModules instance) =>
    <String, dynamic>{
      'GuardianManager': instance.guardianManager,
      'LockManager': instance.lockManager,
      'RecoveryManager': instance.recoveryManager,
      'ApprovedTransfer': instance.approvedTransfer,
      'TokenExchanger': instance.tokenExchanger,
      'CommunityManager': instance.communityManager,
      'WalletOwnershipManager': instance.walletOwnershipManager,
      'DAIPointsManager': instance.daiPointsManager,
      'TransferManager': instance.transferManager,
    };
