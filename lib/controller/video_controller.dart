import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/model/video_genre.dart';

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

  Future<List<Video>> getVideosByFilters(type, genre) async {
    var db = await con.db;
    List<Video> videosByType = <Video>[];

    dynamic queryGenre;

    switch (genre) {
      case 'Comedia': {
        queryGenre = "0";
      }
      case 'Terror': {
        queryGenre = "1";
      }
      case 'Aventura': {
        queryGenre = "2";
      }
      case 'Suspense': {
        queryGenre = "3";
      }
      case 'Ação': {
        queryGenre = "4";
      }
    }

    String sql = """
    SELECT * FROM video_genre WHERE genreid = $queryGenre;
    """;

    var result = await db.rawQuery(sql);
    List<VideoGenre> videosByGenre = <VideoGenre>[];
    print("result:");
    print(result);

    for (var video in result) {
      print(video);
      videosByGenre.add(VideoGenre.fromMap(video));
    }

    for(var filteredVideo in videosByGenre) {
      
      String sql = """
      SELECT * FROM video WHERE id = ${filteredVideo.id};
      """;
      
      var result = await db.rawQuery(sql);
      
      for (var video in videosByType) {
        if (video.type == type){
          videosByType.add(video);
        }
      }
    }

    return videosByType;
  }
}
