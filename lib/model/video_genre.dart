class VideoGenre {
  int? id;
  int video_id;
  int genre_id;

  VideoGenre({
    this.id,
    required this.video_id, 
    required this.genre_id});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "video_id": video_id,
      "genre_id": genre_id
    };
  }

  factory VideoGenre.fromMap(Map<String, dynamic> map) {
    return VideoGenre(
      // se map["id"] existir, retorna o map["id"]
      id: map["id"],
      video_id: map["video_id"],
      genre_id: map["genre_id"],
    );
  }

}



