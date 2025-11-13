import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/task_comment_entity.dart';

class TaskCommentModel {
  final String id;
  final String comment;
  final String authorName;
  final DateTime createdAt;

  const TaskCommentModel({
    required this.id,
    required this.comment,
    required this.authorName,
    required this.createdAt,
  });

  factory TaskCommentModel.fromJson(Map<String, dynamic> json) {
    return TaskCommentModel(
      id: json['id'] as String,
      comment: json['comment'] as String,
      authorName:
          (json['profiles'] as Map<String, dynamic>?)?['full_name']
              as String? ??
          'Unknown',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  // Mapper method to convert the data model to a domain entity
  TaskCommentEntity toEntity() {
    return TaskCommentEntity(
      id: id,
      comment: comment,
      authorName: authorName,
      createdAt: createdAt,
    );
  }
}

 // factory ManagerTaskModel.fromJson(Map<String, dynamic> json) {
  //   final commentsList =
  //       (json['task_comments'] as List<dynamic>?)
  //           ?.map(
  //             (commentJson) => TaskCommentModel.fromJson(
  //               commentJson as Map<String, dynamic>,
  //             ),
  //           )
  //           .toList() ??
  //       [];

  //   return ManagerTaskModel(
  //     id: json['id'] as String,
  //     title: json['title'] as String,
  //     description: json['description'] as String?,
  //     priority: TaskPriority.values.firstWhere(
  //       (e) => e.name == json['priority'],
  //       orElse: () => TaskPriority.low,
  //     ),
  //     assignedTo: json['assigned_to'] as String?,
  //     dueDate: json['due_date'] == null
  //         ? null
  //         : DateTime.parse(json['due_date']),
  //     status: TaskStatus.values.firstWhere(
  //       (e) =>
  //           e.name.replaceAll('_', '') ==
  //           (json['status'] as String).replaceAll('_', ''),
  //       orElse: () => TaskStatus.pending,
  //     ),
  //     createdAt: DateTime.parse(json['created_at']),
  //     comments: commentsList,
  //   );
  // }

  // ManagerTaskEntity toEntity() {
  //   return ManagerTaskEntity(
  //     id: id,
  //     title: title,
  //     description: description,
  //     priority: priority,
  //     assignedTo: assignedTo,
  //     dueDate: dueDate,
  //     status: status,
  //     createdAt: createdAt,
  //     comments: comments
  //         .map((commentModel) => commentModel.toEntity())
  //         .toList(),
  //   );
  // }