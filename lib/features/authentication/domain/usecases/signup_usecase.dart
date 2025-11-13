import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/usecase/usecase.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user_entity.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class SignupUsecase implements Usecase<void, SignUpParams> {
  final AuthenticationRepository repository;
  SignupUsecase({required this.repository});

  @override
  TaskEither<Failure, void> call(SignUpParams params) {
    return repository.signUp(
      params.email,
      params.password,
      params.name,
      params.role,
    );
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String name;
  final Role role;

  const SignUpParams({
    required this.name,
    required this.role,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
