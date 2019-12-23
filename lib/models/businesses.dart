class Business {
  final String account;
  final String address;
  final String description;
  final String id;
  final String image;
  final String coverPhoto;
  final String name;

  Business(
      {this.account,
      this.address,
      this.description,
      this.id,
      this.image,
      this.name,
      this.coverPhoto});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
        account: json['account'],
        address: json['metadata'] != null ? json['metadata']['address'] : "",
        description:
            json['metadata'] != null ? json['metadata']['description'] : "",
        id: json['_id'],
        image: json["metadata"]['image'] != null
            ? "" +
                ("https://ipfs-proxy-qa.fuse.io/api/image/" +
                    json["metadata"]['image'])
            : 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png',
        coverPhoto: json["metadata"]['coverPhoto'] != null
            ? "" +
                ("https://ipfs-proxy-qa.fuse.io/api/image/" +
                    json["metadata"]['coverPhoto'])
            : 'https://cdn3.iconfinder.com/data/icons/abstract-1/512/no_image-512.png',
        name: json['name'] ?? "");
  }
}

class BusinessList {
  final List<Business> businesses;

  BusinessList({this.businesses});

  factory BusinessList.fromJson(Map<String, dynamic> json) {
    var list = json as List;

    List<Business> businesses = new List<Business>();
    businesses = list.map((i) => Business.fromJson(i["data"])).toList();

    return new BusinessList(businesses: businesses);
  }
}
