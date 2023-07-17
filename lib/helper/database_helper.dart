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
    // databaseFactory.deleteDatabase(path);
    Database db = await openDatabase(
      path,
      version: 1,
      // onCreate acontece só a primeira vez
      onCreate: (db, version) async {
        String sql_user = """
        CREATE TABLE user(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR NOT NULL,
            email VARCHAR NOT NULL,
            password VARCHAR NOT NULL
        );""";

        String sql_genre = """
          CREATE TABLE genre(
                      id INTEGER PRIMARY KEY AUTOINCREMENT,
                      name VARCHAR NOT NULL
                  );
          """;

        String sql_video = """
                CREATE TABLE video(
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            name VARCHAR(2) NOT NULL,
                            description TEXT NOT NULL,
                          type INTEGER NOT NULL,
                          ageRestriction VARCHAR NOT NULL,
                          durationMinutes INTEGER NOT NULL,
                          thumbnailImageId VARCHAR NOT NULL,
                          releaseDate TEXT NOT NULL
                        );
                """;

        String sql_video_genre = """
                CREATE TABLE video_genre(
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  videoid INTEGER NOT NULL,
                  genreid INTEGER NOT NULL,
                  FOREIGN KEY(videoid) REFERENCES video(id),
                  FOREIGN KEY(genreid) REFERENCES genre(id)
                );
            """;

        await db.execute(sql_user);
        await db.execute(sql_genre);
        await db.execute(sql_video);
        await db.execute(sql_video_genre);

        for (int i = 1; i < 6; i++) {
          String sql_insert_user =
              "INSERT INTO user(name, email, password) VALUES('Teste $i', 'teste$i@teste', '123456');";
          await db.execute(sql_insert_user);
        }

        List<String> generos = [
          'Comedia',
          'Terror',
          'Aventura',
          'Suspense',
          'Ação'
        ];
        for (String genero in generos) {
          String sql_insert_genre =
              "INSERT INTO genre(name) VALUES('$genero');";
          await db.execute(sql_insert_genre);
        }

        for (int i = 1; i < 6; i++) {
          String sql_insert_video =
              "INSERT INTO video(name, description, type, ageRestriction, durationMinutes, thumbnailImageId, releaseDate) VALUES('Filme $i', 'Descrição $i', 0, '18 anos', 120, 'url imagem', '01/01/2020');";
          await db.execute(sql_insert_video);
        }

        String add_video_genre_1 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(1, 1);";
        String add_video_genre_2 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(1, 2);";
        String add_video_genre_3 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(2, 5);";
        String add_video_genre_4 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(3, 4);";
        String add_video_genre_5 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(4, 3);";
        String add_video_genre_6 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(5, 1);";
        String add_video_genre_7 =
            "INSERT INTO video_genre(videoid, genreid) VALUES(5, 5);";

        await db.execute(add_video_genre_1);
        await db.execute(add_video_genre_2);
        await db.execute(add_video_genre_3);
        await db.execute(add_video_genre_4);
        await db.execute(add_video_genre_5);
        await db.execute(add_video_genre_6);
        await db.execute(add_video_genre_7);
      },
    );

    return db;
  }
}
