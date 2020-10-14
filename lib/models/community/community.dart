import 'package:equatable/equatable.dart';
import 'package:fc_knudde/models/community/business.dart';
import 'package:fc_knudde/models/community/community_metadata.dart';
import 'package:fc_knudde/models/plugins/plugins.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community extends Equatable {
  final String name;
  final String address;
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  final bool isMember;
  final List<Business> businesses;
  final String homeTokenAddress;
  final Plugins plugins;
  final CommunityMetadata metadata;
  final bool isClosed;
  final String webUrl;
  final String foreignTokenAddress;
  final String description;
  final bool isMultiBridge;

  @override
  List<Object> get props => [
        name,
        address,
        plugins,
        metadata,
        webUrl,
        homeTokenAddress,
      ];

  Community(
      {this.name,
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
      this.description});

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
      String address,
      String foreignBridgeAddress,
      String homeBridgeAddress,
      Plugins plugins,
      List<Business> businesses,
      bool isMember,
      CommunityMetadata metadata,
      bool isClosed,
      String webUrl,
      String foreignTokenAddress,
      String homeTokenAddress,
      String description,
      bool isMultiBridge}) {
    return Community(
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
        homeBridgeAddress: homeBridgeAddress ?? this.homeBridgeAddress,
        foreignBridgeAddress: foreignBridgeAddress ?? this.foreignBridgeAddress,
        foreignTokenAddress: foreignTokenAddress ?? this.foreignTokenAddress);
  }

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}
