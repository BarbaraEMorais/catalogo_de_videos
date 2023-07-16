class Genre {
  int? id;
  String name;

  Genre({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
    };
  }
}
