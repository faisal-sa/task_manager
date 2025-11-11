import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/no_params.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignoutUsecase implements Usecase<void, NoParams> {
  final AuthenticationRepository repository;
  const SignoutUsecase({required this.repository});

  @override
  TaskEither<Failure, void> call(NoParams params) {
    return repository.signOut();
  }
}
