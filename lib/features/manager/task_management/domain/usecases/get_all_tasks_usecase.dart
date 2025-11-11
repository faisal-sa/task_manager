import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/task_management/domain/repositories/manager_task_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllTasksUsecase implements Usecase<List<ManagerTaskEntity>, NoParams> {
  final ManagerTaskRepository repository;

  GetAllTasksUsecase({required this.repository});

  @override
  TaskEither<Failure, List<ManagerTaskEntity>> call(NoParams params) {
    return repository.getAllTasks();
  }
}
