class Video {
  int id;
  String name;
  String description;
  int type;
  int ageRestriction;
  int durationMinutes;
  int thumbnailImageId;
  DateTime releaseDate;

  Video(this.id, this.name, this.description, this.type, this.ageRestriction,
      this.durationMinutes, this.releaseDate, this.thumbnailImageId);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "description": description,
      "type": type,
      "ageRestricion": ageRestriction,
      "durationMinutes": durationMinutes,
      "releaseDate": releaseDate,
      "thumbnailImageId": thumbnailImageId
    };
  }
}
