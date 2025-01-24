import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      ':memory:',
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT)');
      },
    );
    return _database!;
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<User>> fetchUsers() async {
    final db = await database;
    final result = await db.query('users');
    return result.map((e) => User.fromMap(e)).toList();
  }
}
