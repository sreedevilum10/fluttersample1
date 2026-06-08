// lib/domain/entities/task.dart

import 'package:flutter/material.dart';

/// Task entity - Pure business logic model (no dependencies)
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority; // 'low', 'medium', 'high'
  final bool isCompleted;
  final String category;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    required this.category,
    required this.createdAt,
  });

  // Copy with
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
    bool? isCompleted,
    String? category,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Helpers for UI
  String get priorityLabel => priority[0].toUpperCase() + priority.substring(1);

  Color get priorityColor {
    switch (priority) {
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  bool get isOverdue => !isCompleted && dueDate.isBefore(DateTime.now());

  String get dueDateFormatted => "${dueDate.toLocal()}".split(' ')[0];
}
