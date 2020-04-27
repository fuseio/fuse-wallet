import 'package:bit2c/models/jobs/base.dart';
import 'package:bit2c/models/transactions/transactions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(explicitToJson: true)
class Token {
  final String address;
  final String name;
  final String symbol;
  final String imageUrl;
  final int decimals;
  final int timestamp;
  final BigInt amount;
  @JsonKey(fromJson: _transactionsFromJson)
  final Transactions transactions;
  @JsonKey(name: 'jobs', fromJson: _jobsFromJson, toJson: _jobsToJson)
  final List<Job> jobs;

  static Transactions _transactionsFromJson(Map<String, dynamic> json) =>
      json == null ? Transactions.initial() : Transactions.fromJson(json);

  static List<Job> _jobsFromJson(Map<String, dynamic> json) =>
      json == null ? List<Job>() : List<Job>.from(json['jobs'].map((job) => JobFactory.create(job)));

  static Map<String, dynamic> _jobsToJson(List<dynamic> jobs) =>
      new Map.from({"jobs": jobs.map((job) => job.toJson()).toList()});

  Token(
      {this.address,
      this.name,
      this.symbol,
      this.decimals,
      this.amount,
      this.imageUrl,
      this.timestamp,
      this.transactions,
      this.jobs});

  Token copyWith(
      {String address,
      String name,
      String symbol,
      String imageUrl,
      int decimals,
      BigInt amount,
      int timestamp,
      Transactions transactions,
      List<Job> jobs}) {
    return Token(
      address: address ?? this.address,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      imageUrl: imageUrl ?? this.imageUrl,
      decimals: decimals ?? this.decimals,
      amount: amount ?? this.amount,
      timestamp: timestamp ?? this.timestamp,
      transactions: transactions ?? this.transactions,
      jobs: jobs ?? this.jobs
    );
  }

  factory Token.initial() {
    return new Token(
        address: '',
        imageUrl: null,
        name: '',
        amount: BigInt.from(0),
        decimals: 0,
        symbol: '',
        timestamp: 0,
        transactions: Transactions.initial(),
        jobs: new List<Job>());
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
