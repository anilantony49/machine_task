import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:machine_task/data/model.dart';

class DatabaseHelper {
  // Database name and version constants
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  // Table name
  static const table = 'repositories';

  // Singleton pattern to ensure only one instance of DatabaseHelper is created
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // Database object, initially null
  static Database? _database;
  // Getter to access the database; if it doesn't exist, it initializes it
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database by opening it and creating the necessary tables
  Future<Database> _initDatabase() async {
    // Opens the database at the specified path and calls _onCreate if the database doesn't exist
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Creates the repositories table with the specified columns
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

  // Inserts a repository into the table; replaces if there's a conflict
  Future<void> insertRepository(Repository repo) async {
    final db = await database;
    await db.insert(
      'repositories',
      repo.toMap(), // Converts the Repository object to a map
      conflictAlgorithm: ConflictAlgorithm
          .replace, // Replaces the existing entry if there is a conflict
    );
  }

  // Deletes a repository from the table by its ID
  Future<void> deleteRepository(String id) async {
    final db = await database;
    await db.delete(
      table,
      where: 'id = ?', // SQL WHERE clause to specify the repository to delete
      whereArgs: [id], // Arguments for the WHERE clause
    );
  }
}
