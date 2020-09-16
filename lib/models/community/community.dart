import 'package:equatable/equatable.dart';
import 'package:esol/models/community/business.dart';
import 'package:esol/models/community/community_metadata.dart';
import 'package:esol/models/plugins/plugins.dart';
import 'package:esol/models/tokens/token.dart';
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
  final Token token;
  final Plugins plugins;
  final CommunityMetadata metadata;
  final bool isClosed;
  final String webUrl;
  final String foreignTokenAddress;
  final String description;

  @override
  List<Object> get props =>
      [name, address, isMember, token, plugins, metadata, webUrl, description];

  Community(
      {this.name,
      this.isClosed,
      this.isMember,
      this.address,
      this.plugins,
      this.token,
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
      token: Token.initial(),
      isMember: false,
      businesses: new List<Business>(),
      plugins: new Plugins(),
    );
  }

  Community copyWith(
      {String name,
      String address,
      String foreignBridgeAddress,
      String homeBridgeAddress,
      Plugins plugins,
      Token token,
      List<Business> businesses,
      bool isMember,
      CommunityMetadata metadata,
      bool isClosed,
      String webUrl,
      String foreignTokenAddress,
      String description}) {
    return Community(
        description: description ?? this.description,
        isClosed: isClosed ?? this.isClosed,
        webUrl: webUrl,
        metadata: metadata ?? this.metadata,
        address: address ?? this.address,
        name: name ?? this.name,
        plugins: plugins ?? this.plugins,
        token: token ?? this.token,
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
