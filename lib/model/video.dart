class Video {
  int? id;
  String name;
  String description;
  int type;
  String ageRestriction;
  int durationMinutes;
  String thumbnailImageId;
  String releaseDate;
  int creatorid;

  Video(
      {this.id,
      required this.name,
      required this.description,
      required this.type,
      required this.ageRestriction,
      required this.durationMinutes,
      required this.releaseDate,
      required this.thumbnailImageId,
      required this.creatorid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "type": type,
      "ageRestriction": ageRestriction,
      "durationMinutes": durationMinutes,
      "releaseDate": releaseDate,
      "thumbnailImageId": thumbnailImageId,
      "creatorid": creatorid
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      ageRestriction: map["ageRestriction"],
      durationMinutes: map["durationMinutes"],
      type: map["type"],
      releaseDate: map["releaseDate"],
      thumbnailImageId: map["thumbnailImageId"],
      creatorid: map["creatorid"],
    );
  }
}
