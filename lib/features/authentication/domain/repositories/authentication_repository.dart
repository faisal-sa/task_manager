import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthenticationRepository {
  TaskEither<Failure, UserEntity> getCurrentUser();
  TaskEither<Failure, UserEntity> login(String email, String password);
  TaskEither<Failure, void> signOut();
  TaskEither<Failure, UserEntity> signUp(
    String name,
    String email,
    String password,
    Role role,
  );
}
