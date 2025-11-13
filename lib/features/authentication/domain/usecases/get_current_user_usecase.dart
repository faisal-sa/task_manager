import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUsecase implements Usecase<UserEntity, NoParams> {
  final AuthenticationRepository repository;
  GetCurrentUserUsecase({required this.repository});

  @override
  TaskEither<Failure, UserEntity> call(NoParams params) {
    return repository.getCurrentUser();
  }
}
