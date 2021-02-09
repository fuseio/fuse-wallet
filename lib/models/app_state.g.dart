// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppState _$_$_AppStateFromJson(Map<String, dynamic> json) {
  return _$_AppState(
    userState: json['userState'] == null
        ? null
        : UserState.fromJson(json['userState']),
    cashWalletState: json['cashWalletState'] == null
        ? null
        : CashWalletState.fromJson(json['cashWalletState']),
    proWalletState: json['proWalletState'] == null
        ? null
        : ProWalletState.fromJson(json['proWalletState']),
  );
}

Map<String, dynamic> _$_$_AppStateToJson(_$_AppState instance) =>
    <String, dynamic>{
      'userState': instance.userState?.toJson(),
      'cashWalletState': instance.cashWalletState?.toJson(),
      'proWalletState': instance.proWalletState?.toJson(),
    };
