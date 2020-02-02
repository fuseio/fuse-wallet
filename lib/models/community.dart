import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/community_metadata.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/models/transaction.dart';
import 'package:fusecash/models/transactions.dart';
import 'package:json_annotation/json_annotation.dart';

import './plugins.dart';
import './job.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community {
  final String name;
  final String address;
  final BigInt tokenBalance;
  final bool isMember;

  // @JsonKey(
  //     name: 'businesses',
  //     fromJson: _businessesFromJson,
  //     toJson: _businessesToJson)
  final List<Business> businesses;

  // @JsonKey(
  //     name: 'transactions',
  //     fromJson: _transactionsFromJson,
  //     toJson: _transactionsToJson)
  final Transactions transactions;

  @JsonKey(name: 'token', fromJson: _tokenFromJson, toJson: _tokenToJson)
  final Token token;

  @JsonKey(name: 'jobs', fromJson: _jobsFromJson, toJson: _jobsToJson)
  final List<Job> jobs;

  @JsonKey(name: 'plugins', fromJson: _pluginsFromJson, toJson: _pluginsToJson)
  final Plugins plugins;

  @JsonKey(
      name: 'metadata',
      fromJson: _communityMetadataFromJson,
      toJson: _communityMetadataToJson)
  final CommunityMetadata metadata;
  Community(
      {this.name,
      this.isMember,
      this.address,
      this.plugins,
      this.transactions,
      this.token,
      this.tokenBalance,
      this.businesses,
      this.jobs,
      this.metadata});

  // static List<Business> _businessesFromJson(Map<String, dynamic> json) =>
  //     List<Business>.from(
  //         json['businesses'].map((business) => Business.fromJson(business)));

  // static Map<String, dynamic> _businessesToJson(List<Business> businesses) =>
  //     new Map.from({
  //       "businesses": businesses.map((business) => business.toJson()).toList()
  //     });

  // static Transactions _transactionsFromJson(Map<String, dynamic> json) =>
  //     Transactions.fromJson(json);

  // static Map<String, dynamic> _transactionsToJson(Transactions transactions) =>
  //     transactions.toJson();

  static Token _tokenFromJson(Map<String, dynamic> json) =>
      Token.fromJson(json);

  static Map<String, dynamic> _tokenToJson(Token token) => token.toJson();

  static List<Job> _jobsFromJson(Map<String, dynamic> json) =>
      List<Job>.from(json['jobs'].map((job) => JobFactory.create(job)));

  static Map<String, dynamic> _jobsToJson(List<dynamic> jobs) =>
      new Map.from({"jobs": jobs.map((job) => job.toJson()).toList()});

  static Plugins _pluginsFromJson(Map<String, dynamic> json) =>
      json == null ? {} : Plugins.fromJson(json);

  static Map<String, dynamic> _pluginsToJson(Plugins plugins) =>
      plugins.toJson();

  static CommunityMetadata _communityMetadataFromJson(
          Map<String, dynamic> json) =>
      json == null
          ? CommunityMetadata.initial()
          : CommunityMetadata.fromJson(json);

  static Map<String, dynamic> _communityMetadataToJson(
          CommunityMetadata metadata) =>
      metadata.toJson();

  factory Community.initial() {
    return new Community(
        name: null,
        metadata: CommunityMetadata.initial(),
        address: null,
        token: null,
        isMember: false,
        tokenBalance: BigInt.from(0),
        businesses: new List<Business>(),
        transactions: new Transactions(list: new List<Transaction>()),
        plugins: new Plugins(),
        jobs: new List<Job>());
  }

  Community copyWith({
    String name,
    String address,
    Plugins plugins,
    Token token,
    Transactions transactions,
    BigInt tokenBalance,
    List<Business> businesses,
    List<Job> jobs,
    bool isMember,
    CommunityMetadata metadata,
  }) {
    return Community(
        metadata: metadata ?? this.metadata,
        tokenBalance: tokenBalance ?? this.tokenBalance,
        address: address ?? this.address,
        name: name ?? this.name,
        plugins: plugins ?? this.plugins,
        token: token ?? this.token,
        businesses: businesses ?? this.businesses,
        isMember: isMember ?? this.isMember,
        jobs: jobs ?? this.jobs,
        transactions: transactions ?? this.transactions);
  }

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}
