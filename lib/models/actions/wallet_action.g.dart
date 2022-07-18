// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateWallet _$$CreateWalletFromJson(Map<String, dynamic> json) =>
    _$CreateWallet(
      timestamp: json['timestamp'] as int? ?? 0,
      id: json['_id'] as String,
      name: json['name'] as String? ?? 'createWallet',
      txHash: json['txHash'] as String?,
      status: json['status'] as String,
      blockNumber: json['blockNumber'] as int? ?? 0,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CreateWalletToJson(_$CreateWallet instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'runtimeType': instance.$type,
    };

_$FiatDeposit _$$FiatDepositFromJson(Map<String, dynamic> json) =>
    _$FiatDeposit(
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FiatDepositToJson(_$FiatDeposit instance) =>
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
      'runtimeType': instance.$type,
    };

_$Bonus _$$BonusFromJson(Map<String, dynamic> json) => _$Bonus(
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$BonusToJson(_$Bonus instance) => <String, dynamic>{
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
      'runtimeType': instance.$type,
    };

_$Send _$$SendFromJson(Map<String, dynamic> json) => _$Send(
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SendToJson(_$Send instance) => <String, dynamic>{
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
      'runtimeType': instance.$type,
    };

_$Receive _$$ReceiveFromJson(Map<String, dynamic> json) => _$Receive(
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
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ReceiveToJson(_$Receive instance) => <String, dynamic>{
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
      'runtimeType': instance.$type,
    };

_$Swap _$$SwapFromJson(Map<String, dynamic> json) => _$Swap(
      timestamp: json['timestamp'] as int? ?? 0,
      id: json['_id'] as String,
      name: json['name'] as String? ?? 'swapTokens',
      txHash: json['txHash'] as String?,
      status: json['status'] as String,
      blockNumber: json['blockNumber'] as int? ?? 0,
      tradeInfo: json['metadata'] == null
          ? null
          : Trade.fromJson(json['metadata'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SwapToJson(_$Swap instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      '_id': instance.id,
      'name': instance.name,
      'txHash': instance.txHash,
      'status': instance.status,
      'blockNumber': instance.blockNumber,
      'metadata': instance.tradeInfo?.toJson(),
      'runtimeType': instance.$type,
    };

_$ReceiveNFT _$$ReceiveNFTFromJson(Map<String, dynamic> json) => _$ReceiveNFT(
      timestamp: json['timestamp'] as int? ?? 0,
      id: json['_id'] as String,
      name: json['name'] as String? ?? 'receiveNFT',
      txHash: json['txHash'] as String?,
      status: json['status'] as String,
      blockNumber: json['blockNumber'] as int? ?? 0,
      tokenAddress: json['tokenAddress'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      tokenName: json['tokenName'] as String,
      tokenSymbol: json['tokenSymbol'] as String,
      tokenDecimal: json['tokenDecimal'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ReceiveNFTToJson(_$ReceiveNFT instance) =>
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
      'tokenName': instance.tokenName,
      'tokenSymbol': instance.tokenSymbol,
      'tokenDecimal': instance.tokenDecimal,
      'runtimeType': instance.$type,
    };
