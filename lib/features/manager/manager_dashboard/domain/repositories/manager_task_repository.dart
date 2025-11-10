import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/manager_task_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class ManagerTaskRepository {
  TaskEither<Error, List<ManagerTaskEntity>> getAllTasks();
  TaskEither<Error, ManagerTaskEntity> getTask(String id);
  TaskEither<Error, ManagerTaskEntity> createTask(ManagerTaskEntity task);
  TaskEither<Error, ManagerTaskEntity> updateTask(ManagerTaskEntity task);
  TaskEither<Error, void> deleteTask(String id);
  TaskEither<Error, ManagerTaskEntity> addComment(
    String taskId,
    String comment,
  );
}
