import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase_async.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';

class DeleteTaskUsecase implements UsecaseAsync<void, DeleteTaskParams> {
  final ManagerTaskRepository repository;

  DeleteTaskUsecase({required this.repository});

  @override
  TaskEither<Failure, void> call(DeleteTaskParams params) {
    return repository.deleteTask(params.taskId);
  }
}

class DeleteTaskParams extends Equatable {
  final String taskId;
  const DeleteTaskParams({required this.taskId});
  @override
  List<Object?> get props => [taskId];
}
