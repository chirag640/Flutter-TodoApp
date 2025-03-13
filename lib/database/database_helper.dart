import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/model/user.dart';

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
    String path = join(await getDatabasesPath(), 'todo_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        username TEXT,
        password TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE todos (
        id TEXT PRIMARY KEY,
        title TEXT,
        isCompleted INTEGER,
        userId TEXT,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  Future<List<Todo>> getTodos(String userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('todos', where: 'userId = ?', whereArgs: [userId]);
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isCompleted: maps[i]['isCompleted'] == 1,
        userId: maps[i]['userId'],
      );
    });
  }

  Future<void> insertTodo(Todo todo) async {
    Database db = await database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(Todo todo) async {
    Database db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    Database db = await database;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<User?> getUser(String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (maps.isNotEmpty) {
      return User(
        id: maps[0]['id'],
        username: maps[0]['username'],
        password: maps[0]['password'],
      );
    }
    return null;
  }

  Future<void> insertUser(User user) async {
    Database db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> saveLastLoggedInUser(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastLoggedInUser', userId);
  }

  Future<String?> getLastLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastLoggedInUser');
  }

  Future<void> clearLastLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLoggedInUser');
  }

    Future<String?> getUsername(String userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return maps[0]['username'];
    }
    return null;
  }
}