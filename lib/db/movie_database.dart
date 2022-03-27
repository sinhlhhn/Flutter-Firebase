import 'package:simple_app/modules/movie/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MovieDatabase {
  MovieDatabase._init();
  static final MovieDatabase _instance = MovieDatabase._init();
  final String _dbName = "MovieDatabase.db";
  final String _movietableName = "movies";

  /// Việc sử dụng `factory` ở đây chỉ có ý nghĩa nếu như sau này không muốn
  /// `class` này là `Singleton` nữa thì khi đó sẽ chỉ cần thay đổi ở tại chính
  /// `class` này mà không cầnt thay đổi ở tất cả những nơi sử dụng nó như cách
  /// sử dung `static varible instance`
  factory MovieDatabase() {
    return _instance;
  }

  Future<Database> _database() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    print(path);

    return await openDatabase(
      path,
      onCreate: _createDatabase,
      version: 1,
    );
  }

  Future _createDatabase(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';

    await db.execute('''
      CREATE TABLE $_movietableName (
      ${MovieFields.id} $idType,
      ${MovieFields.comparison} $integerType,
      ${MovieFields.voteCount} $integerType,
      ${MovieFields.voteAverage} $integerType,
      ${MovieFields.title} $textType,
      ${MovieFields.popularity} $doubleType,
      ${MovieFields.posterPath} $textType,
      ${MovieFields.originalLanguage} $textType,
      ${MovieFields.originalTitle} $textType,
      ${MovieFields.backdropPath} $textType,
      ${MovieFields.overview} $textType,
      ${MovieFields.releaseDate} $textType,
      ${MovieFields.isFavourite} $boolType
    )
''');
  }

  Future insertMovie(Movie movie) async {
    final db = await _database();
    final value = await db.insert(_movietableName, movie.toSqlJson());
    print(value);
  }

  Future<List<Movie>> readMovie(int movieId) async {
    final db = await _database();
    final value = await db.query(
      _movietableName,
      where: "id = ?",
      whereArgs: [movieId],
    );

    print(value);
    return List.generate(value.length, (index) {
      return Movie.fromSqlJson(value[index]);
    });
  }

  Future deleteMovie(int movieId) async {
    final db = await _database();
    final value = await db.delete(
      _movietableName,
      where: "id = ?",
      whereArgs: [movieId],
    );
    print(value);
  }

  Future updateMovie(Movie movie) async {
    final db = await _database();
    final value = await db.update(
      _movietableName,
      movie.toSqlJson(),
      where: "id = ?",
      whereArgs: [movie.id],
    );
    print(value);
  }

  Future updateFavouriteMovie(bool isFavourite) async {
    final db = await _database();
    try {
      final value = await db.rawUpdate(
          "UPDATE $_movietableName SET is_favourite = ?", [isFavourite]);
      print(value);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    await deleteDatabase(path).whenComplete(() {
      print('LOG: DELETE DB SUCCESS');
    }).catchError((onError) {
      print(onError);
    });
  }

  Future close() async {
    final db = await _database();
    db.close();
  }
}
