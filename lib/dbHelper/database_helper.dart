import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:machine_task/data/model.dart';

  class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  static const table = 'repositories';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }
    Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id TEXT PRIMARY KEY,
            repoName TEXT NOT NULL,
            userName TEXT NOT NULL,
            imageUrl TEXT,
            stargazersCount INTEGER NOT NULL,
            description TEXT
          )
          ''');
    }
  Future<void> insertRepository(Repository repo) async {
    final db = await database;
    await db.insert(
      'repositories',
      repo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteRepository(String id) async {
    final db = await database;
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
