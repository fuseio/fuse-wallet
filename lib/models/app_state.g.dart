// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    userState: json['userState'] == null
        ? null
        : UserState.fromJson(json['userState'] as Map<String, dynamic>),
    cashWalletState: json['cashWalletState'] == null
        ? null
        : CashWalletState.fromJson(
            json['cashWalletState'] as Map<String, dynamic>),
    proWalletState: AppState._proStateFromJson(
        json['proWalletState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'userState': instance.userState?.toJson(),
      'cashWalletState': instance.cashWalletState?.toJson(),
      'proWalletState': instance.proWalletState?.toJson(),
    };
