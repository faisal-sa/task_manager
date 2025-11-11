import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase_async.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/entities/user_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/manager_dashboard/domain/repositories/manager_task_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllEmployeesUsecase
    implements UsecaseAsync<List<UserEntity>, NoParams> {
  final ManagerTaskRepository repository;

  GetAllEmployeesUsecase({required this.repository});

  @override
  TaskEither<Failure, List<UserEntity>> call(NoParams params) {
    return repository.getAllEmployees();
  }
}
