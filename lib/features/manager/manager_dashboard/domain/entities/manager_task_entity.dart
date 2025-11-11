import 'package:equatable/equatable.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/task_comment_entity.dart';

// Enums remain the same
enum TaskPriority { low, medium, high, urgent }

enum TaskStatus { pending, in_progress, completed, cancelled }

class ManagerTaskEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final String? assignedTo;
  final DateTime? dueDate;
  final TaskStatus status;
  final DateTime createdAt;
  final List<TaskCommentEntity> comments;

  const ManagerTaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    this.assignedTo,
    this.dueDate,
    required this.status,
    required this.createdAt,
    this.comments = const [],
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    priority,
    assignedTo,
    dueDate,
    status,
    createdAt,
    comments,
  ];
}
