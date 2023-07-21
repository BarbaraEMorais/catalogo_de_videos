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

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map["id"],
      name: map["name"],
    );
  }
}
