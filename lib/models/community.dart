import 'package:peepl/models/business.dart';
import 'package:peepl/models/community_metadata.dart';
import 'package:peepl/models/jobs/base.dart';
import 'package:peepl/models/plugins/plugins.dart';
import 'package:peepl/models/token.dart';
import 'package:peepl/models/transactions/transactions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community {
  final String name;
  final String address;
  final String homeBridgeAddress;
  final String foreignBridgeAddress;
  final String secondaryTokenAddress;
  final BigInt tokenBalance;
  final BigInt secondaryTokenBalance;
  final bool isMember;
  final List<Business> businesses;
  final Transactions transactions;
  final Token token;
  final Token secondaryToken;
  final Plugins plugins;
  final CommunityMetadata metadata;
  final bool isClosed;
  final String webUrl;

  @JsonKey(name: 'jobs', fromJson: _jobsFromJson, toJson: _jobsToJson)
  final List<Job> jobs;

  Community(
      {this.name,
      this.isClosed,
      this.isMember,
      this.address,
      this.plugins,
      this.transactions,
      this.token,
      this.secondaryToken,
      this.tokenBalance,
      this.businesses,
      this.jobs,
      this.metadata,
      this.homeBridgeAddress,
      this.webUrl,
      this.foreignBridgeAddress,
      this.secondaryTokenAddress,
      this.secondaryTokenBalance});

  static List<Job> _jobsFromJson(Map<String, dynamic> json) =>
      List<Job>.from(json['jobs'].map((job) => JobFactory.create(job)));

  static Map<String, dynamic> _jobsToJson(List<dynamic> jobs) =>
      new Map.from({"jobs": jobs.map((job) => job.toJson()).toList()});

  factory Community.initial() {
    return new Community(
        name: null,
        isClosed: false,
        metadata: CommunityMetadata.initial(),
        address: null,
        foreignBridgeAddress: null,
        homeBridgeAddress: null,
        secondaryTokenAddress: null,
        secondaryTokenBalance: BigInt.from(0),
        token: null,
        secondaryToken: null,
        isMember: false,
        tokenBalance: BigInt.from(0),
        businesses: new List<Business>(),
        transactions: Transactions.initial(),
        plugins: new Plugins(),
        jobs: new List<Job>());
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
    Transactions transactions,
    BigInt tokenBalance,
    BigInt secondaryTokenBalance,
    List<Business> businesses,
    List<Job> jobs,
    bool isMember,
    CommunityMetadata metadata,
    bool isClosed,
    String webUrl,
  }) {
    return Community(
      isClosed: isClosed ?? this.isClosed,
      webUrl: webUrl ?? this.webUrl,
      metadata: metadata ?? this.metadata,
      tokenBalance: tokenBalance ?? this.tokenBalance,
      address: address ?? this.address,
      name: name ?? this.name,
      plugins: plugins ?? this.plugins,
      secondaryTokenAddress: secondaryTokenAddress ?? this.secondaryTokenAddress,
      token: token ?? this.token,
      secondaryToken: secondaryToken ?? this.secondaryToken,
      secondaryTokenBalance: secondaryTokenBalance ?? this.secondaryTokenBalance,
      businesses: businesses ?? this.businesses,
      isMember: isMember ?? this.isMember,
      jobs: jobs ?? this.jobs,
      transactions: transactions ?? this.transactions,
      homeBridgeAddress: homeBridgeAddress ?? this.homeBridgeAddress,
      foreignBridgeAddress: foreignBridgeAddress ?? this.foreignBridgeAddress,
    );
  }

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}
