import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_credentials.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        age INTEGER,
        weight INTEGER,
        height INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE opened_lessons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        open_month INTEGER,
        open_lecture INTEGER
      )
    ''');
    await db.insert('opened_lessons', {'open_month': 1, 'open_lecture': 1});
  }

  Future<int> openMonth(int? index) async {
    final db = await database;
    final data = await query();
    return await db.update('opened_lessons', {
      'id': data['id'],
      'open_month': index == null ? data['open_month'] + 1 : index+1,
      'open_lecture': 1
    });
  }

  Future<int> openLecture(int? index) async {
    final db = await database;
    final data = await query();
    return await db.update('opened_lessons', {
      'id': data['id'],
      'open_lecture': index == null ? data['open_lecture'] + 1 : index+1
    });
  }

  Future<Map<String, dynamic>> query() async {
    final db = await database;
    final data = await db.query('opened_lessons', limit: 1);
    if (data.isEmpty) {
      return {'open_lecture': 1, 'open_month': 1};
    }
    return data.first;
  }

  Future<int> insertUserDetails(String id, String username, String password,
      String age, String weight, String height) async {
    final db = await database;
    await deleteAll();
    return await db.insert(
      'users',
      {
        'first_name': username,
        'last_name': password,
        "age": age,
        "weight": weight,
        "height": height
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    final db = await database;
    final results = await db.query(
      'users',
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertUser(String username, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'first_name': username, 'last_name': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> existsUser() async {
    final db = await database;
    final results = await db.query('users');
    return results.isEmpty;
  }

  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final results = await db.query('users', limit: 1);
    return results.isNotEmpty ? results.first : null;
  }

  Future<void> deleteUser(String username) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'first_name = ?',
      whereArgs: [username],
    );
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db
        .delete(
          'users',
        );
  }

  Future<void> clearLimit() async {
    final db = await database;
    await db.delete('opened_lessons');
  }

  Future<void> insert() async {
    final db = await database;
    await db.insert('opened_lessons', {
      'open_lecture': 1,
      'open_month': 1
    });
  }
}
