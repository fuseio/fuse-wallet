
class Job {
  static const String RELAY = "relay";
  static const String CREATE_WALLET = "createWallet";

  static const String COMMUNITY_MANAGER = "CommunityManager";
  static const String TRANSFER_MANAGER = "TransferManager";

  final String id;
  final String name;
  final dynamic data;
  final String lastFinishedAt;

  Job({
    this.id,
    this.name,
    this.data,
    this.lastFinishedAt
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json['_id'],
    name: json['name'],
    data: json['data'],
    lastFinishedAt: json['lastFinishedAt'],
  );
}


