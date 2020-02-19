import 'package:paywise/models/business.dart';
import 'package:paywise/models/community_metadata.dart';
import 'package:paywise/models/jobs/base.dart';
import 'package:paywise/models/token.dart';
import 'package:paywise/models/transaction.dart';
import 'package:paywise/models/transactions.dart';
import 'package:json_annotation/json_annotation.dart';

import './plugins.dart';

part 'community.g.dart';

@JsonSerializable(explicitToJson: true)
class Community {
  final String name;
  final String address;
  final BigInt tokenBalance;
  final bool isMember;
  final List<Business> businesses;
  final Transactions transactions;
  final Token token;
  final Plugins plugins;
  final CommunityMetadata metadata;
  final bool isClosed;

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
      this.tokenBalance,
      this.businesses,
      this.jobs,
      this.metadata});

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
    bool isClosed
  }) {
    return Community(
        isClosed: isClosed ?? isClosed,
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
