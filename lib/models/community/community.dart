import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fusecash/models/community/business.dart';
import 'package:fusecash/models/community/community_metadata.dart';
import 'package:fusecash/models/plugins/plugins.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

@immutable
@freezed
abstract class Community with _$Community {
  @JsonSerializable()
  factory Community({
    String name,
    String address,
    Plugins plugins,
    List<Business> businesses,
    @Default(false) bool isMultiBridge,
    @Default(false) bool isClosed,
    @Default(false) bool isMember,
    @nullable String bridgeType,
    @nullable String bridgeDirection,
    @nullable String homeTokenAddress,
    @nullable CommunityMetadata metadata,
    @nullable String homeBridgeAddress,
    @nullable String webUrl,
    @nullable String foreignBridgeAddress,
    @nullable String foreignTokenAddress,
    @nullable String description,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}
