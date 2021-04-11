// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateWallet _$_$CreateWalletFromJson(Map<String, dynamic> json) {
  return _$CreateWallet(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
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

_$FiatProcess _$_$FiatProcessFromJson(Map<String, dynamic> json) {
  return _$FiatProcess(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    tokenName: json['tokenName'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
  );
}

Map<String, dynamic> _$_$FiatProcessToJson(_$FiatProcess instance) =>
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
      'value': instance.value?.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
    };

_$FiatDeposit _$_$FiatDepositFromJson(Map<String, dynamic> json) {
  return _$FiatDeposit(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    tokenSymbol: json['tokenSymbol'] as String,
    tokenName: json['tokenName'] as String,
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
      'value': instance.value?.toString(),
      'tokenSymbol': instance.tokenSymbol,
      'tokenName': instance.tokenName,
      'tokenDecimal': instance.tokenDecimal,
    };

_$JoinCommunity _$_$JoinCommunityFromJson(Map<String, dynamic> json) {
  return _$JoinCommunity(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    communityAddress: json['communityAddress'] as String,
    tokenAddress: json['tokenAddress'] as String,
    communityName: json['communityName'] as String,
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
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
    tokenName: json['tokenName'] as String,
    tokenSymbol: json['tokenSymbol'] as String,
    tokenDecimal: json['tokenDecimal'] as int,
    bonusType: json['bonusType'] as String,
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
      'value': instance.value?.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'bonusType': instance.bonusType,
    };

_$Send _$_$SendFromJson(Map<String, dynamic> json) {
  return _$Send(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
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
      'value': instance.value?.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
    };

_$Receive _$_$ReceiveFromJson(Map<String, dynamic> json) {
  return _$Receive(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    tokenAddress: json['tokenAddress'] as String,
    from: json['from'] as String,
    to: json['to'] as String,
    value: json['value'] == null ? null : BigInt.parse(json['value'] as String),
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
      'value': instance.value?.toString(),
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
    };

_$Swap _$_$SwapFromJson(Map<String, dynamic> json) {
  return _$Swap(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
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

_$DepositYourFirstDollar _$_$DepositYourFirstDollarFromJson(
    Map<String, dynamic> json) {
  return _$DepositYourFirstDollar(
    timestamp: json['timestamp'] as int,
    id: json['_id'] as String,
    name: json['name'] as String,
    txHash: json['txHash'] as String,
    status: json['status'] as String,
    blockNumber: json['blockNumber'] as int,
    tokenAddress: json['tokenAddress'] as String,
  );
}

Map<String, dynamic> _$_$DepositYourFirstDollarToJson(
        _$DepositYourFirstDollar instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'tokenAddress': instance.tokenAddress,
    };
