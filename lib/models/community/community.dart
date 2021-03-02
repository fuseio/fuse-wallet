import 'package:equatable/equatable.dart';
import 'package:peepl/models/community/business.dart';
import 'package:peepl/models/community/community_metadata.dart';
import 'package:peepl/models/plugins/plugins.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community extends Equatable {
  final String name;
  final String address;
  @JsonKey(nullable: true)
  final String homeBridgeAddress;
  @JsonKey(nullable: true)
  final String foreignBridgeAddress;
  @JsonKey(nullable: true, defaultValue: false)
  final bool isMember;
  @JsonKey(nullable: true, defaultValue: const [])
  final List<Business> businesses;
  @JsonKey(nullable: true)
  final String homeTokenAddress;
  @JsonKey(nullable: true)
  final Plugins plugins;
  @JsonKey(nullable: true)
  final CommunityMetadata metadata;
  @JsonKey(defaultValue: true, nullable: true)
  final bool isClosed;
  @JsonKey(nullable: true)
  final String webUrl;
  @JsonKey(nullable: true)
  final String foreignTokenAddress;
  @JsonKey(nullable: true)
  final String description;
  @JsonKey(nullable: true)
  final String bridgeType;
  @JsonKey(nullable: true)
  final String bridgeDirection;
  @JsonKey(defaultValue: false, nullable: true)
  final bool isMultiBridge;
  @JsonKey(nullable: true)
  final String secondaryTokenAddress;
  @override
  List<Object> get props => [
        name,
        address,
        plugins,
        metadata,
        webUrl,
        homeTokenAddress,
        secondaryTokenAddress
      ];

  Community({
    this.name,
    this.bridgeType,
    this.bridgeDirection,
    this.isMultiBridge,
    this.isClosed,
    this.isMember,
    this.address,
    this.plugins,
    this.homeTokenAddress,
    this.businesses,
    this.metadata,
    this.homeBridgeAddress,
    this.webUrl,
    this.foreignBridgeAddress,
    this.foreignTokenAddress,
    this.description,
    this.secondaryTokenAddress,
  });

  factory Community.initial() {
    return new Community(
        name: null,
        isClosed: false,
        metadata: CommunityMetadata.initial(),
        address: null,
        foreignBridgeAddress: null,
        homeBridgeAddress: null,
        isMember: false,
        businesses: new List<Business>(),
        plugins: new Plugins(),
        isMultiBridge: false);
  }

  Community copyWith(
      {String name,
      String bridgeType,
      String bridgeDirection,
      String address,
      String foreignBridgeAddress,
      String homeBridgeAddress,
      Plugins plugins,
      List<Business> businesses,
      bool isMember,
      CommunityMetadata metadata,
      bool isClosed,
      String secondaryTokenAddress,
      String webUrl,
      String foreignTokenAddress,
      String homeTokenAddress,
      String description,
      bool isMultiBridge}) {
    return Community(
        bridgeType: bridgeType ?? this.bridgeType,
        bridgeDirection: bridgeDirection ?? this.bridgeDirection,
        isMultiBridge: isMultiBridge ?? this.isMultiBridge,
        description: description ?? this.description,
        isClosed: isClosed ?? this.isClosed,
        webUrl: webUrl ?? this.webUrl,
        metadata: metadata ?? this.metadata,
        address: address ?? this.address,
        name: name ?? this.name,
        plugins: plugins ?? this.plugins,
        homeTokenAddress: homeTokenAddress ?? this.homeTokenAddress,
        businesses: businesses ?? this.businesses,
        isMember: isMember ?? this.isMember,
        secondaryTokenAddress:
            secondaryTokenAddress ?? this.secondaryTokenAddress,
        homeBridgeAddress: homeBridgeAddress ?? this.homeBridgeAddress,
        foreignBridgeAddress: foreignBridgeAddress ?? this.foreignBridgeAddress,
        foreignTokenAddress: foreignTokenAddress ?? this.foreignTokenAddress);
  }

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}
