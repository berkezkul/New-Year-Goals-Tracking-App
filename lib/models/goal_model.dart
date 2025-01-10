import 'package:flutter/foundation.dart';

enum GoalStatus { notStarted, ongoing, completed, cancelled }

class Goal {
  final String id;
  final String title;
  final String category;
  final String description;
  final DateTime dueDate;
  final int targetAmount;
  final int currentAmount;
  final GoalStatus status;

  Goal({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.dueDate,
    required this.targetAmount,
    required this.currentAmount,
    required this.status,
  });

  factory Goal.fromMap(Map<String, dynamic> map) {
    try {
      debugPrint('Converting map to Goal: $map');
      return Goal(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        category: map['category']!.toString().startsWith('category')
            ? map['category']
            : 'category${map['category']?.toString().capitalize()}' ??
                'categoryAll',
        description: map['description'] ?? '',
        dueDate: DateTime.parse(map['dueDate']),
        targetAmount: map['targetAmount'] ?? 0,
        currentAmount: map['currentAmount'] ?? 0,
        status: _parseStatus(map['status']),
      );
    } catch (e) {
      debugPrint('Error creating Goal from map: $e');
      rethrow;
    }
  }

  static GoalStatus _parseStatus(String? status) {
    switch (status) {
      case 'GoalStatus.completed':
        return GoalStatus.completed;
      case 'GoalStatus.ongoing':
        return GoalStatus.ongoing;
      case 'GoalStatus.cancelled':
        return GoalStatus.cancelled;
      case 'GoalStatus.notStarted':
      default:
        return GoalStatus.notStarted;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'status': status.toString(),
    };
  }

  Goal copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    DateTime? dueDate,
    int? targetAmount,
    int? currentAmount,
    GoalStatus? status,
  }) {
    return Goal(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      status: status ?? this.status,
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
