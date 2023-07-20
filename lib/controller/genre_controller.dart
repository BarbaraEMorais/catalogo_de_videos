import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/genre.dart';

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

  
}
