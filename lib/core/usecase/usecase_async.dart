import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class UsecaseAsync<T, Params> {
  TaskEither<Failure, T> call(Params params);
}
