// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NftsState _$$_NftsStateFromJson(Map<String, dynamic> json) => _$_NftsState(
      collectibles: (json['collectibles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as Map<String, dynamic>).map(
                  (k, e) => MapEntry(int.parse(k),
                      Collectible.fromJson(e as Map<String, dynamic>)),
                )),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_NftsStateToJson(_$_NftsState instance) =>
    <String, dynamic>{
      'collectibles': instance.collectibles.map((k, e) =>
          MapEntry(k, e.map((k, e) => MapEntry(k.toString(), e.toJson())))),
    };
