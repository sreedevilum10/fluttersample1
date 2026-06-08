// lib/data/repositories/task_repository_impl.dart

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

/// Repository implementation - bridges domain and data
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.insertTask(taskModel);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final tasks = await localDataSource.getAllTasks();
    return tasks;
  }

  @override
  Future<Task?> getTaskById(String id) async {
    return await localDataSource.getTaskById(id);
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }

  @override
  Stream<List<Task>> watchAllTasks() async* {
    // Simple polling implementation
    // For better performance, consider using sqflite Batch or StreamController
    while (true) {
      final tasks = await getAllTasks();
      yield tasks;
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}
