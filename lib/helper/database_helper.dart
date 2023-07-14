import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instancia = DatabaseHelper.constInterno();
  static Database? _db;

  // sempre que for acessar, retorna a unica instancia
  factory DatabaseHelper() => _instancia;

  DatabaseHelper.constInterno();

  // usa future pq nao vai ta pronto no momento que chamar
  // metodo padrao do get
  Future<Database> get db async {
    // se for nulo, executa initDb, se nao, retorna _db
    return _db ??= await initDb();
  }

  // inicia o banco de dados
  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    // join concatena strings
    final path = p.join(databasePath, "data.db");

    Database db = await openDatabase(
      path,
      version: 1,
      // onCreate acontece só a primeira vez
      onCreate: (db, version) async {
        String sql = """
        CREATE TABLE user(
          id INTEGER PRIMARY KEY KEY AUTOINCREMENT,
          username VARCHAR,
          password VARCHAR
        );
        """;

        await db.execute(sql);
      },
    );

    return db;
  }
}
