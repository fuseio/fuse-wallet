import 'package:fusecash/models/business.dart';
import 'package:fusecash/models/token.dart';
import 'package:fusecash/models/transaction.dart';

import './plugins.dart';
import './job.dart';

class Community {
  final String name;
  final String address;
  final Plugins plugins;
  final BigInt tokenBalance;
  final bool isMember;
  final Token token;
  final Transactions transactions;
  final List<Business> businesses;
  final List<Job> jobs;

  Community(
      {this.name,
      this.isMember,
      this.address,
      this.plugins,
      this.transactions,
      this.token,
      this.tokenBalance,
      this.businesses,
      this.jobs});

  factory Community.initial() {
    return new Community(
        name: null,
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
    bool isMember
  }) {
    return Community(
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

  static Community fromJson(dynamic json) => json != null
      ? new Community(
          name: json["name"],
          address: json["address"],
          plugins: Plugins.fromJson(json["plugins"] ?? {}),
          tokenBalance: json['tokenBalance'] == null ? null : BigInt.parse(json['tokenBalance']),
          isMember: json['isMember'],
          transactions: Transactions.fromJson(json['transactions']),
          token: json['token'] == null
              ? json['token']
              : Token.fromJson(json['token']),
          // jobs: new List<Job>()
          jobs: List<Job>.from(json['jobs'].map((job) => JobFactory.create(job))),
        )
      : null;

  dynamic toJson() => {
        'name': name,
        'address': address,
        'isMember': isMember,
        'tokenBalance': tokenBalance.toString(),
        'plugins': plugins?.toJson(),
        'transactions': transactions.toJson(),
        'token': token?.toJson(),
        'jobs': jobs.map((job) => job.toJson()).toList(),
      };
}
