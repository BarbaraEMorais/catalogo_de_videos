import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/genre.dart';

import '../model/video.dart';

class GenreController {
  DatabaseHelper con = DatabaseHelper();

  Future<int> saveGenre(Genre genre) async {
    var db = await con.db;

    int result = await db.insert("genre", genre.toMap());

    return result;
  }

  Future<int> deleteGenre(Genre genre) async {
    var db = await con.db;

    int result = await db.delete("genre", where: "id=?", whereArgs: [genre.id]);

    return result;
  }

  Future<Genre> getGenreByVideo(Video video) async {
    var db = await con.db;

    String sql = """
    SELECT g.id, g.name FROM video_genre vg JOIN genre g ON vg.genreid = g.id
    WHERE vg.videoid ='${video.id}';
    """;

    var result = await db.rawQuery(sql);
    // significa que query retornou algo
    if (result.isNotEmpty) {
      return Genre.fromMap(result.first);
    }

    // genero padrao de erro
    return Genre(
      id: -1,
      name: "",
    );
  }
}