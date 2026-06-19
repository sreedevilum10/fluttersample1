// lib/domain/repositories/task_repository.dart

import '../entities/task.dart';

/// Abstract repository - defines the contract
abstract class TaskRepository {
  // Create
  Future<void> addTask(Task task);

  // Read
  Future<List<Task>> getAllTasks();
  Future<Task?> getTaskById(String id);

  // Update
  Future<void> updateTask(Task task);

  // Delete
  Future<void> deleteTask(String id);

  //=================== Stream continuously monitor task changes ==================
  Stream<List<Task>> watchAllTasks();
}
