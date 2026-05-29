import 'package:get/get.dart';
import '../models/task.dart';

/// Simplified TaskController - No Service Layer
/// 
/// Direct data management in the controller
/// Perfect for beginners learning GetX
class TaskController extends GetxController {
  // ═══════════════════════════════════════════════════════════════
  // REACTIVE VARIABLES
  // ═══════════════════════════════════════════════════════════════

  final RxList<Task> tasks = <Task>[].obs;
  final RxList<Task> displayedTasks = <Task>[].obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedStatus = 'all'.obs; // all, pending, completed
  final RxString selectedCategory = 'All'.obs;

  // ═══════════════════════════════════════════════════════════════
  // COMPUTED PROPERTIES
  // ═══════════════════════════════════════════════════════════════

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  int get pendingCount => tasks.where((t) => !t.isCompleted).length;
  int get completionPercentage =>
      tasks.isEmpty ? 0 : ((completedCount / tasks.length) * 100).toInt();

  List<String> get allCategories {
    final cats = tasks.map((t) => t.category).toSet().toList();
    cats.insert(0, 'All');
    return cats;
  }

  // ═══════════════════════════════════════════════════════════════
  // LIFECYCLE
  // ═══════════════════════════════════════════════════════════════

  @override
  void onInit() {
    super.onInit();
    // Load sample tasks
    _loadSampleTasks();

    // React to search/filter changes
    ever(searchQuery, (_) => _applyFilters());
    ever(selectedStatus, (_) => _applyFilters());
    ever(selectedCategory, (_) => _applyFilters());
  }

  // ═══════════════════════════════════════════════════════════════
  // SAMPLE DATA
  // ═══════════════════════════════════════════════════════════════

  void _loadSampleTasks() {
    tasks.value = [
      Task(
        id: '1',
        title: 'Complete Flutter Course',
        description: 'Finish all modules and projects',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        priority: 'high',
        isCompleted: false,
        category: 'Learning',
      ),
      Task(
        id: '2',
        title: 'Fix login bug',
        description: 'Users unable to reset password',
        dueDate: DateTime.now().add(const Duration(days: 1)),
        priority: 'high',
        isCompleted: false,
        category: 'Work',
      ),
      Task(
        id: '3',
        title: 'Buy groceries',
        description: 'Milk, eggs, vegetables',
        dueDate: DateTime.now().add(const Duration(days: 2)),
        priority: 'low',
        isCompleted: false,
        category: 'Personal',
      ),
    ];
    _applyFilters();
  }

  // ═══════════════════════════════════════════════════════════════
  // CRUD OPERATIONS
  // ═══════════════════════════════════════════════════════════════

  /// Add new task
  void addTask(Task newTask) {
    tasks.add(newTask);
    _applyFilters();
    Get.snackbar('Success', 'Task added');
  }

  /// Update task
  void updateTask(String id, Task updatedTask) {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      tasks[index] = updatedTask;
      _applyFilters();
      Get.snackbar('Success', 'Task updated');
    }
  }

  /// Delete task
  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    _applyFilters();
    Get.snackbar('Deleted', 'Task removed');
  }

  /// Toggle completion
  void toggleCompletion(String id) {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      final task = tasks[index];
      tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
      _applyFilters();
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // FILTERING & SEARCH
  // ═══════════════════════════════════════════════════════════════

  void _applyFilters() {
    List<Task> filtered = List.from(tasks);

    // Filter by status
    if (selectedStatus.value == 'completed') {
      filtered = filtered.where((t) => t.isCompleted).toList();
    } else if (selectedStatus.value == 'pending') {
      filtered = filtered.where((t) => !t.isCompleted).toList();
    }

    // Filter by category
    if (selectedCategory.value != 'All') {
      filtered =
          filtered.where((t) => t.category == selectedCategory.value).toList();
    }

    // Search
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered
          .where((t) =>
              t.title.toLowerCase().contains(query) ||
              t.description.toLowerCase().contains(query))
          .toList();
    }

    // Sort by due date
    filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    displayedTasks.value = filtered;
  }

  void setStatusFilter(String status) {
    selectedStatus.value = status;
  }

  void setCategoryFilter(String category) {
    selectedCategory.value = category;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearFilters() {
    selectedStatus.value = 'all';
    selectedCategory.value = 'All';
    searchQuery.value = '';
  }
}
