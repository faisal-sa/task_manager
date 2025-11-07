import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

enum TaskStatus { pending, in_progress, completed, cancelled }

enum TaskPriority { low, medium, high, urgent }

@freezed
abstract class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    String? description,
    @Default(TaskStatus.pending) TaskStatus status,
    @Default(TaskPriority.medium) TaskPriority priority,
    @JsonKey(name: 'due_date') DateTime? dueDate,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'assigned_to') String? assignedTo,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
