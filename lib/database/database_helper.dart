import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE body_stats (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            weight REAL,
            muscleMass REAL,
            fatPercentage REAL
          )
        ''');
        await db.execute('''
          CREATE TABLE hormones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            dosage REAL,
            schedule TEXT,
            purpose TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE diet_plans (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            calories INTEGER,
            protein INTEGER,
            carbs INTEGER,
            fats INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE progress_photos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            photoPath TEXT,
            date TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE trainer_profiles (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            clients TEXT
          )
        ''');
      },
    );
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(String table, Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    final db = await database;
    await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<void> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;
    return await db.query(table);
  }
}
