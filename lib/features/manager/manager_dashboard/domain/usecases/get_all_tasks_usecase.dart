import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase_async.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllTasksUsecase
    implements UsecaseAsync<List<ManagerTaskEntity>, NoParams> {
  final ManagerTaskRepository repository;

  GetAllTasksUsecase({required this.repository});

  @override
  TaskEither<Error, List<ManagerTaskEntity>> call(NoParams params) {
    return repository.getAllTasks();
  }
}

//if class requires Params we define the class like this
// class Params extends Equatable {
//   final int number;

//   const Params({required this.number});

//   @override
//   List<Object?> get props => [number];
// }
