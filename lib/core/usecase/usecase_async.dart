import 'package:fpdart/fpdart.dart';

abstract class AsyncUseCase<T, Params> {
  TaskEither<Error, T> call(Params params);
}
