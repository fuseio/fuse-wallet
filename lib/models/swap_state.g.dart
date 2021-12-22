// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SwapState _$$_SwapStateFromJson(Map<String, dynamic> json) => _$_SwapState(
      tokens: json['tokens'] == null
          ? const {}
          : tokensFromJson(json['tokens'] as Map<String, dynamic>),
      tokensImages: (json['tokensImages'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_SwapStateToJson(_$_SwapState instance) =>
    <String, dynamic>{
      'tokens': instance.tokens.map((k, e) => MapEntry(k, e.toJson())),
      'tokensImages': instance.tokensImages,
    };
