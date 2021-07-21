class ConnectResponse {
  String id;
  Meta meta;

  ConnectResponse({required this.id, required this.meta});

  factory ConnectResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ConnectResponse(
      id: parsedJson['id'].toString(),
      meta: parsedJson['meta'],
    );
  }
}

class Meta {
  String description;
  List<dynamic> icons;
  String name;
  String url;
  Meta(
      {required this.description,
      required this.icons,
      required this.name,
      required this.url});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(
        description: parsedJson['description'].toString(),
        icons: parsedJson['icons'],
        name: parsedJson['name'],
        url: parsedJson['url']);
  }
}
