// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashWalletState _$CashWalletStateFromJson(Map<String, dynamic> json) {
  return CashWalletState(
    walletAddress: json['walletAddress'] as String,
    walletStatus: json['walletStatus'] as String,
    communityAddress: json['communityAddress'] as String,
    communityName: json['communityName'] as String,
    isCommunityLoading: json['isCommunityLoading'] as bool ?? false,
    isCommunityFetched: json['isCommunityFetched'] as bool ?? false,
    isBalanceFetchingStarted: json['isBalanceFetchingStarted'] as bool ?? false,
    isTransfersFetchingStarted:
        json['isTransfersFetchingStarted'] as bool ?? false,
    isListeningToBranch: json['isListeningToBranch'] as bool ?? false,
    isBranchDataReceived: json['isBranchDataReceived'] as bool ?? false,
    isCommunityBusinessesFetched:
        json['isCommunityBusinessesFetched'] as bool ?? false,
    isJobProcessingStarted: json['isJobProcessingStarted'] as bool ?? false,
    communities: CashWalletState._communitiesFromJson(
        json['communities'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CashWalletStateToJson(CashWalletState instance) =>
    <String, dynamic>{
      'walletStatus': instance.walletStatus,
      'walletAddress': instance.walletAddress,
      'communityAddress': instance.communityAddress,
      'communityName': instance.communityName,
      'communities': CashWalletState._communitiesToJson(instance.communities),
      'isCommunityLoading': instance.isCommunityLoading,
      'isCommunityFetched': instance.isCommunityFetched,
      'isCommunityBusinessesFetched': instance.isCommunityBusinessesFetched,
      'isBalanceFetchingStarted': instance.isBalanceFetchingStarted,
      'isTransfersFetchingStarted': instance.isTransfersFetchingStarted,
      'isListeningToBranch': instance.isListeningToBranch,
      'isBranchDataReceived': instance.isBranchDataReceived,
      'isJobProcessingStarted': instance.isJobProcessingStarted,
    };
