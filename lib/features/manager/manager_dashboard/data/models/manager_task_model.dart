import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/task_comment_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/manager_task_entity.dart';

class ManagerTaskModel {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final String? assignedTo;
  final DateTime? dueDate;
  final TaskStatus status;
  final DateTime createdAt;
  // The model contains a list of OTHER models, not entities.
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
    // Parse the nested comments from the JSON
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
      comments: commentsList, // Assign the parsed model list
    );
  }

  // Mapper method to convert the data model to a domain entity
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
      // Convert the list of comment models to a list of comment entities
      comments: comments
          .map((commentModel) => commentModel.toEntity())
          .toList(),
    );
  }
}
