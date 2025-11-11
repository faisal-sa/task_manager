import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/data/models/task_comment_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/manager_task_entity.dart';

class ManagerTaskModel {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final String? assignedTo;
  final DateTime? dueDate;
  final TaskStatus status;
  final DateTime createdAt;
  final List<TaskCommentModel> comments;

  const ManagerTaskModel({
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

  factory ManagerTaskModel.fromJson(Map<String, dynamic> json) {
    final commentsList =
        (json['task_comments'] as List<dynamic>?)
            ?.map(
              (commentJson) => TaskCommentModel.fromJson(
                commentJson as Map<String, dynamic>,
              ),
            )
            .toList() ??
        [];

    return ManagerTaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TaskPriority.low,
      ),
      assignedTo: json['assigned_to'] as String?,
      dueDate: json['due_date'] == null
          ? null
          : DateTime.parse(json['due_date']),
      status: TaskStatus.values.firstWhere(
        (e) =>
            e.name.replaceAll('_', '') ==
            (json['status'] as String).replaceAll('_', ''),
        orElse: () => TaskStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at']),
      comments: commentsList,
    );
  }

  ManagerTaskEntity toEntity() {
    return ManagerTaskEntity(
      id: id,
      title: title,
      description: description,
      priority: priority,
      assignedTo: assignedTo,
      dueDate: dueDate,
      status: status,
      createdAt: createdAt,
      comments: comments
          .map((commentModel) => commentModel.toEntity())
          .toList(),
    );
  }
}
