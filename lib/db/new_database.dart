import 'package:simple_app/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PokemonDatabase {
  static final PokemonDatabase instance = PokemonDatabase._init();

  static Database? _database;

  PokemonDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pokemon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    await db.execute('''
    CREATE TABLE $tableNotes (
      ${NoteFields.id} $idType,
      ${NoteFields.isImportant} $boolType,
      ${NoteFields.number} $integerType,
      ${NoteFields.title} $textType,
      ${NoteFields.description} $textType,
      ${NoteFields.time} $textType,
    )
    ''');
  }

  Future<Note> create(Note note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time},';
    // final values =
    //     '${json[NoteFields.time]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}, ';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, note.toJson());

    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('$id not found');
    }
  }

  Future<List<Note>> readAllNote() async {
    final db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';

    // final results = 'SELECT * FROM $tableNotes ORDER BY $orderBy';

    final results = await db.query(tableNotes, orderBy: orderBy);

    return results.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;

    return db.update(tableNotes, note.toJson());
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    return db.delete(
      tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
