import 'package:paywise/models/jobs/base.dart';
import 'package:paywise/models/tokens/base.dart';
import 'package:paywise/models/transactions/transactions.dart';
import 'package:paywise/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(explicitToJson: true)
class Token extends ERC20Token {
  final String imageUrl;
  final int timestamp;
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
      {String address,
      String name,
      String symbol,
      int decimals,
      BigInt amount,
      this.imageUrl,
      this.timestamp,
      this.transactions,
      this.jobs}) :
          super(
            address: address,
            name: name,
            symbol: symbol,
            decimals: decimals,
            amount: amount);

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

  @override
  Future<dynamic> fetchTokenBalance(String accountAddress, {void Function(BigInt) onDone, Function onError}) async {
    try {
      final BigInt balance = await tokenAPI.getTokenBalanceByAccountAddress(this.address, accountAddress);
      if (this.amount.compareTo(balance) != 0) {
        onDone(balance);
      }
    } catch (e, s) {
      print(e);
      onError(e, s);
    }
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

  @override
  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
