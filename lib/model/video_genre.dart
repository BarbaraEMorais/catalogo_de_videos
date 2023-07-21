class VideoGenre {
  int? id;
  int videoid;
  int genreid;

  VideoGenre({this.id, required this.videoid, required this.genreid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"id": id, "videoid": videoid, "genreid": genreid};
  }

  factory VideoGenre.fromMap(Map<String, dynamic> map) {
    return VideoGenre(
      id: map["id"],
      genreid: map["genreid"],
      videoid: map["videoid"],
    );
  }
}
