import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supervecina/models/community/business_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.freezed.dart';
part 'business.g.dart';

@immutable
@freezed
class Business with _$Business {
  @JsonSerializable()
  factory Business({
    required BusinessMetadata metadata,
    @Default('') String account,
    @Default('') String id,
    @Default(0) int area,
    @Default('') String name,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
}
