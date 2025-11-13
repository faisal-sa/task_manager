import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/entities/user.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  TaskEither<Failure, UserEntity> getCurrentUser() {
    return _tryCatch(
      () => remoteDataSource.getCurrentUser(),
    ).map((userModel) => userModel.toEntity());
  }

  @override
  TaskEither<Failure, UserEntity> login(String email, String password) {
    return _tryCatch(
      () => remoteDataSource.login(email, password),
    ).map((userModel) => userModel.toEntity());
  }

  @override
  TaskEither<Failure, void> signOut() {
    return _tryCatch(() => remoteDataSource.signOut());
  }

  @override
  TaskEither<Failure, UserEntity> signUp(
    String name,
    String email,
    String password,
    Role role,
  ) {
    return _tryCatch(
      () => remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
        role: role,
      ),
    ).map((userModel) => userModel.toEntity());
  }

  TaskEither<Failure, T> _tryCatch<T>(Future<T> Function() f) {
    return TaskEither.tryCatch(f, (error, stackTrace) {
      if (error is AuthException) {
        return ServerFailure(error.message);
      }
      if (error is PostgrestException) {
        return ServerFailure(error.message);
      }
      return ServerFailure("An unexpected error occurred: ${error.toString()}");
    });
  }
}
