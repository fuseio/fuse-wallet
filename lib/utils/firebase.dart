String communityAddressFromNotification(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String communityAddress = data['communityAddress'];
  return communityAddress;
}
