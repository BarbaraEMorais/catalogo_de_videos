class Video {
  int? id;
  String name;
  String description;
  int type;
  String ageRestriction;
  int durationMinutes;
  String thumbnailImageId;
  String releaseDate;

  Video(
      {this.id,
      required this.name,
      required this.description,
      required this.type,
      required this.ageRestriction,
      required this.durationMinutes,
      required this.releaseDate,
      required this.thumbnailImageId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "type": type,
      "ageRestriction": ageRestriction,
      "durationMinutes": durationMinutes,
      "releaseDate": releaseDate,
      "thumbnailImageId": thumbnailImageId
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      // se map["id"] existir, retorna o map["id"]
      id: map["id"],
      name: map["name"],
      description: map["description"],
      ageRestriction: map["ageRestriction"],
      durationMinutes: map["durationMinutes"],
      type: map["type"],
      releaseDate: map["releaseDate"],
      thumbnailImageId: map["thumbnailImageId"],
    );
  }
}
