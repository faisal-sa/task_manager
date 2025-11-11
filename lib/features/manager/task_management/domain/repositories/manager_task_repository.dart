import 'package:fpdart/fpdart.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/task_comment_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/user_entity.dart';

abstract class ManagerTaskRepository {
  TaskEither<Failure, List<ManagerTaskEntity>> getAllTasks();
  TaskEither<Failure, List<UserEntity>> getAllEmployees();
  TaskEither<Failure, ManagerTaskEntity> createTask(
    Map<String, dynamic> taskData,
  );
  TaskEither<Failure, ManagerTaskEntity> updateTask(
    String taskId,
    Map<String, dynamic> taskData,
  );
  TaskEither<Failure, void> deleteTask(String taskId);
  TaskEither<Failure, TaskCommentEntity> addComment(
    String taskId,
    String comment,
  );
}
