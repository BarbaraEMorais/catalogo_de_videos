import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/video.dart';

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
}
