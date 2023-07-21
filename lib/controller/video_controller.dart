import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/model/video_genre.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class VideoController {
  DatabaseHelper con = DatabaseHelper();

  Future<int> saveVideo(Video video) async {
    var db = await con.db;

    int result = await db.insert("video", video.toMap());

    return result;
  }

  Future<int> deleteVideo(Video video) async {
    var db = await con.db;

    int result = await db.delete("video", where: "id=?", whereArgs: [video.id]);

    return result;
  }

  Future<List<Video>> getMovies() async {
    var db = await con.db;

    String sql = """
    SELECT * FROM video WHERE type = 0;
    """;

    var result = await db.rawQuery(sql);
    print(result);
    List<Video> movies = <Video>[];

    for (var movie in result) {
      movies.add(Video.fromMap(movie));
    }
    return movies;
  }

  Future<List<Video>> getSeries() async {
    var db = await con.db;

    String sql = """
    SELECT * FROM video WHERE type = 1;
    """;

    var result = await db.rawQuery(sql);

    List<Video> series = <Video>[];

    for (var serie in result) {
      series.add(Video.fromMap(serie));
    }
    return series;
  }

  Future<Video> getVideoById(int id) async {
    var db = await con.db;

    String sql = """
    SELECT * FROM video WHERE id = $id;
    """;

    var result = await db.rawQuery(sql);
    Video video = Video.fromMap(result.first);

    return video;
  }

  Future<List<Video>> getVideosByFilters(type, genre) async {
    var db = await con.db;

    dynamic queryGenre;

    switch (genre) {
      case 'Comedia':
        {
          queryGenre = "1";
        }
      case 'Terror':
        {
          queryGenre = "2";
        }
      case 'Aventura':
        {
          queryGenre = "3";
        }
      case 'Suspense':
        {
          queryGenre = "4";
        }
      case 'Ação':
        {
          queryGenre = "5";
        }
    }

    String sql = """
    SELECT * FROM video_genre WHERE genreid = $queryGenre;
    """;

    var result = await db.rawQuery(sql);

    List<VideoGenre> videosByGenre = <VideoGenre>[];
    List<Video> videosByType = <Video>[];

    for (var video in result) {
      videosByGenre.add(VideoGenre.fromMap(video));
    }

    for (var filteredVideo in videosByGenre) {
      String sql = """
      SELECT * FROM video WHERE id = ${filteredVideo.video_id};
      """;

      var result = await db.rawQuery(sql);

      for (var aux in result) {
        Video video = Video.fromMap(aux);

        if (video.type == type) {
          videosByType.add(video);
        }
      }
    }

    return videosByType;
  }

  Future<List<Video>> getMyVideos(int id) async {
    var db = await con.db;

    String sql = """
        SELECT * FROM video WHERE creatorid = $id;
      """;

    var result = await db.rawQuery(sql);
    List<Video> videos = <Video>[];

    for (var video in result) {
      videos.add(Video.fromMap(video));
    }

    return videos;
  }

  Future<String> getCreator(Video video) async {
    var db = await con.db;

    String creatorName = "";

    String sql = """
          SELECT * FROM user WHERE id = ${video.creatorid};
    """;

    var result = await db.rawQuery(sql);

    print(result);

    if (result.isNotEmpty) {
      creatorName = User.fromMap(result.first).name;
    }

    return creatorName;
  }
}
