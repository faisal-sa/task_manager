import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/data_sources/remote/manager_task_remote_data_source.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/manager_task_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/task_comment_model.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/data/models/user_profile_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/task_comment_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/user_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';

class ManagerTaskRepositoryImpl implements ManagerTaskRepository {
  final ManagerTaskRemoteDataSource remoteDataSource;

  ManagerTaskRepositoryImpl({required this.remoteDataSource});

  @override
  TaskEither<Failure, List<ManagerTaskEntity>> getAllTasks() {
    return _tryCatch<List<ManagerTaskModel>>(
      () => remoteDataSource.getAllTasks(),
    ).map((models) => models.map((model) => model.toEntity()).toList());
  }

  @override
  TaskEither<Failure, List<UserEntity>> getAllEmployees() {
    // The previous implementation relied on inheritance. The new one explicitly maps.
    return _tryCatch<List<UserProfileModel>>(
      () => remoteDataSource.getAllEmployees(),
    ).map((userModels) => userModels.map((model) => model.toEntity()).toList());
  }

  @override
  TaskEither<Failure, ManagerTaskEntity> createTask(
    Map<String, dynamic> taskData,
  ) {
    return _tryCatch<ManagerTaskModel>(
      () => remoteDataSource.createTask(taskData),
    ).map((model) => model.toEntity());
  }

  @override
  TaskEither<Failure, ManagerTaskEntity> updateTask(
    String taskId,
    Map<String, dynamic> taskData,
  ) {
    return _tryCatch<ManagerTaskModel>(
      () => remoteDataSource.updateTask(taskId, taskData),
    ).map((model) => model.toEntity());
  }

  @override
  TaskEither<Failure, void> deleteTask(String taskId) {
    // This method returns void, so no mapping is needed.
    return _tryCatch<void>(() => remoteDataSource.deleteTask(taskId));
  }

  @override
  TaskEither<Failure, TaskCommentEntity> addComment(
    String taskId,
    String comment,
  ) {
    return _tryCatch<TaskCommentModel>(
      () => remoteDataSource.addComment(taskId, comment),
    ).map((model) => model.toEntity());
  }

  // The helper function is generic and remains unchanged.
  TaskEither<Failure, T> _tryCatch<T>(Future<T> Function() f) {
    return TaskEither.tryCatch(f, (error, stackTrace) {
      if (error is PostgrestException) {
        return ServerFailure(error.message);
      }
      if (error is AuthException) {
        return ServerFailure(error.message);
      }
      return ServerFailure(error.toString());
    });
  }
}
