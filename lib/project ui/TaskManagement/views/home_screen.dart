import 'package:flutter/material.dart';
import 'package:fluttersample1/project%20ui/TaskManagement/views/task_detail_screen.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class HomeScreenTask extends StatelessWidget {
  const HomeScreenTask({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('📋 Task Manager'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // STATS
          Obx(() => Container(
            color: Colors.blue.shade50,
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatCard('Total', controller.tasks.length, Colors.blue),
                _StatCard('Pending', controller.pendingCount, Colors.orange),
                _StatCard('Done', controller.completedCount, Colors.green),
              ],
            ),
          )),

          // FILTERS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => Row(
                  children: ['all', 'pending', 'completed'].map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(status.toUpperCase()),
                        selected: controller.selectedStatus.value == status,
                        onSelected: (_) => controller.setStatusFilter(status),
                      ),
                    );
                  }).toList(),
                )),
                const SizedBox(height: 12),
                const Text('Category:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Obx(() => Wrap(
                  spacing: 8,
                  children: controller.allCategories.map((cat) {
                    return FilterChip(
                      label: Text(cat),
                      selected: controller.selectedCategory.value == cat,
                      onSelected: (_) => controller.setCategoryFilter(cat),
                    );
                  }).toList(),
                )),
              ],
            ),
          ),

          // SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // TASKS LIST
          Expanded(
            child: Obx(() {
              if (controller.displayedTasks.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('No tasks', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.displayedTasks.length,
                itemBuilder: (context, index) {
                  final task = controller.displayedTasks[index];
                  return TaskListTile(
                    task: task,
                    onTap: () {
                      Get.to(() => TaskDetailScreen(task: task));
                    },
                    onToggle: () => controller.toggleCompletion(task.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const TaskDetailScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatCard(this.label, this.count, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count.toString(),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}

class TaskListTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const TaskListTile({
    required this.task,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: ListTile(
          leading: Checkbox(value: task.isCompleted, onChanged: (_) => onToggle()),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              color: task.isCompleted ? Colors.grey : Colors.black,
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: task.priorityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  task.priorityLabel,
                  style: TextStyle(color: task.priorityColor, fontSize: 11),
                ),
              ),
              const SizedBox(width: 8),
              Text(task.dueDate.toString().split(' ')[0], style: const TextStyle(fontSize: 11)),
            ],
          ),
          onTap: onTap,
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
