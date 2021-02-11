import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community_metadata.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

Plugins pluginsFromJson(json) =>
    json == null ? null : PluginsConverter().fromJson(json);

@immutable
@freezed
abstract class Community with _$Community {
  @JsonSerializable()
  factory Community({
    String name,
    String address,
    @Default(false) bool isMultiBridge,
    @Default(false) bool isClosed,
    @Default(false) bool isMember,
    @nullable String homeTokenAddress,
    @nullable CommunityMetadata metadata,
    @nullable String webUrl,
    @JsonKey(includeIfNull: false) @nullable String bridgeType,
    @JsonKey(includeIfNull: false) @nullable String bridgeDirection,
    @JsonKey(includeIfNull: false) @nullable String homeBridgeAddress,
    @JsonKey(includeIfNull: false) @nullable String foreignBridgeAddress,
    @JsonKey(includeIfNull: false) @nullable String foreignTokenAddress,
    @nullable @JsonKey(includeIfNull: false, fromJson: pluginsFromJson) Plugins plugins,
    @nullable @JsonKey(includeIfNull: false) @Default([]) List<Business> businesses,
    @nullable String description,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
