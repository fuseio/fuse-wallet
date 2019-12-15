
class Job {
  final String id;
  final String name;
  final String txHash;

  Job({
    this.id,
    this.name,
    this.txHash,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['_id'],
    name: json['name'],
    txHash: json['data']['txHash'] == null ? null : json['data']['txHash']
  );
}


