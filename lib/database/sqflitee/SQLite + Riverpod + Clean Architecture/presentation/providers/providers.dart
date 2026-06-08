// lib/presentation/providers/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/datasources/task_local_datasource.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/task_usecases.dart';

// ═══════════════════════════════════════════════════════════════
// DATASOURCE & REPOSITORY PROVIDERS
// ═══════════════════════════════════════════════════════════════

final taskLocalDataSourceProvider = Provider((ref) {
  return TaskLocalDataSource();
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final dataSource = ref.watch(taskLocalDataSourceProvider);
  return TaskRepositoryImpl(dataSource);
});

// ═══════════════════════════════════════════════════════════════
// USE CASE PROVIDERS
// ═══════════════════════════════════════════════════════════════

final getAllTasksUseCaseProvider = Provider((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return GetAllTasksUseCase(repository);
});

final addTaskUseCaseProvider = Provider((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return AddTaskUseCase(repository);
});

final updateTaskUseCaseProvider = Provider((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return UpdateTaskUseCase(repository);
});

final deleteTaskUseCaseProvider = Provider((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return DeleteTaskUseCase(repository);
});

final toggleTaskUseCaseProvider = Provider((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return ToggleTaskUseCase(repository);
});

// ═══════════════════════════════════════════════════════════════
// FILTER PROVIDERS (STATE)
// ═══════════════════════════════════════════════════════════════

final statusFilterProvider = StateProvider<String>((ref) => 'all');
final categoryFilterProvider = StateProvider<String>((ref) => 'All');
final searchQueryProvider = StateProvider<String>((ref) => '');

// ═══════════════════════════════════════════════════════════════
// TASKS LIST PROVIDER
// ═══════════════════════════════════════════════════════════════

final tasksProvider = FutureProvider<List<Task>>((ref) async {
  final useCase = ref.watch(getAllTasksUseCaseProvider);
  return await useCase.call();
});

// ═══════════════════════════════════════════════════════════════
// FILTERED TASKS PROVIDER (DERIVED STATE)
// ═══════════════════════════════════════════════════════════════

final filteredTasksProvider = Provider<List<Task>>((ref) {
  final tasksAsyncValue = ref.watch(tasksProvider);
  final statusFilter = ref.watch(statusFilterProvider);
  final categoryFilter = ref.watch(categoryFilterProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  return tasksAsyncValue.when(
    data: (tasks) {
      List<Task> filtered = tasks;

      // Filter by status
      if (statusFilter == 'pending') {
        filtered = filtered.where((t) => !t.isCompleted).toList();
      } else if (statusFilter == 'done') {
        filtered = filtered.where((t) => t.isCompleted).toList();
      }

      // Filter by category
      if (categoryFilter != 'All') {
        filtered = filtered.where((t) => t.category == categoryFilter).toList();
      }

      // Search
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        filtered = filtered
            .where((t) =>
        t.title.toLowerCase().contains(query) ||
            t.description.toLowerCase().contains(query))
            .toList();
      }

      // Sort by due date
      filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));

      return filtered;
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// ═══════════════════════════════════════════════════════════════
// STATISTICS PROVIDERS (COMPUTED) - ✅ FIXED .valueOrNull → .when()
// ═══════════════════════════════════════════════════════════════

final totalTasksProvider = Provider<int>((ref) {
  final tasksAsync = ref.watch(tasksProvider);
  return tasksAsync.when(
    data: (tasks) => tasks.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final pendingTasksProvider = Provider<int>((ref) {
  final tasksAsync = ref.watch(tasksProvider);
  return tasksAsync.when(
    data: (tasks) => tasks.where((t) => !t.isCompleted).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final completedTasksProvider = Provider<int>((ref) {
  final tasksAsync = ref.watch(tasksProvider);
  return tasksAsync.when(
    data: (tasks) => tasks.where((t) => t.isCompleted).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

// ═══════════════════════════════════════════════════════════════
// CATEGORIES PROVIDER (DERIVED) - ✅ FIXED .valueOrNull → .when()
// ═══════════════════════════════════════════════════════════════

final categoriesProvider = Provider<List<String>>((ref) {
  final tasksAsync = ref.watch(tasksProvider);
  return tasksAsync.when(
    data: (tasks) {
      final categories = tasks.map((t) => t.category).toSet().toList();
      categories.insert(0, 'All');
      return categories;
    },
    loading: () => ['All'],
    error: (_, __) => ['All'],
  );
});

// ═══════════════════════════════════════════════════════════════
// ACTION PROVIDERS (MUTATIONS)
// ═══════════════════════════════════════════════════════════════

final addTaskProvider = FutureProvider.family<void, Task>((ref, task) async {
  final useCase = ref.watch(addTaskUseCaseProvider);
  await useCase.call(task);
  // Refresh tasks list after adding
  ref.refresh(tasksProvider);
});

final updateTaskProvider = FutureProvider.family<void, Task>((ref, task) async {
  final useCase = ref.watch(updateTaskUseCaseProvider);
  await useCase.call(task);
  // Refresh tasks list after updating
  ref.refresh(tasksProvider);
});

final deleteTaskProvider = FutureProvider.family<void, String>((ref, id) async {
  final useCase = ref.watch(deleteTaskUseCaseProvider);
  await useCase.call(id);
  // Refresh tasks list after deleting
  ref.refresh(tasksProvider);
});

final toggleTaskProvider = FutureProvider.family<void, Task>((ref, task) async {
  final useCase = ref.watch(toggleTaskUseCaseProvider);
  await useCase.call(task);
  // Refresh tasks list after toggling
  ref.refresh(tasksProvider);
});