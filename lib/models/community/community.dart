import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community_metadata.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

Plugins? pluginsFromJson(json) =>
    json == null ? null : PluginsConverter().fromJson(json);

@immutable
@freezed
class Community with _$Community {
  @JsonSerializable()
  factory Community({
    @Default(null) String name,
    @Default(null) String address,
    @Default(false) bool isMultiBridge,
    @Default(false) bool isClosed,
    @Default(false) bool isMember,
    @JsonKey(includeIfNull: false) String? homeTokenAddress,
    @JsonKey(includeIfNull: false) CommunityMetadata? metadata,
    @JsonKey(includeIfNull: false) String? webUrl,
    @JsonKey(includeIfNull: false) String? bridgeType,
    @JsonKey(includeIfNull: false) String? bridgeDirection,
    @JsonKey(includeIfNull: false) String? homeBridgeAddress,
    @JsonKey(includeIfNull: false) String? foreignBridgeAddress,
    @JsonKey(includeIfNull: false) String? foreignTokenAddress,
    @JsonKey(includeIfNull: false, fromJson: pluginsFromJson) Plugins? plugins,
    @JsonKey(includeIfNull: false) @Default([]) List<Business>? businesses,
    @JsonKey(includeIfNull: false) String? description,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
