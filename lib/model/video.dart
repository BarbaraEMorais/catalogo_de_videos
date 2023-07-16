import 'package:catalogo_de_videos/model/video_genre.dart';

class Video {
  int id;
  String name;
  String description;
  int type;
  int ageRestriction;
  int durationMinutes;
  int thumbnailImageId;
  DateTime releaseDate;
  VideoGenre genre;

  Video(
      this.id,
      this.name,
      this.description,
      this.type,
      this.ageRestriction,
      this.durationMinutes,
      this.genre,
      this.releaseDate,
      this.thumbnailImageId);
}
