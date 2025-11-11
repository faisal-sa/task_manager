import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase_async.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';

class CreateTaskUsecase
    implements UsecaseAsync<ManagerTaskEntity, CreateTaskParams> {
  final ManagerTaskRepository repository;

  CreateTaskUsecase({required this.repository});

  @override
  TaskEither<Failure, ManagerTaskEntity> call(CreateTaskParams params) {
    return repository.createTask(params.toMap());
  }
}

class CreateTaskParams extends Equatable {
  final String title;
  final String? description;
  final String priority;
  final String? assignedTo;
  final DateTime? dueDate;

  const CreateTaskParams({
    required this.title,
    this.description,
    required this.priority,
    this.assignedTo,
    this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'assigned_to': assignedTo,
      'due_date': dueDate?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    title,
    description,
    priority,
    assignedTo,
    dueDate,
  ];
}
