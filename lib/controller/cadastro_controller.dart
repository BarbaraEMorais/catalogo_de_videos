import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/user.dart';

class CadastroController {
  DatabaseHelper con = DatabaseHelper();

  Future<int> saveUser(User user) async {
    var db = await con.db;

    int result = await db.insert("user", user.toMap());

    return result;
  }

  Future<int> deleteUser(User user) async {
    var db = await con.db;

    int result = await db.delete("user", where: "id=?", whereArgs: [user.id]);

    return result;
  }

  // a partir do user e senha, tenta pegar o Cadastro
  Future<User> getCadastro(String name, String password) async {
    var db = await con.db;

    String sql = """
    SELECT * FROM user 
    WHERE name='$name' AND password='$password';
    """;

    var result = await db.rawQuery(sql);

    // significa que query retornou algo
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    // usuario padrao de erro
    return User(
      id: -1,
      email: "",
      name: "",
      password: "",
    );
  }

  Future<bool> verifyEmail(String email) async {
    var db = await con.db;

    String sql = """
    SELECT * FROM user 
    WHERE email='$email';
    """;

    var result = await db.rawQuery(sql);

    // significa que query retornou algo
    if (result.isEmpty) {
      return true;
    }
    return false;
  }
}
