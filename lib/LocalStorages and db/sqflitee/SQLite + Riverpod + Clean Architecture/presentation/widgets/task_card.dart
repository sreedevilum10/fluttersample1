// lib/presentation/widgets/task_card.dart

import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const TaskCard({
    required this.task,
    required this.onTap,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // CHECKBOX
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) => onToggle(),
              activeColor: Colors.green,
            ),
            const SizedBox(width: 8),

            // CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration:
                          task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                      color: task.isCompleted
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // PRIORITY BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: task.priorityColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          task.priorityLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: task.priorityColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // DATE
                      Text(
                        task.dueDateFormatted,
                        style: const TextStyle(
                            fontSize: 10, color: Colors.grey),
                      ),

                      // OVERDUE WARNING
                      if (task.isOverdue) ...[
                        const SizedBox(width: 4),
                        const Icon(
                            Icons.warning,
                            size: 14, color: Colors.orange),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
