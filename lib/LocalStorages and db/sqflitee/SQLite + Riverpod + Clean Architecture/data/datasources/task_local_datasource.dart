// lib/data/datasources/task_local_datasource.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';

/// Local data source - handles SQLite operations
class TaskLocalDataSource {
  static const String _tableName = 'tasks';
  Database? _database;

  // Get database (lazy initialization)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'task_manager.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        priority TEXT NOT NULL,
        isCompleted INTEGER DEFAULT 0,
        category TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  // Create (Insert)
  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db.insert(
      _tableName,
      task.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read (Get all)
  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      orderBy: 'dueDate ASC',
    );
    return maps.map((map) => TaskModel.fromJson(map)).toList();
  }

  // Read (Get by ID)
  Future<TaskModel?> getTaskById(String id) async {
    final db = await database;
    final maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isEmpty) return null;
    return TaskModel.fromJson(maps.first);
  }

  // Update
  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Delete
  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
