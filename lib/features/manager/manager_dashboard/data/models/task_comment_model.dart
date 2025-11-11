import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/task_comment_entity.dart';

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
