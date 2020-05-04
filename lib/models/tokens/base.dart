abstract class ERC20Token {
  final String address;
  final String name;
  final String symbol;
  final int decimals;
  final BigInt amount;

  ERC20Token(
      {this.address,
      this.name,
      this.symbol,
      this.decimals,
      this.amount,});

  Future<dynamic> fetchTokenBalance(String accountAddress, {void Function(BigInt) onDone, void Function(Object error, StackTrace stackTrace) onError});

  Map<String, dynamic> toJson() => {
        'address': this.address,
        'name': this.name,
        'symbol': this.symbol,
        'decimals': this.decimals,
        'amount': this.amount?.toString(),
      };

}
