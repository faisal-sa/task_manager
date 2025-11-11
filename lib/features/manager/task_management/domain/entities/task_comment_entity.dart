import 'package:equatable/equatable.dart';

class TaskCommentEntity extends Equatable {
  final String id;
  final String comment;
  final String authorName;
  final DateTime createdAt;

  const TaskCommentEntity({
    required this.id,
    required this.comment,
    required this.authorName,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, comment, authorName, createdAt];
}
