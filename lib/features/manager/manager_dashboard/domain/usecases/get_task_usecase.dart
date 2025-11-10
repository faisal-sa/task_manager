import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/async_usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/manager_task_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class GetTaskUsecase
    implements AsyncUseCase<TaskEither<Error, ManagerTaskEntity>, Params> {
  final ManagerTaskRepository repository;

  GetTaskUsecase({required this.repository});

  @override
  TaskEither<Error, ManagerTaskEntity> call(Params params) {
    return repository.getTask(params.id);
  }
}

//if class requires Params we define the class like this
class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
