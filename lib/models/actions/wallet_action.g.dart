// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateWallet _$_$CreateWalletFromJson(Map<String, dynamic> json) {
  return _$CreateWallet(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'createWallet',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
  );
}

Map<String, dynamic> _$_$CreateWalletToJson(_$CreateWallet instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
    };

_$FiatDeposit _$_$FiatDepositFromJson(Map<String, dynamic> json) {
  return _$FiatDeposit(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'fiat-deposit',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String?,
    to: json['to'] as String,
    value: BigInt.parse(json['value'] as String),
    tokenName: json['tokenName'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
  );
}

Map<String, dynamic> _$_$FiatDepositToJson(_$FiatDeposit instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
    };

_$JoinCommunity _$_$JoinCommunityFromJson(Map<String, dynamic> json) {
  return _$JoinCommunity(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'joinCommunity',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    communityAddress: json['communityAddress'] as String?,
    tokenAddress: json['tokenAddress'] as String,
    communityName: json['communityName'] as String?,
  );
}

Map<String, dynamic> _$_$JoinCommunityToJson(_$JoinCommunity instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'communityAddress': instance.communityAddress,
      'tokenAddress': instance.tokenAddress,
      'communityName': instance.communityName,
    };

_$Bonus _$_$BonusFromJson(Map<String, dynamic> json) {
  return _$Bonus(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'tokenBonus',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String?,
    to: json['to'] as String,
    value: BigInt.parse(json['value'] as String),
    tokenName: json['tokenName'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
    bonusType: json['bonusType'] as String?,
  );
}

Map<String, dynamic> _$_$BonusToJson(_$Bonus instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'bonusType': instance.bonusType,
    };

_$Send _$_$SendFromJson(Map<String, dynamic> json) {
  return _$Send(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'sendTokens',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: BigInt.parse(json['value'] as String),
    tokenName: json['tokenName'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
  );
}

Map<String, dynamic> _$_$SendToJson(_$Send instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
    };

_$Receive _$_$ReceiveFromJson(Map<String, dynamic> json) {
  return _$Receive(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'receiveTokens',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: BigInt.parse(json['value'] as String),
    tokenName: json['tokenName'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
  );
}

Map<String, dynamic> _$_$ReceiveToJson(_$Receive instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'tokenAddress': instance.tokenAddress,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
    };

_$ClaimApy _$_$ClaimApyFromJson(Map<String, dynamic> json) {
  return _$ClaimApy(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'claimApy',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    from: json['from'] as String?,
    to: json['to'] as String?,
    value: BigInt.parse(json['value'] as String),
  );
}

Map<String, dynamic> _$_$ClaimApyToJson(_$ClaimApy instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'from': instance.from,
      'to': instance.to,
      'value': instance.value.toString(),
    };

_$Swap _$_$SwapFromJson(Map<String, dynamic> json) {
  return _$Swap(
    timestamp: json['timestamp'] as int? ?? 0,
    id: json['_id'] as String,
    name: json['name'] as String? ?? 'swapTokens',
    txHash: json['txHash'] as String?,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int? ?? 0,
    tradeInfo: json['metadata'] == null
        ? null
        : TradeInfo.fromJson(json['metadata'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$SwapToJson(_$Swap instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'metadata': instance.tradeInfo?.toJson(),
    };
