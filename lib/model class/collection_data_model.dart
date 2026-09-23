
class CollectionGetData {
  String id;
  String name;
  final Data modelData;

  CollectionGetData({
    required this.id,
    required this.name,
    required this.modelData,
  });

  factory CollectionGetData.fromJson(Map<String, dynamic> json) {
    return (
        CollectionGetData(
      id: json["id"],
      name: json["name"],
      modelData: Data.fromJson(json["data"]),
    ));
  }
}

class Data {
  String year;
  String price;

  Data({required this.year, required this.price});

  factory Data.fromJson(Map<String, dynamic> json) {
    return (Data(
        year: json["year"],
        price: json["price"])
    );
  }
}
