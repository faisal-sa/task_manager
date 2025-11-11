import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthenticationRepository {
  TaskEither<Failure, User> getCurrentUser();
  TaskEither<Failure, User> login(String email, String password);
  TaskEither<Failure, void> signOut();
  TaskEither<Failure, void> signUp();
}
