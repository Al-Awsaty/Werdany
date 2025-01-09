import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HormoneTrackerService {
  static final HormoneTrackerService _instance = HormoneTrackerService._internal();
  factory HormoneTrackerService() => _instance;
  HormoneTrackerService._internal();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'hormone_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE hormones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            dosage REAL,
            schedule TEXT,
            purpose TEXT
          )
        ''');
      },
    );
  }

  Future<void> addHormone(String name, double dosage, String schedule, String purpose) async {
    final db = await database;
    await db.insert(
      'hormones',
      {
        'name': name,
        'dosage': dosage,
        'schedule': schedule,
        'purpose': purpose,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editHormone(int id, String name, double dosage, String schedule, String purpose) async {
    final db = await database;
    await db.update(
      'hormones',
      {
        'name': name,
        'dosage': dosage,
        'schedule': schedule,
        'purpose': purpose,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteHormone(int id) async {
    final db = await database;
    await db.delete(
      'hormones',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getHormones() async {
    final db = await database;
    return await db.query('hormones');
  }
}
