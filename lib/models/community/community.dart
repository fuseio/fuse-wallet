import 'package:equatable/equatable.dart';
import 'package:seedbed/models/community/business.dart';
import 'package:seedbed/models/community/community_metadata.dart';
import 'package:seedbed/models/plugins/plugins.dart';
import 'package:seedbed/models/tokens/token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community extends Equatable {
  final String name;
  final String address;
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  final String secondaryTokenAddress;
  final bool isMember;
  final List<Business> businesses;
  final Token token;
  final Token secondaryToken;
  final Plugins plugins;
  final CommunityMetadata metadata;
  final bool isClosed;
  final String webUrl;

  @override
  List<Object> get props => [
        name,
        address,
        isMember,
        token,
        plugins,
        secondaryToken,
        metadata,
        webUrl
      ];

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
      this.secondaryToken,
      this.secondaryTokenAddress,
      this.webUrl,
      this.foreignBridgeAddress});

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

  Community copyWith({
    String name,
    String address,
    String foreignBridgeAddress,
    String homeBridgeAddress,
    String secondaryTokenAddress,
    Plugins plugins,
    Token token,
    Token secondaryToken,
    List<Business> businesses,
    bool isMember,
    CommunityMetadata metadata,
    bool isClosed,
    String webUrl
  }) {
    return Community(
      isClosed: isClosed ?? this.isClosed,
      webUrl: webUrl,
      metadata: metadata ?? this.metadata,
      address: address ?? this.address,
      name: name ?? this.name,
      plugins: plugins ?? this.plugins,
      token: token ?? this.token,
      secondaryToken: secondaryToken ?? this.secondaryToken,
      businesses: businesses ?? this.businesses,
      isMember: isMember ?? this.isMember,
      homeBridgeAddress: homeBridgeAddress ?? this.homeBridgeAddress,
      foreignBridgeAddress: foreignBridgeAddress ?? this.foreignBridgeAddress,
      secondaryTokenAddress: secondaryTokenAddress ?? this.secondaryTokenAddress,
    );
  }

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}
