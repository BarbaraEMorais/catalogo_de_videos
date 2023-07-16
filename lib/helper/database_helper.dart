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

        // INSERT INTO user(name, email, password) VALUES('Teste 1', 'teste1@teste', '123456');
        // INSERT INTO user(name, email, password) VALUES('Teste 2', 'teste2@teste', '123456');
        // INSERT INTO user(name, email, password) VALUES('Teste 3', 'teste3@teste', '123456');
        // INSERT INTO user(name, email, password) VALUES('Teste 4', 'teste4@teste', '123456');
        // INSERT INTO user(name, email, password) VALUES('Teste 5', 'teste5@teste', '123456');

        // INSERT INTO genre(name) VALUES('Comedia');
        // INSERT INTO genre(name) VALUES('Terror');
        // INSERT INTO genre(name) VALUES('Aventura');
        // INSERT INTO genre(name) VALUES('Suspense');
        // INSERT INTO genre(name) VALUES('Ação');

        // INSERT INTO video(name, description, type, ageRestriction, durationMinutes, thumbnailImageId, releaseDate) VALUES('Filme 1', 'Descrição 1', 0, '18 anos', 120, 'url imagem', '01/01/2020');
        // INSERT INTO video(name, description, type, ageRestriction, durationMinutes, thumbnailImageId, releaseDate) VALUES('Filme 2', 'Descrição 2', 0, '18 anos', 120, 'url imagem', '01/01/2020');
        // INSERT INTO video(name, description, type, ageRestriction, durationMinutes, thumbnailImageId, releaseDate) VALUES('Filme 3', 'Descrição 3', 0, '18 anos', 120, 'url imagem', '01/01/2020');
        // INSERT INTO video(name, description, type, ageRestriction, durationMinutes, thumbnailImageId, releaseDate) VALUES('Filme 4', 'Descrição 4', 0, '18 anos', 120, 'url imagem', '01/01/2020');
        // INSERT INTO video(name, description, type, ageRestriction, durationMinutes, thumbnailImageId, releaseDate) VALUES('Filme 5', 'Descrição 5', 0, '18 anos', 120, 'url imagem', '01/01/2020');

        // INSERT INTO video_genre(videoid, genreid) VALUES(1, 1);
        // INSERT INTO video_gvideoidenre(videoid, genreid) VALUES(1, 2);
        // INSERT INTO video_genre(videoid, genreid) VALUES(2, 5);
        // INSERT INTO video_genre(videoid, genreid) VALUES(3, 4);
        // INSERT INTO video_genre(videoid, genreid) VALUES(4, 3);
        // INSERT INTO video_genre(videoid, genreid) VALUES(5, 1);
        // INSERT INTO video_genre(videoid, genreid) VALUES(5, 5);

        await db.execute(sql_user);
        await db.execute(sql_genre);
        await db.execute(sql_video);
        await db.execute(sql_video_genre);
      },
    );
    print("database: $db");

    return db;
  }
}
