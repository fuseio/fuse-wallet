import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/community/business_metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'business.freezed.dart';
part 'business.g.dart';

@immutable
@freezed
abstract class Business with _$Business {
  @JsonSerializable()
  factory Business({
    BusinessMetadata metadata,
    @Default('') String account,
    @Default('') String id,
    @Default('') String name,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);
}
