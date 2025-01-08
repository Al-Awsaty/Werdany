import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:your_app/services/hormone_tracker_service.dart';
import 'package:your_app/services/api_service.dart';

class SyncService {
  static final SyncService _instance = SyncService._internal();
  factory SyncService() => _instance;
  SyncService._internal();

  Database? _database;
  final ApiService _apiService = ApiService(baseUrl: 'https://api.example.com', authToken: 'your_auth_token');

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sync_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sync_status (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            table_name TEXT,
            last_sync TEXT
          )
        ''');
      },
    );
  }

  Future<void> syncData() async {
    await _syncHormones();
  }

  Future<void> _syncHormones() async {
    final db = await database;
    final hormones = await db.query('hormones');
    final response = await _apiService.postRequest('sync/hormones', {'hormones': hormones});

    if (response.statusCode == 200) {
      await db.insert(
        'sync_status',
        {
          'table_name': 'hormones',
          'last_sync': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      throw Exception('Failed to synchronize hormones');
    }
  }

  Future<void> checkForUpdates() async {
    final db = await database;
    final response = await _apiService.getRequest('updates');

    if (response.statusCode == 200) {
      final updates = json.decode(response.body);
      for (var update in updates) {
        if (update['table'] == 'hormones') {
          await db.insert(
            'hormones',
            update['data'],
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    } else {
      throw Exception('Failed to check for updates');
    }
  }

  Future<void> runPeriodicSync() async {
    while (true) {
      await syncData();
      await Future.delayed(Duration(hours: 1));
    }
  }
}
