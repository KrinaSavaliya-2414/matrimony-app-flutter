import 'package:demo/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('vivaahverse.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        mobile TEXT NOT NULL,
        dob TEXT NOT NULL,
        gender TEXT NOT NULL,
        city TEXT NOT NULL,
        password TEXT NOT NULL,
        isFavorite INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // INSERT USER
  Future<int> insertUser(UserModel user) async{
    final db = await database;

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET ALL USERS
  Future<List<UserModel>> getUsers() async{
    final db = await database;

    final result = await db.query(
      'users',
      orderBy: 'id DESC',
    );

    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  // UPDATE USER
  Future<int> updateUser(UserModel user) async{
    final db = await database;

    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE USER
  Future<int> deleteUser(int id) async{
    final db = await database;

    return await db.delete(
        'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CLOSE DATABASE
  Future<void> close() async{
    final db = await database;
    await db.close();
    _database = null;
  }
}