// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppState _$_$_AppStateFromJson(Map<String, dynamic> json) {
  return _$_AppState(
    userState: const UserStateConverter()
        .fromJson(json['userState'] as Map<String, dynamic>),
    cashWalletState: const CashWalletStateConverter()
        .fromJson(json['cashWalletState'] as Map<String, dynamic>),
    proWalletState: const ProWalletStateConverter()
        .fromJson(json['proWalletState'] as Map<String, dynamic>),
    swapState: json['swapState'] == null
        ? null
        : SwapState.fromJson(json['swapState']),
  );
}

Map<String, dynamic> _$_$_AppStateToJson(_$_AppState instance) =>
    <String, dynamic>{
      'userState': const UserStateConverter().toJson(instance.userState),
      'cashWalletState':
          const CashWalletStateConverter().toJson(instance.cashWalletState),
      'proWalletState':
          const ProWalletStateConverter().toJson(instance.proWalletState),
      'swapState': instance.swapState?.toJson(),
    };
