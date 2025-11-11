import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase_async.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/task_comment_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';

class AddCommentUsecase
    implements UsecaseAsync<TaskCommentEntity, AddCommentParams> {
  final ManagerTaskRepository repository;

  AddCommentUsecase({required this.repository});

  @override
  TaskEither<Failure, TaskCommentEntity> call(AddCommentParams params) {
    return repository.addComment(params.taskId, params.comment);
  }
}

class AddCommentParams extends Equatable {
  final String taskId;
  final String comment;

  const AddCommentParams({required this.taskId, required this.comment});

  @override
  List<Object?> get props => [taskId, comment];
}
