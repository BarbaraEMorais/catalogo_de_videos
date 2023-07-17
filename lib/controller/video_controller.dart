import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

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

  // a partir do user e senha, tenta pegar o login
  Future<List<Video>> getVideos() async {
    var db = await con.db;

    String sql = """
    SELECT * FROM video;
    """;

    // se precisar apagar a tabela
    // final databasePath = await getDatabasesPath();
    // final path = p.join(databasePath, "data.db");
    // databaseFactory.deleteDatabase(path);
    var result = await db.rawQuery(sql);
    List<Video> videos = <Video>[];

    for (var video in result) {
      Video novo_video = Video.fromMap(video);
      videos.add(novo_video);
    }
    return videos;
    // return videos;
  }
}
