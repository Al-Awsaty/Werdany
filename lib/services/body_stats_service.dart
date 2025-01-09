import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:your_app/models/body_stats.dart';

class BodyStatsService {
  static final BodyStatsService _instance = BodyStatsService._internal();
  factory BodyStatsService() => _instance;
  BodyStatsService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'body_stats.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE body_stats(id INTEGER PRIMARY KEY, weight REAL, muscleMass REAL, fatPercentage REAL, date TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE body_stats ADD COLUMN date TEXT',
          );
        }
      },
    );
  }

  Future<void> addBodyStat(BodyStats stat) async {
    final db = await database;
    await db.insert(
      'body_stats',
      stat.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateBodyStat(BodyStats stat) async {
    final db = await database;
    await db.update(
      'body_stats',
      stat.toJson(),
      where: 'id = ?',
      whereArgs: [stat.id],
    );
  }

  Future<void> deleteBodyStat(int id) async {
    final db = await database;
    await db.delete(
      'body_stats',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<BodyStats>> getBodyStats() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('body_stats');
    return List.generate(maps.length, (i) {
      return BodyStats.fromJson(maps[i]);
    });
  }
}
