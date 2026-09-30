
class CollectionGetData {
  String id;
  String taskName;
  final Data modelData;

  CollectionGetData({
    required this.id,
    required this.taskName,
    required this.modelData,
  });

  factory CollectionGetData.fromJson(Map<String, dynamic> json) {
    return (CollectionGetData(
      id: json["id"],
      taskName: json["name"],
      modelData: Data.fromJson(json["data"]),
    ));
  }
}

class Data {
  String date;
  String optionalNotes;

  Data({required this.date, required this.optionalNotes});

  factory Data.fromJson(Map<String, dynamic> json) {
    return (Data(
        date: json["year"],
        optionalNotes: json["price"])
    );
  }
}
