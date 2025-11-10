import 'package:equatable/equatable.dart';

enum TaskPriority { low, medium, high }

enum TaskStatus { pending, inProgress, completed, canceled }

abstract class ManagerTaskEntity extends Equatable {
  final String title;
  final TaskPriority priority;
  final String assignedTo;
  final String dueDate;
  final TaskStatus status;
  final String comments;

  const ManagerTaskEntity({
    required this.title,
    required this.priority,
    required this.assignedTo,
    required this.dueDate,
    required this.status,
    required this.comments,
  });
}
