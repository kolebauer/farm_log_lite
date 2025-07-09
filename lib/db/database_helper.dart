import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/log.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'farm_log.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE logs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            field TEXT,
            crop TEXT,
            activity TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertLog(Log log) async {
    final db = await database;
    await db.insert('logs', log.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Log>> getLogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('logs');

    return List.generate(maps.length, (i) {
      return Log(
        id: maps[i]['id'],
        field: maps[i]['field'],
        crop: maps[i]['crop'],
        activity: maps[i]['activity'],
        date: maps[i]['date'],
      );
    });
  }
}
