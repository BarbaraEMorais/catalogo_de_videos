import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class VideoController {
  DatabaseHelper con = DatabaseHelper();
  List<Map<String, dynamic>> videos = const <Map<String, dynamic>>[];

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
  void getVideos() async {
    var db = await con.db;

    String sql = """
    SELECT * FROM video;
    """;

    // se precisar apagar a tabela
    // final databasePath = await getDatabasesPath();
    // final path = p.join(databasePath, "data.db");
    // databaseFactory.deleteDatabase(path);

    var result = await db.rawQuery(sql);

    print(result);
    // for (var video in result) {
    //   videos.add(video);
    // }
    // return videos;
  }
}
