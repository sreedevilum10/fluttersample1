// lib/domain/usecases/task_usecases.dart

import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Use case: Get all tasks
class GetAllTasksUseCase {
  final TaskRepository repository;
  GetAllTasksUseCase(this.repository);
  Future<List<Task>> call() =>
      repository.getAllTasks();
}

/// Use case: Add task
class AddTaskUseCase {
  final TaskRepository repository;
  AddTaskUseCase(this.repository);
  Future<void> call(Task task) =>
      repository.addTask(task);
}

/// Use case: Update task
class UpdateTaskUseCase {
  final TaskRepository repository;
  UpdateTaskUseCase(this.repository);
  Future<void> call(Task task) =>
      repository.updateTask(task);
}

/// Use case: Delete task
class DeleteTaskUseCase {
  final TaskRepository repository;
  DeleteTaskUseCase(this.repository);
  Future<void> call(String id) =>
      repository.deleteTask(id);
}

/// Use case: Toggle task completion
class ToggleTaskUseCase {
  final TaskRepository repository;
  ToggleTaskUseCase(this.repository);
  Future<void> call(Task task) {
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
    return repository.updateTask(updatedTask);
  }
}

/// Use case: Watch all tasks
class WatchAllTasksUseCase {
  final TaskRepository repository;
  WatchAllTasksUseCase(this.repository);
  Stream<List<Task>> call() =>
      repository.watchAllTasks();
}
