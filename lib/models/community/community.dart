import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community_metadata.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

@immutable
@freezed
class Community with _$Community {
  @JsonSerializable()
  factory Community({
    @Default('') String name,
    @Default('') String address,
    @Default(false) bool isMultiBridge,
    @Default(false) bool isClosed,
    @Default(false) bool isMember,
    @JsonKey(includeIfNull: false) @Default('') String homeTokenAddress,
    @JsonKey(includeIfNull: false) CommunityMetadata? metadata,
    @JsonKey(includeIfNull: false) String? webUrl,
    @JsonKey(includeIfNull: false) String? bridgeType,
    @JsonKey(includeIfNull: false) String? bridgeDirection,
    @JsonKey(includeIfNull: false) String? homeBridgeAddress,
    @JsonKey(includeIfNull: false) String? foreignBridgeAddress,
    @JsonKey(includeIfNull: false) String? foreignTokenAddress,
    @JsonKey(includeIfNull: false) @PluginsConverter() Plugins? plugins,
    @JsonKey(includeIfNull: false) List<Business>? businesses,
    @JsonKey(includeIfNull: false) String? description,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
